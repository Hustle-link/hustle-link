// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authControllerHash() => r'a0ee279a62538060f1eb0d6b1f10802500e60c1f';

/// An enhanced authentication controller with built-in effect handling.
///
/// This controller provides methods for user registration, sign-in, sign-out,
/// password reset, and profile creation. It uses the `riverpod_community_mutation`
/// package to handle asynchronous operations and state management.
///
/// The controller follows the proper mutation pattern with built-in onSuccess
/// and onError callbacks, eliminating the need for `ref.listen` in UI components.
///
/// Usage pattern:
/// ```dart
/// await controller.signIn(
///   email,
///   password,
///   onSuccess: (_) async => context.goNamed(AppRoutes.homeRoute),
///   onError: (error) async => showErrorSnackbar(error.toString()),
/// );
/// ```
///
/// TODO(refactor): Consolidate the registration methods into a single, more robust method.
/// TODO(enhancement): Add built-in analytics tracking for all authentication events.
/// TODO(security): Implement rate limiting and account lockout for failed attempts.
/// TODO(monitoring): Add comprehensive error logging and monitoring.
///
/// Copied from [AuthController].
@ProviderFor(AuthController)
final authControllerProvider =
    AutoDisposeNotifierProvider<AuthController, AsyncUpdate<void>>.internal(
      AuthController.new,
      name: r'authControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthController = AutoDisposeNotifier<AsyncUpdate<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
