import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/utils/user_friendly_exception.dart';
import 'package:hustle_link/src/shared/utils/debug_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'auth_controller.g.dart';

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
@riverpod
class AuthController extends _$AuthController with Mutation<void> {
  @override
  AsyncUpdate<void> build() {
    // Initialize the controller in idle state, ready for operations
    return const AsyncUpdate<void>.idle();
  }

  /// Registers a new user with email, password, name, and role.
  ///
  /// This method creates a Firebase Auth account and then creates a corresponding
  /// user profile in Firestore. Uses the mutation pattern with built-in effect handling.
  ///
  /// [onSuccess] - Called when registration completes successfully
  /// [onError] - Called when registration fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.register(
  ///   email: email,
  ///   password: password,
  ///   name: name,
  ///   role: role,
  ///   onSuccess: (_) async => context.goNamed(AppRoutes.roleSelection),
  ///   onError: (error) async => showErrorSnackbar(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(enhancement): Add email verification step after registration.
  /// TODO(analytics): Track registration success/failure rates by user role.
  /// TODO(validation): Add comprehensive input validation before processing.
  /// TODO(security): Implement password strength requirements and validation.
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    return mutate(
      () async {
        // Create Firebase Auth account
        final userCredential = await firebaseAuthService
            .registerWithEmailAndPassword(email: email, password: password);

        // Create user profile in Firestore
        if (userCredential.user != null) {
          await firestoreUserService.createUserProfile(
            uid: userCredential.user!.uid,
            email: email,
            name: name,
            role: role,
          );
        }

        // TODO(analytics): Track successful registrations with user role metrics.
        // TODO(notifications): Send welcome email to new users.
        // TODO(onboarding): Trigger onboarding flow for new users.
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Registers a new user with email and password.
  ///
  /// This is a legacy method and should be replaced with the more comprehensive
  /// `register` method.
  @Deprecated('Use register method with profile creation instead')
  Future<void> registerLegacy(
    String email,
    String password, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    return mutate(
      () => firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      ),
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Signs in a user with their email and password.
  ///
  /// Uses the mutation pattern with built-in effect handling for clean separation
  /// of business logic and UI effects.
  ///
  /// [onSuccess] - Called when sign-in completes successfully
  /// [onError] - Called when sign-in fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.signIn(
  ///   email,
  ///   password,
  ///   onSuccess: (_) async => context.goNamed(AppRoutes.homeRoute),
  ///   onError: (error) async => showErrorSnackbar(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(security): Add rate limiting for failed sign-in attempts.
  /// TODO(analytics): Track sign-in success/failure rates and error types.
  /// TODO(mfa): Implement multi-factor authentication support.
  /// TODO(session): Add proper session management and token refresh.
  Future<void> signIn(
    String email,
    String password, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    try {
      AuthDebugHelper.logMutationState('signIn', 'starting');

      await mutate(
        () async {
          final userCredential = await firebaseAuthService
              .signInWithEmailAndPassword(email: email, password: password);

          // Verify that sign-in was successful
          if (userCredential.user == null) {
            throw UserFriendlyException(
              'authSignInFailed',
              code: 'authSignInFailed',
            );
          }

          AuthDebugHelper.logMutationState('signIn', 'completed successfully');
          // TODO(analytics): Track successful sign-ins with user metrics.
          // TODO(session): Initialize user session and preferences.
        },
        onSuccess: onSuccess,
        onError: onError,
      );
    } catch (e) {
      AuthDebugHelper.logMutationState('signIn', 'failed with error: $e');
      // Ensure errors are properly handled even if mutation fails
      if (onError != null) {
        await onError(e);
      }
      rethrow;
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Uses the mutation pattern with built-in effect handling for proper
  /// cleanup and navigation after sign-out.
  ///
  /// [onSuccess] - Called when sign-out completes successfully
  /// [onError] - Called when sign-out fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.signOut(
  ///   onSuccess: (_) async => context.goNamed(AppRoutes.loginRoute),
  ///   onError: (error) async => showErrorDialog(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(cleanup): Clear local cache and user data on sign-out.
  /// TODO(analytics): Track sign-out events and session duration.
  /// TODO(security): Implement proper token invalidation.
  /// TODO(state): Clear all user-related providers on sign-out.
  Future<void> signOut({
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    return mutate(
      firebaseAuthService.signOut,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Sends a password reset email to the specified email address.
  ///
  /// Uses the mutation pattern with built-in effect handling for proper
  /// user feedback and state management.
  ///
  /// [onSuccess] - Called when password reset email is sent successfully
  /// [onError] - Called when password reset fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.resetPassword(
  ///   email,
  ///   onSuccess: (_) async => setState(() => sent = true),
  ///   onError: (error) async => setState(() => errorText = error.toString()),
  /// );
  /// ```
  ///
  /// TODO(validation): Verify email exists in system before sending reset.
  /// TODO(rate-limiting): Prevent abuse of password reset functionality.
  /// TODO(analytics): Track password reset usage patterns.
  /// TODO(security): Implement CAPTCHA for repeated reset requests.
  Future<void> resetPassword(
    String email, {
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    return mutate(
      () => firebaseAuthService.sendPasswordResetEmail(email: email),
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Creates a user profile in Firestore after a user has been authenticated.
  ///
  /// This method is typically called after a user has registered and needs their
  /// profile to be created. Uses the mutation pattern with built-in effect handling.
  ///
  /// [onSuccess] - Called when profile creation completes successfully
  /// [onError] - Called when profile creation fails with error details
  ///
  /// Usage:
  /// ```dart
  /// await controller.createUserProfile(
  ///   name: name,
  ///   role: role,
  ///   onSuccess: (_) async => context.goNamed(AppRoutes.homeRoute),
  ///   onError: (error) async => showErrorDialog(error.toString()),
  /// );
  /// ```
  ///
  /// TODO(validation): Add comprehensive profile data validation.
  /// TODO(analytics): Track profile creation success rates by user role.
  /// TODO(onboarding): Trigger role-specific onboarding flows.
  /// TODO(permissions): Set up user permissions based on role.
  Future<void> createUserProfile({
    required String name,
    required UserRole role,
    Future<void> Function(void)? onSuccess,
    Future<void> Function(Object? error)? onError,
  }) {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    return mutate(
      () async {
        final currentUser = firebaseAuthService.currentUser;
        if (currentUser == null) {
          throw UserFriendlyException('No authenticated user found');
        }

        await firestoreUserService.createUserProfile(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          name: name,
          role: role,
        );

        // TODO(analytics): Track profile creation success by role.
        // TODO(notifications): Send profile creation confirmation.
        // TODO(initialization): Initialize role-specific data structures.
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
