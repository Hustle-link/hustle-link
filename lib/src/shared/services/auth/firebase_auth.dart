import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth.g.dart';

/// Firebase Auth Service
class FirebaseAuthService {
  // get the FirebaseAuth instance
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseAuthService(this.instance);

  /// Register a new user with email and password
  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Registration failed: $e');
      throw Exception('Registration failed: $e');
    } on Exception catch (e) {
      debugPrint('Registration failed: $e');
      throw Exception('Registration failed: $e');
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign in failed: $e');
      throw Exception('Sign in failed: $e');
    } on Exception catch (e) {
      debugPrint('Sign in failed: $e');
      throw Exception('Sign in failed: $e');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await instance.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    } on Exception catch (e) {
      debugPrint('Sign out failed: $e');
      throw Exception('Sign out failed: $e');
    }
  }

  /// Send a password reset email
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await instance.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent to: $email');
    } on FirebaseAuthException catch (e) {
      debugPrint('Password reset failed: $e');
      throw Exception('Password reset failed: $e');
    } on Exception catch (e) {
      debugPrint('Password reset failed: $e');
      throw Exception('Password reset failed: $e');
    }
  }

  /// Get the current user
  User? get currentUser => instance.currentUser;

  // stream of auth state changes
  Stream<User?> get authStateChanges => instance.authStateChanges();
}

// create a provider for firebase auth
final firebaseAuthInstanceProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provider for FirebaseAuthService
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthInstanceProvider);
  return FirebaseAuthService(firebaseAuth);
});

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return firebaseAuthService.authStateChanges;
}
