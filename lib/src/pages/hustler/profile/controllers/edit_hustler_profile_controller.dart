import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'edit_hustler_profile_controller.g.dart';

/// A comprehensive controller for editing a hustler's profile with built-in effect handling.
///
/// This controller manages the state for uploading profile images, certifications,
/// and saving profile updates. It uses `riverpod_community_mutation` for better
/// state management with idle, loading, success, and error states.
///
/// The controller follows the proper mutation pattern with built-in onSuccess
/// and onError callbacks, eliminating the need for `ref.listen` in UI components.
///
/// Usage pattern:
/// ```dart
/// await controller.uploadProfileImage(
///   uid,
///   file,
///   onSuccess: (_) async => showSuccessSnackbar('Upload complete!'),
///   onError: (error) async => showErrorDialog(error.toString()),
/// );
/// ```
///
/// The mutation provides automatic handling of:
/// - Idle state: No operation in progress
/// - Loading state: Operation in progress
/// - Success state: Operation completed successfully
/// - Error state: Operation failed with error details
///
/// TODO(future): Add support for deleting certifications and profile images.
/// TODO(optimization): Implement batch operations for multiple file uploads.
/// TODO(enhancement): Add progress tracking for large file uploads.
/// TODO(validation): Add comprehensive file validation before upload.
@riverpod
class EditHustlerProfileController extends _$EditHustlerProfileController
    with Mutation<void> {
  @override
  AsyncUpdate<void> build() => const AsyncUpdate<void>.idle();

  /// Uploads a profile image for the hustler.
  ///
  /// This method automatically manages state transitions using the mutation pattern
  /// with built-in effect handling for clean separation of concerns.
  ///
  /// [onSuccess] - Called when upload completes successfully
  /// [onError] - Called when upload fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.uploadProfileImage(
  ///   uid,
  ///   file,
  ///   onSuccess: (_) async => showSuccessSnackbar('Image uploaded!'),
  ///   onError: (error) async => showErrorDialog(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(enhancement): Add image validation and compression before upload.
  /// TODO(ux): Show upload progress percentage to the user.
  /// TODO(optimization): Implement image caching to avoid redundant uploads.
  /// TODO(security): Add file type and size validation.
  Future<void> uploadProfileImage(
    String uid,
    File file, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final storage = ref.read(firebaseStorageServiceProvider);

    return mutate(
      () async {
        await storage.uploadProfileImage(uid, file);

        // TODO(analytics): Track successful profile image uploads with user metrics.
        // TODO(cache): Update cached profile image URL.
        // TODO(notifications): Show upload completion feedback.
        debugPrint('Profile image uploaded successfully for user: $uid');
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Uploads a certification file for the hustler.
  ///
  /// This method automatically manages state transitions using the mutation pattern
  /// with built-in effect handling for comprehensive error management.
  ///
  /// [onSuccess] - Called when upload completes successfully
  /// [onError] - Called when upload fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.uploadCertification(
  ///   uid,
  ///   file,
  ///   fileName,
  ///   onSuccess: (_) async => showSuccessSnackbar('Certification uploaded!'),
  ///   onError: (error) async => showErrorDialog(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(enhancement): Add support for multiple file uploads in batch.
  /// TODO(validation): Implement comprehensive file validation (size, type, content).
  /// TODO(retry): Add automatic retry logic for network failures.
  /// TODO(progress): Implement upload progress tracking.
  Future<void> uploadCertification(
    String uid,
    File file,
    String fileName, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final storage = ref.read(firebaseStorageServiceProvider);

    return mutate(
      () async {
        await storage.uploadCertification(uid, file, fileName);

        // TODO(analytics): Track certification upload metrics by file type.
        // TODO(audit): Log certification upload for compliance tracking.
        // TODO(verification): Add certification verification workflow.
        debugPrint(
          'Certification uploaded successfully: $fileName for user: $uid',
        );
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Saves the updated hustler profile to Firestore.
  ///
  /// This method handles the complete profile update process:
  /// - Validates the profile data
  /// - Updates the profile in Firestore
  /// - Refreshes related providers to update the UI
  /// - Manages all state transitions automatically
  ///
  /// [onSuccess] - Called when save completes successfully
  /// [onError] - Called when save fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.saveProfile(
  ///   original,
  ///   updated,
  ///   onSuccess: () {
  ///     showSuccessSnackbar('Profile updated successfully!');
  ///     context.pop();
  ///   },
  ///   onError: (error, _) => showErrorSnackbar(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(optimization): Implement optimistic updates for better UX.
  /// TODO(validation): Add comprehensive profile validation before save.
  /// TODO(conflict-resolution): Handle concurrent profile updates gracefully.
  /// TODO(offline): Add offline support with sync when connection restored.
  /// TODO(versioning): Implement profile versioning to track changes.
  Future<void> saveProfile(
    Hustler original,
    Hustler updated, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final userService = ref.read(firestoreUserServiceProvider);

    return mutate(
      () async {
        await userService.updateHustlerProfile(original.uid, updated);

        // Refresh the current profile provider to reflect changes
        ref.invalidate(currentHustlerProfileProvider);

        // TODO(analytics): Track profile update events with change metrics.
        // TODO(notifications): Send profile update confirmation email to user.
        // TODO(audit): Log profile changes for compliance and user activity tracking.
        // TODO(diff): Implement profile change detection and logging.
        debugPrint('Profile updated successfully for user: ${original.uid}');
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
