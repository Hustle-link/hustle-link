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

  /// Register a new user with email and password
  Future<void> register(String email, String password) async {
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

    await mutate(
      () async {
        await firebaseAuthService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      },
      onError: (error) {
        // Handle error if needed
        debugPrint('Sign in error: $error');
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Sign in successful');
      },
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
      },
      onSuccess: (data) {
        // Handle success if needed
        debugPrint('Sign out successful');
      },
    );
  }
}
