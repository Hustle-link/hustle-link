import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// A [StreamProvider] that fetches a list of job postings relevant to the current hustler.
///
/// It first fetches the hustler's profile to get their skills. Then, it uses
/// these skills to query for matching jobs from the [FirestoreJobService].
/// If the hustler has no skills, it defaults to a 'general' category to show all jobs.
final hustlerJobsProvider = StreamProvider<List<JobPosting>>((ref) async* {
  // Depend on the future of the profile provider to ensure profile is loaded.
  final hustlerProfile = await ref.watch(currentHustlerProfileProvider.future);
  final jobService = ref.watch(firestoreJobServiceProvider);

  if (hustlerProfile == null) {
    yield [];
    return;
  }

  // If the hustler has no skills, show all jobs by using a general filter.
  // TODO(filtering): Implement more advanced filtering options beyond skills.
  final skills = hustlerProfile.skills.isEmpty
      ? ['general']
      : hustlerProfile.skills;

  // Subscription is stored on AppUser, not Hustler profile.
  final appUser = await ref.watch(currentUserProfileProvider.future);
  final isSubscribed = appUser?.subscription?.isActive ?? false;

  yield* jobService.getJobsForHustler(skills, limit: isSubscribed ? null : 5);
});

/// The main dashboard page for a "hustler" user.
///
/// Displays a welcome message, a list of jobs matching their skills, and
/// allows them to refresh the job list.
class HustlerDashboardPage extends HookConsumerWidget {
  /// Creates a [HustlerDashboardPage].
  const HustlerDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Watch the hustler's profile and the stream of jobs.
    final hustlerProfile = ref.watch(currentHustlerProfileProvider);
    final jobsStream = ref.watch(hustlerJobsProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.findJobs),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          // TODO(ux): Add a confirmation dialog before signing out.
          IconButton(
            onPressed: () async {
              await authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        // Allows the user to pull-to-refresh the job list.
        onRefresh: () async {
          ref.invalidate(hustlerJobsProvider);
        },
        child: hustlerProfile.when(
          data: (profile) {
            // TODO(ux): Provide a way to create a profile if it's missing.
            if (profile == null) {
              return Center(child: Text(l10n.profileNotFound));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section with a welcome message.
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.welcomeBack(profile.name),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        profile.skills.isEmpty
                            ? l10n.addSkillsToProfile
                            : l10n.jobsMatchingYourSkills(
                                profile.skills.join(', '),
                              ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withAlpha((0.8 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),
                ),

                // Jobs list section.
                Expanded(
                  child: jobsStream.when(
                    data: (jobs) {
                      // If no jobs are found, display a message.
                      if (jobs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_off,
                                size: 64.sp,
                                color: Theme.of(context).colorScheme.onSurface
                                    .withAlpha((0.5 * 255).toInt()),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                l10n.noJobsAvailable,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                profile.skills.isEmpty
                                    ? l10n.addSkillsToProfile
                                    : l10n.checkBackLater,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withAlpha((0.7 * 255).toInt()),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      // Display the list of jobs.
                      return ListView.builder(
                        padding: EdgeInsets.all(4.w),
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return JobCard(job: job);
                        },
                      );
                    },
                    // Show a loading indicator while jobs are being fetched.
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    // Show an error message if fetching jobs fails.
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l10n.errorLoadingJobs(error.toString())),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(hustlerJobsProvider);
                            },
                            child: Text(l10n.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          // Show a loading indicator while the profile is being fetched.
          loading: () => const Center(child: CircularProgressIndicator()),
          // Show an error message if fetching the profile fails.
          error: (error, stack) =>
              Center(child: Text(l10n.errorLoadingProfile(error.toString()))),
        ),
      ),
    );
  }
}

/// A card widget to display a summary of a [JobPosting].
class JobCard extends StatelessWidget {
  /// The job data to display.
  final JobPosting job;

  /// Creates a [JobCard].
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: EdgeInsets.only(bottom: 3.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to the detailed job view when the card is tapped.
          context.pushNamed(
            AppRoutes.jobDetailsRoute,
            pathParameters: {'jobId': job.id},
          );
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with job title and compensation.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (job.employerCompany != null) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            job.employerCompany!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '\$${job.compensation.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Truncated job description.
              Text(
                job.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withAlpha((0.8 * 255).toInt()),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 2.h),

              // A preview of the required skills.
              Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                children: job.skillsRequired.take(3).map((skill) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Shows how many more skills are required if they exceed the preview count.
              if (job.skillsRequired.length > 3) ...[
                SizedBox(height: 1.h),
                Text(
                  l10n.moreSkills((job.skillsRequired.length - 3).toString()),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                  ),
                ),
              ],

              SizedBox(height: 2.h),

              // Footer with location, date, and applicant count.
              Row(
                children: [
                  if (job.location != null) ...[
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      job.location!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Icon(
                    Icons.access_time,
                    size: 16.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    _formatDate(job.createdAt, l10n),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                    ),
                  ),
                  const Spacer(),
                  // TODO(data): Ensure this count is accurate and updated.
                  if (job.applicationsCount != null &&
                      job.applicationsCount! > 0)
                    Text(
                      l10n.applicants(job.applicationsCount.toString()),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Formats a [DateTime] into a human-readable string like "2d ago".
  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return l10n.ago('${difference.inDays}d');
    } else if (difference.inHours > 0) {
      return l10n.ago('${difference.inHours}h');
    } else {
      return l10n.justNow;
    }
  }
}
