import 'dart:io';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'edit_hustler_profile_controller.g.dart';

@riverpod
class EditHustlerProfileController extends _$EditHustlerProfileController
    with Mutation {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  Future<void> uploadProfileImage(String uid, File file) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    await mutateAsync(() async {
      await storage.uploadProfileImage(uid, file);
    });
  }

  Future<void> uploadCertification(
    String uid,
    File file,
    String fileName,
  ) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    await mutateAsync(() async {
      await storage.uploadCertification(uid, file, fileName);
    });
  }

  Future<void> saveProfile(Hustler original, Hustler updated) async {
    final userService = ref.read(firestoreUserServiceProvider);
    await mutateAsync(() async {
      await userService.updateHustlerProfile(original.uid, updated);
      // refresh
      ref.invalidate(currentHustlerProfileProvider);
    });
  }
}
