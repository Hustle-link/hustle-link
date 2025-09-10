// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_employer_profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editEmployerProfileControllerHash() =>
    r'ad5491b4164494a4f2e3910a5f306f4e22a18d87';

/// A comprehensive controller for editing an employer's profile.
///
/// This controller manages the state for uploading profile images and saving
/// profile updates. It uses `riverpod_community_mutation` for better state
/// management with idle, loading, success, and error states.
///
/// The mutation provides automatic handling of:
/// - Idle state: No operation in progress
/// - Loading state: Operation in progress
/// - Success state: Operation completed successfully
/// - Error state: Operation failed with error details
///
/// TODO(future): Add support for deleting profile images.
/// TODO(enhancement): Add support for company logo uploads.
/// TODO(optimization): Implement batch operations for multiple updates.
///
/// Copied from [EditEmployerProfileController].
@ProviderFor(EditEmployerProfileController)
final editEmployerProfileControllerProvider =
    AutoDisposeNotifierProvider<
      EditEmployerProfileController,
      AsyncUpdate<void>
    >.internal(
      EditEmployerProfileController.new,
      name: r'editEmployerProfileControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$editEmployerProfileControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$EditEmployerProfileController =
    AutoDisposeNotifier<AsyncUpdate<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
