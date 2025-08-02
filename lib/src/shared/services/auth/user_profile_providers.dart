import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_providers.g.dart';

/// Provider to get current user's profile
@riverpod
Future<AppUser?> currentUserProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  if (currentUser == null) return null;

  return await userService.getUserProfile(currentUser.uid);
}

/// Provider to get current user's role
@riverpod
Future<UserRole?> currentUserRole(Ref ref) async {
  final userProfile = await ref.watch(currentUserProfileProvider.future);
  if (userProfile == null) return null;

  return UserRole.values.firstWhere(
    (role) => role.value == userProfile.role,
    orElse: () => UserRole.hustler, // Default to hustler
  );
}

/// Provider to get current hustler profile
@riverpod
Future<Hustler?> currentHustlerProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  if (currentUser == null) return null;

  // Check if user is a hustler first
  final userRole = await ref.watch(currentUserRoleProvider.future);
  if (userRole != UserRole.hustler) return null;

  return await userService.getHustlerProfile(currentUser.uid);
}

/// Provider to get current employer profile
@riverpod
Future<Employer?> currentEmployerProfile(Ref ref) async {
  final authService = ref.watch(firebaseAuthServiceProvider);
  final userService = ref.watch(firestoreUserServiceProvider);

  final currentUser = authService.currentUser;
  if (currentUser == null) return null;

  // Check if user is an employer first
  final userRole = await ref.watch(currentUserRoleProvider.future);
  if (userRole != UserRole.employer) return null;

  return await userService.getEmployerProfile(currentUser.uid);
}
