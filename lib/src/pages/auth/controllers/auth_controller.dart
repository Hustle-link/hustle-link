import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// AuthController to manage authentication state
@riverpod
class AuthController extends _$AuthController {
  @override
  Future<void> build() async {
    // Initialize the controller, if needed
  }

  /// Register a new user with email and password
  Future<void> register(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await firebaseAuthService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// Sign out the current user
  Future<void> signOut() async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await firebaseAuthService.signOut();
    });
  }
}
