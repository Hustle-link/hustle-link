import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// Provider for jobs stream for current hustler
final hustlerJobsProvider = StreamProvider<List<JobPosting>>((ref) async* {
  final hustlerProfile = await ref.watch(currentHustlerProfileProvider.future);
  final jobService = ref.watch(firestoreJobServiceProvider);

  if (hustlerProfile == null) {
    yield [];
    return;
  }

  // If hustler has no skills, show all jobs
  final skills = hustlerProfile.skills.isEmpty
      ? ['general']
      : hustlerProfile.skills;

  yield* jobService.getJobsForHustler(skills);
});

class HustlerDashboardPage extends HookConsumerWidget {
  const HustlerDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hustlerProfile = ref.watch(currentHustlerProfileProvider);
    final jobsStream = ref.watch(hustlerJobsProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Jobs'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () async {
              await authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(hustlerJobsProvider);
        },
        child: hustlerProfile.when(
          data: (profile) {
            if (profile == null) {
              return const Center(child: Text('Profile not found'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back, ${profile.name}!',
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
                            ? 'Add skills to your profile to see relevant jobs'
                            : 'Jobs matching your skills: ${profile.skills.join(', ')}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Jobs section
                Expanded(
                  child: jobsStream.when(
                    data: (jobs) {
                      if (jobs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_off,
                                size: 64.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.5),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'No jobs available',
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
                                    ? 'Add skills to your profile to see relevant jobs'
                                    : 'Check back later for new opportunities',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.all(4.w),
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return JobCard(job: job);
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error loading jobs: $error'),
                          ElevatedButton(
                            onPressed: () {
                              ref.invalidate(hustlerJobsProvider);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              Center(child: Text('Error loading profile: $error')),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobPosting job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 3.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to job details page
          // TODO: Implement navigation
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job title and company
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

              // Job description (truncated)
              Text(
                job.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.8),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 2.h),

              // Skills required
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

              if (job.skillsRequired.length > 3) ...[
                SizedBox(height: 1.h),
                Text(
                  '+${job.skillsRequired.length - 3} more skills',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],

              SizedBox(height: 2.h),

              // Footer with location and date
              Row(
                children: [
                  if (job.location != null) ...[
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      job.location!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Icon(
                    Icons.access_time,
                    size: 16.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    _formatDate(job.createdAt),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  if (job.applicationsCount != null &&
                      job.applicationsCount! > 0)
                    Text(
                      '${job.applicationsCount} applicants',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return 'Just now';
    }
  }
}
