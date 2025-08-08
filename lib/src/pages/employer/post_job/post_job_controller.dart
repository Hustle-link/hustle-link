import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'post_job_controller.g.dart';

// TODO(refactor): Consider moving the parsing and validation logic into a separate utility or model class to keep the controller cleaner.

/// A controller that handles the business logic for creating and updating job postings.
///
/// This class uses the `riverpod_community_mutation` mixin to manage the state
/// of asynchronous operations (idle, loading, success, error), which is useful
/// for updating the UI accordingly.
@riverpod
class PostJobController extends _$PostJobController with Mutation {
  /// The initial state of the mutation is `idle`.
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  /// Creates a new job posting.
  ///
  /// Takes job details as input, validates them, and then calls the
  /// [FirestoreJobService] to create the document in Firestore.
  Future<void> postJob({
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
  }) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);

    // `mutateAsync` handles setting the state to loading, executing the
    // async work, and then setting the state to success or error.
    await mutateAsync(() async {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('You must be logged in to post a job.');
      }

      // Parse and validate input data.
      // TODO(validation): Add more robust validation for each field.
      final skills = skillsCsv
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final compensation = double.tryParse(compensationText);
      if (compensation == null || compensation <= 0) {
        throw Exception('Enter a valid compensation amount.');
      }

      // Fetch employer profile to include denormalized fields like name and company.
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
        location: (location?.trim().isEmpty ?? true) ? null : location!.trim(),
        employerName: employerName,
        employerCompany: employerCompany,
      );
    });
  }

  /// Updates an existing job posting.
  ///
  /// Takes the `jobId` and new job details, validates them, and then calls
  /// the [FirestoreJobService] to update the document in Firestore.
  Future<void> updateJob({
    required String jobId,
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
  }) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);

    await mutateAsync(() async {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('You must be logged in to update a job.');
      }

      // Parse and validate input data.
      final skills = skillsCsv
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final compensation = double.tryParse(compensationText);
      if (compensation == null || compensation <= 0) {
        throw Exception('Enter a valid compensation amount.');
      }

      // Note: Employer profile details are not updated here as they are tied
      // to the employer's profile, not the individual job posting.
      // final employerProfile = await ref.read(
      //   currentEmployerProfileProvider.future,
      // );
      // final employerName = employerProfile?.name;
      // final employerCompany = employerProfile?.companyName;

      await jobService.updateJobPosting(
        jobId,
        title: title.trim(),
        description: description.trim(),
        skillsRequired: skills,
        compensation: compensation,
        location: (location?.trim().isEmpty ?? true) ? null : location!.trim(),
      );
    });
  }
}
