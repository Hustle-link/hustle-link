import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'post_job_controller.g.dart';

@riverpod
class PostJobController extends _$PostJobController with Mutation {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  Future<void> postJob({
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

  Future<void> updateJob({
    required String jobId,
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
  }) async {
    final jobService = ref.read(firestoreJobServiceProvider);

    await mutateAsync(() async {
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
        location: (location?.trim().isEmpty ?? true) ? null : location!.trim(),
      );
    });
  }
}
