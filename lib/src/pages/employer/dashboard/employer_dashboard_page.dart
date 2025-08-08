import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

/// A Riverpod provider that fetches the job postings for the currently
/// authenticated employer.
///
/// It yields a list of [JobPosting] objects.
// TODO(caching): Implement caching for the job postings to reduce Firestore reads.
final employerJobsProvider = StreamProvider<List<JobPosting>>((ref) async* {
  final currentUser = ref.watch(firebaseAuthServiceProvider).currentUser;
  final jobService = ref.watch(firestoreJobServiceProvider);

  if (currentUser == null) {
    yield [];
    return;
  }

  yield* jobService.getJobsByEmployer(currentUser.uid);
});

/// A widget that displays the employer's dashboard.
///
/// This dashboard shows the employer's profile information, statistics about their
/// job postings, and a list of their current jobs.
class EmployerDashboardPage extends HookConsumerWidget {
  /// Creates a new instance of [EmployerDashboardPage].
  const EmployerDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employerProfile = ref.watch(currentEmployerProfileProvider);
    final jobsStream = ref.watch(employerJobsProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to post job page within employer shell
          context.push(AppRoutes.employerPostJob);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(employerJobsProvider);
        },
        child: employerProfile.when(
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
                        'Welcome, ${profile.name}!',
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
                        profile.companyName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats section
                Container(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Posted Jobs',
                          value: '${profile.postedJobs ?? 0}',
                          icon: Icons.work_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: _StatCard(
                          title: 'Rating',
                          value: profile.rating != null
                              ? '${profile.rating!.toStringAsFixed(1)}⭐'
                              : 'N/A',
                          icon: Icons.star_outline,
                          color: Theme.of(context).colorScheme.secondary,
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
                                'No jobs posted yet',
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
                                'Create your first job posting to find talent',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 3.h),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Navigate to post job page
                                  context.push(AppRoutes.employerPostJob);
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Post a Job'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return EmployerJobCard(job: job);
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
                              ref.invalidate(employerJobsProvider);
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

/// A widget that displays a single statistic in a card format.
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  /// Creates a new instance of [_StatCard].
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.sp, color: color),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays a summary of a job posting in a card format.
///
/// This card is intended for use in the employer's dashboard.
class EmployerJobCard extends StatelessWidget {
  /// The job posting to display.
  final JobPosting job;

  /// Creates a new instance of [EmployerJobCard].
  const EmployerJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 3.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to job details within the same shell and preserve back stack
          context.pushNamed(
            AppRoutes.employerJobDetailsRoute,
            pathParameters: {'jobId': job.id},
          );
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job title and status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(job.status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      job.status.value.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(job.status),
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 2.h),

              // Job stats
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 16.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    '${job.applicationsCount ?? 0} applicants',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.attach_money,
                    size: 16.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  Text(
                    '\$${job.compensation.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(job.createdAt),
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

  /// Returns a color based on the job's status.
  Color _getStatusColor(JobStatus status) {
    switch (status) {
      case JobStatus.active:
        return Colors.green;
      case JobStatus.closed:
        return Colors.red;
      case JobStatus.draft:
        return Colors.orange;
    }
  }

  /// Formats a [DateTime] object into a user-friendly string.
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
