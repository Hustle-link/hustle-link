// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_hustler_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editHustlerProfileControllerHash() =>
    r'b643521c2f4d453e5144a1f8bd4c41bf4f44ceeb';

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
///
/// Copied from [EditHustlerProfileController].
@ProviderFor(EditHustlerProfileController)
final editHustlerProfileControllerProvider =
    AutoDisposeNotifierProvider<
      EditHustlerProfileController,
      AsyncUpdate<void>
    >.internal(
      EditHustlerProfileController.new,
      name: r'editHustlerProfileControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$editHustlerProfileControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EditHustlerProfileController = AutoDisposeNotifier<AsyncUpdate<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
