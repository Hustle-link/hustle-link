import 'package:flutter/material.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'auth_controller.g.dart';

/// An authentication controller that manages the user's authentication state.
///
/// This controller provides methods for user registration, sign-in, sign-out,
/// password reset, and profile creation. It uses the `riverpod_community_mutation`
/// package to handle asynchronous operations and state management.
// TODO(refactor): Consolidate the registration methods into a single, more robust method.
@riverpod
class AuthController extends _$AuthController with Mutation {
  @override
  AsyncUpdate<void> build() {
    // Initialize the controller, if needed
    return const AsyncUpdate.idle();
  }

  /// Registers a new user with email, password, name, and role.
  ///
  /// This method creates a Firebase Auth account and then creates a corresponding
  /// user profile in Firestore.
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    await mutate(
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
      },
      onError: (error) {
        // Handle error with user-friendly message
        debugPrint('Registration error: $error');
        final userFriendlyError = AuthErrorHandler.getRegistrationErrorMessage(
          error,
        );
        throw Exception(userFriendlyError);
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Registration successful');
      },
    );

    // Optionally, you can return the result of the mutation
    return;
  }

  /// Registers a new user with email and password.
  ///
  /// This is a legacy method and should be replaced with the more comprehensive
  /// `register` method.
  @Deprecated('Use register method with profile creation instead')
  Future<void> registerLegacy(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    //
    await mutate(
      () async {
        await firebaseAuthService.registerWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
      onError: (error) {
        // Handle error with user-friendly message
        debugPrint('Registration error: $error');
        final userFriendlyError = AuthErrorHandler.getRegistrationErrorMessage(
          error,
        );
        throw Exception(userFriendlyError);
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Registration successful');
      },
    );

    // Optionally, you can return the result of the mutation
    return;
  }

  /// Signs in a user with their email and password.
  Future<void> signIn(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    try {
      await mutateAsync(() async {
        await firebaseAuthService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      });
      debugPrint('Sign in successful');
    } catch (error) {
      // Handle error with user-friendly message
      debugPrint('Sign in error: $error');
      final userFriendlyError = AuthErrorHandler.getLoginErrorMessage(error);
      throw Exception(userFriendlyError);
    }
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    await mutate(
      () async {
        await firebaseAuthService.signOut();
      },
      onError: (error) {
        // Handle error if needed
        debugPrint('Sign out error: $error');
        throw Exception('Sign out failed: $error');
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Sign out successful');
      },
    );
  }

  /// Sends a password reset email to the specified email address.
  Future<void> resetPassword(String email) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await mutate(
      () async {
        await firebaseAuthService.sendPasswordResetEmail(email: email);
      },
      onError: (error) {
        debugPrint('Password reset error: $error');
        final userFriendlyError = AuthErrorHandler.getPasswordResetErrorMessage(
          error,
        );
        throw Exception(userFriendlyError);
      },
      onSuccess: (data) {
        debugPrint('Password reset email sent');
      },
    );
  }

  /// Creates a user profile in Firestore after a user has been authenticated.
  ///
  /// This method is typically called after a user has registered and needs their
  /// profile to be created.
  Future<void> createUserProfile({
    required String name,
    required UserRole role,
  }) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    await mutate(
      () async {
        final currentUser = firebaseAuthService.currentUser;
        if (currentUser == null) {
          throw Exception('No authenticated user found');
        }

        // Create user profile in Firestore
        await firestoreUserService.createUserProfile(
          uid: currentUser.uid,
          email: currentUser.email ?? '',
          name: name,
          role: role,
        );
      },
      onError: (error) {
        debugPrint('Profile creation error: $error');
        final userFriendlyError = AuthErrorHandler.getFirebaseAuthErrorMessage(
          error,
        );
        throw Exception(userFriendlyError);
      },
      onSuccess: (data) {
        debugPrint('Profile creation successful');
      },
    );
  }
}
