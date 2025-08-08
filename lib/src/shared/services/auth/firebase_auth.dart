import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth.g.dart';

/// A service class for handling Firebase Authentication.
///
/// This class encapsulates all the Firebase Authentication logic,
/// such as registration, sign-in, sign-out, and password reset.
// TODO(error-handling): Implement more specific error handling for different FirebaseAuthException codes.
class FirebaseAuthService {
  // get the FirebaseAuth instance
  FirebaseAuth instance = FirebaseAuth.instance;

  /// Creates a new instance of [FirebaseAuthService].
  FirebaseAuthService(this.instance);

  /// Registers a new user with the provided [email] and [password].
  ///
  /// Returns a [UserCredential] on successful registration.
  /// Throws an [Exception] if registration fails.
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
      throw Exception('Registration failed: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Registration failed: $e');
      throw Exception('An unexpected error occurred during registration.');
    }
  }

  /// Signs in a user with the provided [email] and [password].
  ///
  /// Returns a [UserCredential] on successful sign-in.
  /// Throws an [Exception] if sign-in fails.
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
      throw Exception('Sign in failed: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Sign in failed: $e');
      throw Exception('An unexpected error occurred during sign in.');
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Throws an [Exception] if sign-out fails.
  Future<void> signOut() async {
    try {
      await instance.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign out failed: $e');
      throw Exception('Sign out failed: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Sign out failed: $e');
      throw Exception('An unexpected error occurred during sign out.');
    }
  }

  /// Sends a password reset email to the specified [email] address.
  ///
  /// Throws an [Exception] if sending the email fails.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await instance.sendPasswordResetEmail(email: email);
      debugPrint('Password reset email sent to: $email');
    } on FirebaseAuthException catch (e) {
      debugPrint('Password reset failed: $e');
      throw Exception('Password reset failed: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Password reset failed: $e');
      throw Exception('An unexpected error occurred during password reset.');
    }
  }

  /// Gets the currently authenticated user.
  ///
  /// Returns the [User] object if a user is signed in, otherwise `null`.
  User? get currentUser => instance.currentUser;

  // stream of auth state changes
  /// A stream of authentication state changes.
  ///
  /// Emits the current [User] when the authentication state changes.
  Stream<User?> get authStateChanges => instance.authStateChanges();
}

// create a provider for firebase auth
/// Provider for the [FirebaseAuth] instance.
final firebaseAuthInstanceProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provider for the [FirebaseAuthService].
///
/// This provider creates an instance of [FirebaseAuthService] and makes it
/// available to the rest of the application.
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthInstanceProvider);
  return FirebaseAuthService(firebaseAuth);
});

/// A Riverpod provider that exposes the stream of authentication state changes.
///
/// This allows other parts of the app to listen to auth state changes and react accordingly.
@riverpod
Stream<User?> authStateChanges(Ref ref) {
  final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
  return firebaseAuthService.authStateChanges;
}
