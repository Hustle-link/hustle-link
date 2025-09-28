import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_providers.g.dart';

/// A Riverpod provider that fetches the profile of the currently authenticated user.
//
/// It depends on [firebaseAuthServiceProvider] to get the current user
/// and [firestoreUserServiceProvider] to fetch the user's profile from Firestore.
///
/// Returns an [AppUser] object if the user is authenticated and their profile exists,
/// otherwise returns `null`.
/// TODO(caching): Implement caching for the user profile to reduce Firestore reads.
@riverpod
Future<AppUser?> currentUserProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  debugPrint('CurrentUserProfile - Current user: ${currentUser?.uid}');

  if (currentUser == null) {
    debugPrint('CurrentUserProfile - No authenticated user');
    return null;
  }

  debugPrint(
    'CurrentUserProfile - Fetching user profile for: ${currentUser.uid}',
  );
  final result = await userService.getUserProfile(currentUser.uid);
  debugPrint(
    'CurrentUserProfile - Result: ${result != null ? 'Found profile with role: ${result.role}' : 'No profile found'}',
  );
  return result;
}

/// A Riverpod provider that determines the [UserRole] of the currently authenticated user.
///
/// It depends on the [currentUserProfileProvider] to get the user's profile.
///
/// Returns the user's [UserRole], defaulting to [UserRole.hustler] if the
/// role is not specified or the profile does not exist.
@riverpod
Future<UserRole?> currentUserRole(Ref ref) async {
  final userProfile = await ref.watch(currentUserProfileProvider.future);
  debugPrint('CurrentUserRole - User profile: $userProfile');

  if (userProfile == null) {
    debugPrint('CurrentUserRole - No user profile found');
    return null;
  }

  debugPrint('CurrentUserRole - User role from profile: ${userProfile.role}');
  final role = UserRole.values.firstWhere(
    (role) => role.value == userProfile.role,
    orElse: () => UserRole.hustler, // Default to hustler
  );
  debugPrint('CurrentUserRole - Determined role: $role');
  return role;
}

/// A Riverpod provider that fetches the [Hustler] profile of the currently authenticated user.
///
/// It checks the user's role via [currentUserRoleProvider] and only fetches the
/// profile if the user is a [UserRole.hustler].
///
/// Returns a [Hustler] object if the user is a hustler, otherwise `null`.
/// TODO(error-handling): Add more robust error handling for cases where the profile might be inconsistent.
@riverpod
Future<Hustler?> currentHustlerProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  debugPrint('Current user: ${currentUser?.uid}');

  if (currentUser == null) {
    debugPrint('No authenticated user found');
    return null;
  }

  // Check if user is a hustler first
  final userRole = await ref.watch(currentUserRoleProvider.future);
  debugPrint('User role: $userRole');

  if (userRole != UserRole.hustler) {
    debugPrint('User is not a hustler, role: $userRole');
    return null;
  }

  debugPrint('Fetching hustler profile for user: ${currentUser.uid}');
  return await userService.getHustlerProfile(currentUser.uid);
}

/// A Riverpod provider that fetches the [Employer] profile of the currently authenticated user.
///
/// It checks the user's role via [currentUserRoleProvider] and only fetches the
/// profile if the user is a [UserRole.employer].
///
/// Returns an [Employer] object if the user is an employer, otherwise `null`.
@riverpod
Future<Employer?> currentEmployerProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  debugPrint('CurrentEmployerProfile - Current user: ${currentUser?.uid}');

  if (currentUser == null) {
    debugPrint('CurrentEmployerProfile - No authenticated user found');
    return null;
  }

  // Check if user is an employer first
  final userRole = await ref.watch(currentUserRoleProvider.future);
  debugPrint('CurrentEmployerProfile - User role: $userRole');

  if (userRole != UserRole.employer) {
    debugPrint(
      'CurrentEmployerProfile - User is not an employer, role: $userRole',
    );
    return null;
  }

  debugPrint(
    'CurrentEmployerProfile - Fetching employer profile for: ${currentUser.uid}',
  );
  final result = await userService.getEmployerProfile(currentUser.uid);
  debugPrint(
    'CurrentEmployerProfile - Result: ${result != null ? 'Found profile' : 'No profile found'}',
  );
  return result;
}
