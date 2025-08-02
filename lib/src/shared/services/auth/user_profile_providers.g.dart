// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserProfileHash() =>
    r'a57822257e67efec933a2eedd8546db4f1eaef57';

/// Provider to get current user's profile
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

/// Provider to get current user's role
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
    r'27a3a8ceb3cae4e7daae2a07c4f694d761fb88ff';

/// Provider to get current hustler profile
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

/// Provider to get current employer profile
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
