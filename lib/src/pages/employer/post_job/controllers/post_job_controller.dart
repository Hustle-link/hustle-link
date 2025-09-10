import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'post_job_controller.g.dart';

/// A controller for posting and updating job listings.
///
/// This controller manages the state for creating and updating job postings,
/// handling loading, success, and error states using `riverpod_community_mutation`.
// TODO(future): Add more sophisticated validation logic, perhaps using a form validation package.
@riverpod
class PostJobController extends _$PostJobController with Mutation<void> {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  /// Posts a new job with the provided details.
  ///
  /// Uses the mutation pattern with built-in effect handling for clean separation
  /// of business logic and UI effects.
  ///
  /// [onSuccess] - Called when job posting is created successfully
  /// [onError] - Called when job creation fails with error details
  ///
  /// Manages loading and error states during the creation process.
  Future<void> postJob({
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);

    return mutate(
      () async {
        final user = auth.currentUser;
        if (user == null) {
          throw Exception('You must be logged in to post a job.');
        }

        // Parse and validate
        final skills = skillsCsv
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
        final compensation = double.tryParse(compensationText);
        if (compensation == null || compensation <= 0) {
          throw Exception('Enter a valid compensation amount.');
        }

        // Fetch employer profile for display fields
        // TODO(optimization): Consider caching the employer profile to avoid repeated fetches.
        final employerProfile = await ref.read(
          currentEmployerProfileProvider.future,
        );
        final employerName = employerProfile?.name;
        final employerCompany = employerProfile?.companyName;

        await jobService.createJobPosting(
          employerUid: user.uid,
          title: title.trim(),
          description: description.trim(),
          skillsRequired: skills,
          compensation: compensation,
          location: (location?.trim().isEmpty ?? true)
              ? null
              : location!.trim(),
          employerName: employerName,
          employerCompany: employerCompany,
        );

        // TODO(analytics): Track job posting success rates by employer.
        // TODO(notifications): Send job posting confirmation to employer.
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Updates an existing job with the provided details.
  ///
  /// Uses the mutation pattern with built-in effect handling for clean separation
  /// of business logic and UI effects.
  ///
  /// [onSuccess] - Called when job update is completed successfully
  /// [onError] - Called when job update fails with error details
  ///
  /// Manages loading and error states during the update process.
  Future<void> updateJob({
    required String jobId,
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final jobService = ref.read(firestoreJobServiceProvider);

    return mutate(
      () async {
        // Parse
        final skills = skillsCsv
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
        final compensation = double.tryParse(compensationText);
        if (compensation == null || compensation <= 0) {
          throw Exception('Enter a valid compensation amount.');
        }

        await jobService.updateJobPosting(
          jobId,
          title: title.trim(),
          description: description.trim(),
          skillsRequired: skills,
          compensation: compensation,
          location: (location?.trim().isEmpty ?? true)
              ? null
              : location!.trim(),
        );

        // TODO(analytics): Track job update success rates by employer.
        // TODO(notifications): Send job update confirmation to employer.
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
