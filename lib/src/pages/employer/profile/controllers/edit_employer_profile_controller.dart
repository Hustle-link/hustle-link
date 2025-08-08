import 'dart:io';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'edit_employer_profile_controller.g.dart';

@riverpod
class EditEmployerProfileController extends _$EditEmployerProfileController
    with Mutation {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate.idle();

  Future<String?> uploadProfileImage(String uid, File file) async {
    final storage = ref.read(firebaseStorageServiceProvider);
    await mutateAsync(() async {
      await storage.uploadProfileImage(uid, file);
    });
    // We return null/ignore value because Mutation state carries success; callers can reload profile
    return null;
  }

  Future<void> saveProfile(Employer original, Employer updated) async {
    final userService = ref.read(firestoreUserServiceProvider);
    await mutateAsync(() async {
      await userService.updateEmployerProfile(original.uid, updated);
      ref.invalidate(currentEmployerProfileProvider);
    });
  }
}
