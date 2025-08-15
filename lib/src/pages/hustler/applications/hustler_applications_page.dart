import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// A [StreamProvider] that provides a list of job applications for the current hustler.
///
/// It listens to the authentication state and fetches the corresponding applications
/// from the [FirestoreJobService]. If the user is not logged in, it yields an empty list.
final hustlerApplicationsProvider = StreamProvider<List<JobApplication>>((
  ref,
) async* {
  final currentUser = ref.watch(firebaseAuthServiceProvider).currentUser;
  final jobService = ref.watch(firestoreJobServiceProvider);

  if (currentUser == null) {
    yield [];
    return;
  }

  // Yields a stream of job applications for the current user's UID.
  yield* jobService.getApplicationsByHustler(currentUser.uid);
});

/// A page that displays a list of all jobs the current hustler has applied for.
class HustlerApplicationsPage extends HookConsumerWidget {
  /// Creates a [HustlerApplicationsPage].
  const HustlerApplicationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    // Watch the provider to get the list of applications.
    final applications = ref.watch(hustlerApplicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myApplications),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: applications.when(
        // When data is successfully loaded, display the list of applications.
        data: (applicationsList) {
          // If the list is empty, show a message prompting the user to apply for jobs.
          if (applicationsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 80.sp,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    l10n.noApplicationsYet,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    l10n.startApplyingForJobs,
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

          // If there are applications, display them in a list.
          return ListView.builder(
            padding: EdgeInsets.all(4.w),
            itemCount: applicationsList.length,
            itemBuilder: (context, index) {
              final application = applicationsList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: _ApplicationCard(application: application),
              );
            },
          );
        },
        // Show a loading indicator while fetching applications.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Show an error message if fetching applications fails.
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
                l10n.errorLoadingApplications,
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

/// A card widget that displays the details of a single job application.
class _ApplicationCard extends StatelessWidget {
  /// The job application data to display.
  final JobApplication application;

  /// Creates an [_ApplicationCard].
  const _ApplicationCard({required this.application});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with job title and application status.
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        application.jobTitle ?? l10n.jobTitle,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      if (application.hustlerName != null) ...[
                        SizedBox(height: 0.5.h),
                        Text(
                          l10n.appliedAs(application.hustlerName!),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                _ApplicationStatusChip(status: application.status),
              ],
            ),

            SizedBox(height: 3.h),

            // Display the cover letter if it exists.
            if (application.coverLetter != null) ...[
              Text(
                l10n.coverLetter,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  application.coverLetter!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
            ],

            // Application metadata, such as the application date.
            Row(
              children: [
                Icon(
                  Icons.schedule_outlined,
                  size: 16.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 2.w),
                Text(
                  l10n.applied(_getTimeAgo(application.appliedAt, l10n)),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                if (application.status == ApplicationStatus.pending) ...[
                  TextButton(
                    onPressed: () {
                      // TODO(feature): Implement navigation to job details page.
                      // TODO(feature): Implement logic to withdraw an application.
                    },
                    child: Text(l10n.viewJob),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Converts a [DateTime] object to a human-readable time-ago string.
  String _getTimeAgo(DateTime dateTime, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return l10n.ago('${difference.inDays}d');
    } else if (difference.inHours > 0) {
      return l10n.ago('${difference.inHours}h');
    } else if (difference.inMinutes > 0) {
      return l10n.ago('${difference.inMinutes}m');
    } else {
      return l10n.justNow;
    }
  }
}

/// A chip widget that displays the status of an application with a
/// corresponding color and icon.
class _ApplicationStatusChip extends StatelessWidget {
  /// The status of the application.
  final ApplicationStatus status;

  /// Creates an [_ApplicationStatusChip].
  const _ApplicationStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    /// Returns a color based on the application status.
    Color getStatusColor() {
      switch (status) {
        case ApplicationStatus.pending:
          return Colors.orange;
        case ApplicationStatus.reviewed:
          return Colors.blue;
        case ApplicationStatus.accepted:
          return Colors.green;
        case ApplicationStatus.rejected:
          return Colors.red;
      }
    }

    /// Returns a text representation of the application status.
    String getStatusText() {
      switch (status) {
        case ApplicationStatus.pending:
          return l10n.pending;
        case ApplicationStatus.reviewed:
          return l10n.reviewed;
        case ApplicationStatus.accepted:
          return l10n.accepted;
        case ApplicationStatus.rejected:
          return l10n.rejected;
      }
    }

    /// Returns an icon based on the application status.
    IconData getStatusIcon() {
      switch (status) {
        case ApplicationStatus.pending:
          return Icons.schedule;
        case ApplicationStatus.reviewed:
          return Icons.visibility;
        case ApplicationStatus.accepted:
          return Icons.check_circle;
        case ApplicationStatus.rejected:
          return Icons.cancel;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: getStatusColor().withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(getStatusIcon(), size: 14.sp, color: getStatusColor()),
          SizedBox(width: 1.w),
          Text(
            getStatusText(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: getStatusColor(),
            ),
          ),
        ],
      ),
    );
  }
}
