import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_job_controller.g.dart';

@riverpod
class PostJobController extends _$PostJobController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> postJob({
    required String title,
    required String description,
    required String skillsCsv,
    required String compensationText,
    String? location,
  }) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);

    state = const AsyncLoading();
    try {
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
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
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

    state = const AsyncLoading();
    try {
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
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
