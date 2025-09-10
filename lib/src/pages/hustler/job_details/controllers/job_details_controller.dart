import 'package:flutter/foundation.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'job_details_controller.g.dart';

// Note: Using riverpod_community_mutation standard callback types
// for consistent mutation pattern across all controllers

/// A comprehensive controller for managing job details and applications with built-in effect handling.
///
/// This controller handles fetching job details, checking application status,
/// and submitting job applications. It uses `riverpod_community_mutation` for
/// better state management with idle, loading, success, and error states.
///
/// Instead of using `ref.listen` in UI components, you can provide callbacks
/// directly to the controller methods for handling success and error effects.
///
/// The mutation provides automatic handling of:
/// - Idle state: No operation in progress
/// - Loading state: Application submission in progress
/// - Success state: Application submitted successfully
/// - Error state: Application failed with error details
///
/// TODO(enhancement): Add support for withdrawing job applications.
/// TODO(optimization): Implement caching for job details and application status.
/// TODO(validation): Add comprehensive validation before application submission.
@riverpod
class JobDetailsController extends _$JobDetailsController with Mutation<void> {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  /// Fetches a job by its ID.
  ///
  /// Returns the [JobPosting] if found, otherwise null.
  /// This is a simple data fetch operation that doesn't affect mutation state.
  ///
  /// Note: Use the dedicated `jobByIdProvider` for reactive job data fetching
  /// instead of this method when building UI components.
  ///
  /// TODO(caching): Implement local caching for frequently accessed jobs.
  /// TODO(error-handling): Add specific error types for different failure scenarios.
  Future<JobPosting?> getJob(String jobId) {
    final jobService = ref.read(firestoreJobServiceProvider);
    return jobService.getJobById(jobId);
  }

  /// Checks if the current user has applied for a specific job.
  ///
  /// Returns true if an application exists, otherwise false.
  /// This is a simple query operation that doesn't affect mutation state.
  ///
  /// Note: Use the dedicated `hasAppliedProvider` for reactive application
  /// status checking instead of this method when building UI components.
  ///
  /// TODO(caching): Cache application status to reduce redundant queries.
  /// TODO(real-time): Add real-time updates for application status changes.
  Future<bool> hasApplied(String jobId) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);
    final user = auth.currentUser;
    if (user == null) return false;
    return jobService.hasAppliedForJob(jobId, user.uid);
  }

  /// Submits a job application with comprehensive state management.
  ///
  /// This method automatically manages state transitions:
  /// - Sets state to loading when application starts
  /// - Sets state to success when application completes
  /// - Sets state to error if application fails
  ///
  /// [onSuccess] - Called when application is submitted successfully
  /// [onError] - Called when application fails with error details
  ///
  /// Usage with callbacks (recommended):
  /// ```dart
  /// await controller.apply(
  ///   jobId: jobId,
  ///   coverLetter: coverLetter,
  ///   onSuccess: () {
  ///     showSuccessSnackbar('Application submitted successfully!');
  ///     ref.invalidate(hasAppliedProvider(jobId));
  ///   },
  ///   onError: (error, _) => showErrorSnackbar(error.toString()),
  /// );
  /// ```
  ///
  /// Usage with mutation state watching:
  /// ```dart
  /// final controller = ref.watch(jobDetailsControllerProvider);
  /// ElevatedButton(
  ///   onPressed: controller.isLoading ? null : () => controller.apply(jobId: jobId),
  ///   child: controller.when(
  ///     idle: () => Text('Apply Now'),
  ///     loading: () => CircularProgressIndicator(),
  ///     data: (_) => Text('Application Submitted!'),
  ///     error: (error, _) => Text('Application Failed'),
  ///   ),
  /// );
  /// ```
  ///
  /// TODO(validation): Add comprehensive input validation before submission.
  /// TODO(retry): Implement automatic retry logic for network failures.
  /// TODO(offline): Add offline support with sync when connection restored.
  /// TODO(analytics): Track application success rates and user behavior.
  Future<void> apply({
    required String jobId,
    String? coverLetter,
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);

    return mutate(
      () async {
        final user = auth.currentUser;

        if (user == null) {
          throw Exception('You must be logged in to apply for jobs.');
        }

        // Fetch job details to ensure it exists and get required information
        final job = await jobService.getJobById(jobId);
        if (job == null) {
          throw Exception(
            'Job not found. It may have been removed or expired.',
          );
        }

        // Get hustler profile for application details
        final hustler = await ref.read(currentHustlerProfileProvider.future);
        if (hustler == null) {
          throw Exception(
            'Profile not found. Please complete your profile first.',
          );
        }

        // Submit the application
        await jobService.applyForJob(
          jobId: jobId,
          hustlerUid: user.uid,
          employerUid: job.employerUid,
          coverLetter: (coverLetter?.trim().isEmpty ?? true)
              ? null
              : coverLetter!.trim(),
          hustlerName: hustler.name,
          jobTitle: job.title,
        );

        // TODO(analytics): Track successful job application submissions.
        // TODO(notifications): Send application confirmation email to user.
        // TODO(employer-notification): Notify employer of new application.
        // TODO(validation): Add application duplicate checking.
        debugPrint(
          'Job application submitted successfully for job: $jobId by user: ${user.uid}',
        );
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
