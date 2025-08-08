import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

// TODO(refactor): Consider creating a dedicated controller for this page to handle business logic.

/// A page for employers to view and manage their job postings.
///
/// Displays a list of jobs posted by the employer, allowing them to view details,
/// edit, delete, or see applications for each job.
class JobManagementPage extends HookConsumerWidget {
  /// Creates a [JobManagementPage].
  const JobManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the provider that fetches the jobs for the current employer.
    final employerJobs = ref.watch(employerJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the page for posting a new job.
              context.push(AppRoutes.employerPostJob);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Post New Job',
          ),
        ],
      ),
      body: employerJobs.when(
        // When data is successfully loaded, display the list of jobs.
        data: (jobs) {
          // If there are no jobs, show a message prompting the user to post one.
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work_off_outlined,
                    size: 80.sp,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'No Jobs Posted Yet',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Post your first job to start finding hustlers',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.push(AppRoutes.employerPostJob);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Post a Job'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          // If there are jobs, display them in a list.
          return ListView.builder(
            padding: EdgeInsets.all(4.w),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: _JobManagementCard(job: job),
              );
            },
          );
        },
        // Show a loading indicator while fetching jobs.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Show an error message if fetching jobs fails.
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.sp,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: 2.h),
              Text(
                'Error loading jobs',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                error.toString(),
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card widget that displays a summary of a job posting for management purposes.
//
/// Includes job title, status, description, key details, and action buttons
/// for viewing applications, editing, and deleting the job.
class _JobManagementCard extends ConsumerWidget {
  /// The job posting data to display.
  final JobPosting job;

  /// Creates a [_JobManagementCard].
  const _JobManagementCard({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to the detailed view of the job.
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
              // Header with title and status
              Row(
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
                  _JobStatusChip(status: job.status),
                ],
              ),

              SizedBox(height: 2.h),

              // Job description
              Text(
                job.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.8),
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 3.h),

              // Job details like compensation, location, and post date.
              Wrap(
                spacing: 4.w,
                runSpacing: 1.h,
                children: [
                  _JobDetailChip(
                    icon: Icons.payments_outlined,
                    label: '\$${job.compensation.toStringAsFixed(0)}',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  if (job.location != null)
                    _JobDetailChip(
                      icon: Icons.location_on_outlined,
                      label: job.location!,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  _JobDetailChip(
                    icon: Icons.schedule_outlined,
                    label: _getTimeAgo(job.createdAt),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Skills required for the job.
              if (job.skillsRequired.isNotEmpty) ...[
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
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 2.h),
              ],

              // Statistics and actions
              Row(
                children: [
                  // Application count
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          // TODO(feature): Fetch and display the actual application count.
                          '${job.applicationsCount ?? 0} applications',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action buttons
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Show a bottom sheet with the list of applications.
                          _showApplicationsBottomSheet(context, ref, job);
                        },
                        icon: const Icon(Icons.visibility_outlined),
                        tooltip: 'View Applications',
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigate to edit job page (reuses post job page with job ID).
                          context.push(
                            AppRoutes.employerPostJob,
                            extra: {'editJobId': job.id},
                          );
                        },
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit Job',
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'delete') {
                            _showDeleteConfirmation(context, ref, job);
                          } else if (value == 'close') {
                            _toggleJobStatus(ref, job);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'close',
                            child: Row(
                              children: [
                                Icon(
                                  job.status == JobStatus.active
                                      ? Icons.close
                                      : Icons.refresh,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  job.status == JobStatus.active
                                      ? 'Close Job'
                                      : 'Reopen Job',
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 16.sp,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  'Delete Job',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows a modal bottom sheet displaying the applications for a given job.
  void _showApplicationsBottomSheet(
    BuildContext context,
    WidgetRef ref,
    JobPosting job,
  ) {
    // TODO(feature): Implement a fully featured application viewer.
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return _JobApplicationsView(
            jobId: job.id,
            scrollController: scrollController,
          );
        },
      ),
    );
  }

  /// Shows a confirmation dialog before deleting a job.
  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    JobPosting job,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: Text(
          'Are you sure you want to delete "${job.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              context.pop();
              // TODO(error-handling): Implement more robust loading and error states.
              final jobService = ref.read(firestoreJobServiceProvider);
              try {
                await jobService.deleteJobPosting(job.id);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job deleted successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting job: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Toggles the status of a job between 'active' and 'closed'.
  void _toggleJobStatus(WidgetRef ref, JobPosting job) async {
    // TODO(error-handling): Show feedback to the user on success or failure.
    final jobService = ref.read(firestoreJobServiceProvider);
    final newStatus = job.status == JobStatus.active
        ? JobStatus.closed
        : JobStatus.active;

    try {
      await jobService.updateJobStatus(job.id, newStatus);
    } catch (e) {
      // Handle error, e.g., show a snackbar.
    }
  }

  /// Converts a [DateTime] object to a human-readable time-ago string.
  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

/// A chip that displays the status of a job (e.g., Active, Closed).
class _JobStatusChip extends StatelessWidget {
  /// The status of the job.
  final JobStatus status;

  /// Creates a [_JobStatusChip].
  const _JobStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    /// Returns a color based on the job status.
    Color getStatusColor() {
      switch (status) {
        case JobStatus.active:
          return Colors.green;
        case JobStatus.closed:
          return Colors.orange;
        case JobStatus.draft:
          return Colors.blue;
      }
    }

    /// Returns a text representation of the job status.
    String getStatusText() {
      switch (status) {
        case JobStatus.active:
          return 'Active';
        case JobStatus.closed:
          return 'Closed';
        case JobStatus.draft:
          return 'Draft';
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: getStatusColor().withOpacity(0.3)),
      ),
      child: Text(
        getStatusText(),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: getStatusColor(),
        ),
      ),
    );
  }
}

/// A small chip widget to display a piece of job detail with an icon.
class _JobDetailChip extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The text label to display.
  final String label;

  /// The color of the icon.
  final Color color;

  /// Creates a [_JobDetailChip].
  const _JobDetailChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: color),
        SizedBox(width: 1.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

/// A view that displays the applications for a specific job.
//
/// This is currently a placeholder and needs to be implemented.
class _JobApplicationsView extends ConsumerWidget {
  /// The ID of the job for which to display applications.
  final String jobId;

  /// The scroll controller for the draggable sheet.
  final ScrollController scrollController;

  /// Creates a [_JobApplicationsView].
  const _JobApplicationsView({
    required this.jobId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(feature): Implement a real application list.
    // This would use a provider to get applications for the job.
    // For now, we'll show a placeholder.
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Handle bar for the draggable sheet.
          Container(
            width: 40.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 3.h),

          // Title
          Text(
            'Job Applications',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 3.h),

          // Placeholder content for when there are no applications.
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64.sp,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'No applications yet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
