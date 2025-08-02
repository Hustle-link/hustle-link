import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_community_mutation/riverpod_community_mutation.dart';

part 'auth_controller.g.dart';

/// AuthController to manage authentication state
@riverpod
class AuthController extends _$AuthController with Mutation {
  @override
  AsyncUpdate<void> build() {
    // Initialize the controller, if needed
    return const AsyncUpdate.idle();
  }

  /// Register a new user with email and password and create profile
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
        // Handle error if needed
        debugPrint('Registration error: $error');
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Registration successful');
      },
    );

    // Optionally, you can return the result of the mutation
    return;
  }

  /// Register a new user with email and password (legacy method)
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
        // Handle error if needed
        debugPrint('Registration error: $error');
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Registration successful');
      },
    );

    // Optionally, you can return the result of the mutation
    return;
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);

    await mutateAsync(
      () async {
        await firebaseAuthService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
      // onError: (error) {
      //   // Handle error if needed
      //   debugPrint('Sign in error: $error');
      //   throw Exception('Sign in failed: $error');
      // },
      // onSuccess: (data) {
      //   // Handle success if needed
      //   debugPrint('Sign in successful');
      // },
    );
  }

  /// Sign out the current user
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

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await mutate(
      () async {
        await firebaseAuthService.sendPasswordResetEmail(email: email);
      },
      onError: (error) {
        debugPrint('Password reset error: $error');
      },
      onSuccess: (data) {
        debugPrint('Password reset email sent');
      },
    );
  }

  /// Create user profile after Firebase Auth registration
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
      },
      onSuccess: (data) {
        debugPrint('Profile creation successful');
      },
    );
  }
}
