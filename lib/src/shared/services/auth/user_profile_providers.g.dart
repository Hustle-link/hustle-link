// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserProfileHash() =>
    r'a57822257e67efec933a2eedd8546db4f1eaef57';

/// A Riverpod provider that fetches the profile of the currently authenticated user.
/// It depends on [firebaseAuthServiceProvider] to get the current user
/// and [firestoreUserServiceProvider] to fetch the user's profile from Firestore.
///
/// Returns an [AppUser] object if the user is authenticated and their profile exists,
/// otherwise returns `null`.
/// TODO(caching): Implement caching for the user profile to reduce Firestore reads.
///
/// Copied from [currentUserProfile].
@ProviderFor(currentUserProfile)
final currentUserProfileProvider = AutoDisposeFutureProvider<AppUser?>.internal(
  currentUserProfile,
  name: r'currentUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserProfileRef = AutoDisposeFutureProviderRef<AppUser?>;
String _$currentUserRoleHash() => r'd11ac2cd85660edf159cf551e36fa7965ecd0bf2';

/// A Riverpod provider that determines the [UserRole] of the currently authenticated user.
///
/// It depends on the [currentUserProfileProvider] to get the user's profile.
///
/// Returns the user's [UserRole], defaulting to [UserRole.hustler] if the
/// role is not specified or the profile does not exist.
///
/// Copied from [currentUserRole].
@ProviderFor(currentUserRole)
final currentUserRoleProvider = AutoDisposeFutureProvider<UserRole?>.internal(
  currentUserRole,
  name: r'currentUserRoleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRoleRef = AutoDisposeFutureProviderRef<UserRole?>;
String _$currentHustlerProfileHash() =>
    r'dc12a846f9230dce3e72eeb7c55062a3819fe758';

/// A Riverpod provider that fetches the [Hustler] profile of the currently authenticated user.
///
/// It checks the user's role via [currentUserRoleProvider] and only fetches the
/// profile if the user is a [UserRole.hustler].
///
/// Returns a [Hustler] object if the user is a hustler, otherwise `null`.
/// TODO(error-handling): Add more robust error handling for cases where the profile might be inconsistent.
///
/// Copied from [currentHustlerProfile].
@ProviderFor(currentHustlerProfile)
final currentHustlerProfileProvider =
    AutoDisposeFutureProvider<Hustler?>.internal(
      currentHustlerProfile,
      name: r'currentHustlerProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentHustlerProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentHustlerProfileRef = AutoDisposeFutureProviderRef<Hustler?>;
String _$currentEmployerProfileHash() =>
    r'03765ae4484d55200f3ddb36c9c19dfa0f89c21e';

/// A Riverpod provider that fetches the [Employer] profile of the currently authenticated user.
///
/// It checks the user's role via [currentUserRoleProvider] and only fetches the
/// profile if the user is a [UserRole.employer].
///
/// Returns an [Employer] object if the user is an employer, otherwise `null`.
///
/// Copied from [currentEmployerProfile].
@ProviderFor(currentEmployerProfile)
final currentEmployerProfileProvider =
    AutoDisposeFutureProvider<Employer?>.internal(
      currentEmployerProfile,
      name: r'currentEmployerProfileProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentEmployerProfileHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentEmployerProfileRef = AutoDisposeFutureProviderRef<Employer?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
