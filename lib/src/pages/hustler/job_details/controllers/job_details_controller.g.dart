// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobDetailsControllerHash() =>
    r'41d304968812063fe59a79af0e5d8c0bb34b9509';

/// A comprehensive controller for managing job details and applications with built-in effect handling.
///
/// This controller handles fetching job details, checking application status,
/// and submitting job applications. It uses `riverpod_community_mutation` for
/// better state management with idle, loading, success, and error states.
///
/// Instead of using `ref.listen` in UI components, you can provide callbacks
/// directly to the controller methods for handling success and error effects.
///
/// The mutation provides automatic handling of:
/// - Idle state: No operation in progress
/// - Loading state: Application submission in progress
/// - Success state: Application submitted successfully
/// - Error state: Application failed with error details
///
/// TODO(enhancement): Add support for withdrawing job applications.
/// TODO(optimization): Implement caching for job details and application status.
/// TODO(validation): Add comprehensive validation before application submission.
///
/// Copied from [JobDetailsController].
@ProviderFor(JobDetailsController)
final jobDetailsControllerProvider =
    AutoDisposeNotifierProvider<
      JobDetailsController,
      AsyncUpdate<void>
    >.internal(
      JobDetailsController.new,
      name: r'jobDetailsControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$jobDetailsControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$JobDetailsController = AutoDisposeNotifier<AsyncUpdate<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
