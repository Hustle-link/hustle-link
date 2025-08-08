import 'dart:io';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_hustler_profile_controller.g.dart';

@riverpod
class EditHustlerProfileController extends _$EditHustlerProfileController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> uploadProfileImage(String uid, File file) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    state = const AsyncLoading();
    try {
      await storage.uploadProfileImage(uid, file);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> uploadCertification(
    String uid,
    File file,
    String fileName,
  ) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    state = const AsyncLoading();
    try {
      await storage.uploadCertification(uid, file, fileName);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> saveProfile(Hustler original, Hustler updated) async {
    final userService = ref.read(firestoreUserServiceProvider);
    state = const AsyncLoading();
    try {
      await userService.updateHustlerProfile(original.uid, updated);
      // refresh
      ref.invalidate(currentHustlerProfileProvider);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
