import 'dart:io';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_employer_profile_controller.g.dart';

@riverpod
class EditEmployerProfileController extends _$EditEmployerProfileController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<String?> uploadProfileImage(String uid, File file) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    state = const AsyncLoading();
    try {
      await storage.uploadProfileImage(uid, file);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
    // We return null/ignore value because Mutation state carries success; callers can reload profile
    return null;
  }

  Future<void> saveProfile(Employer original, Employer updated) async {
    final userService = ref.read(firestoreUserServiceProvider);
    state = const AsyncLoading();
    try {
      await userService.updateEmployerProfile(original.uid, updated);
      ref.invalidate(currentEmployerProfileProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
