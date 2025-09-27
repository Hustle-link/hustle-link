import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'job_details_providers.g.dart';

@riverpod
Future<JobPosting?> jobById(Ref ref, String jobId) async {
  final svc = ref.watch(firestoreJobServiceProvider);
  return svc.getJobById(jobId);
}

@riverpod
Future<bool> hasApplied(Ref ref, String jobId) async {
  // Recompute when auth state changes
  ref.watch(authStateChangesProvider);
  final auth = ref.read(firebaseAuthServiceProvider);
  final svc = ref.read(firestoreJobServiceProvider);
  final user = auth.currentUser;
  if (user == null) return false;
  return svc.hasAppliedForJob(jobId, user.uid);
}
