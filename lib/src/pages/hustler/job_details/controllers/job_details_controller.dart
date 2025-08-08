import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'job_details_controller.g.dart';

@riverpod
class JobDetailsController extends _$JobDetailsController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<JobPosting?> getJob(String jobId) {
    final jobService = ref.read(firestoreJobServiceProvider);
    return jobService.getJobById(jobId);
  }

  Future<bool> hasApplied(String jobId) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);
    final user = auth.currentUser;
    if (user == null) return false;
    return jobService.hasAppliedForJob(jobId, user.uid);
  }

  Future<void> apply({required String jobId, String? coverLetter}) async {
    final jobService = ref.read(firestoreJobServiceProvider);
    final auth = ref.read(firebaseAuthServiceProvider);
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('You must be logged in to apply.');
    }
    state = const AsyncLoading();
    try {
      final job = await jobService.getJobById(jobId);
      if (job == null) throw Exception('Job not found');
      final hustler = await ref.read(currentHustlerProfileProvider.future);

      await jobService.applyForJob(
        jobId: jobId,
        hustlerUid: user.uid,
        employerUid: job.employerUid,
        coverLetter: (coverLetter?.trim().isEmpty ?? true)
            ? null
            : coverLetter!.trim(),
        hustlerName: hustler?.name,
        jobTitle: job.title,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
