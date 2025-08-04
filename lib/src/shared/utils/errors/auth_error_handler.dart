import 'package:firebase_auth/firebase_auth.dart';
import 'package:hustle_link/src/src.dart';

/// Utility class to handle Firebase Auth errors and convert them to user-friendly messages
class AuthErrorHandler {
  /// Convert FirebaseAuthException to user-friendly error message
  static String getFirebaseAuthErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return FirebaseAuthStrings.userNotFound;
        case 'wrong-password':
          return FirebaseAuthStrings.wrongPassword;
        case 'email-already-in-use':
          return FirebaseAuthStrings.emailAlreadyInUse;
        case 'weak-password':
          return FirebaseAuthStrings.weakPassword;
        case 'operation-not-allowed':
          return FirebaseAuthStrings.operationNotAllowed;
        case 'invalid-email':
          return FirebaseAuthStrings.invalidEmail;
        case 'user-disabled':
          return FirebaseAuthStrings.userDisabled;
        case 'too-many-requests':
          return 'Too many requests. Please try again later.';
        case 'network-request-failed':
          return 'Network error. Please check your connection.';
        case 'invalid-credential':
          return 'Invalid credentials. Please check your email and password.';
        default:
          return error.message ?? FirebaseAuthGeneralStrings.errorOccurred;
      }
    } else if (error is Exception) {
      // Handle other exceptions
      final errorMessage = error.toString();
      if (errorMessage.contains('Registration failed:') ||
          errorMessage.contains('Sign in failed:') ||
          errorMessage.contains('Password reset failed:')) {
        // Extract the original Firebase error from the exception message
        final parts = errorMessage.split(': ');
        if (parts.length > 1) {
          final originalError = parts.last;
          // Try to parse it as a Firebase error
          if (originalError.contains('[firebase_auth/')) {
            final codeMatch = RegExp(
              r'\[firebase_auth/([^\]]+)\]',
            ).firstMatch(originalError);
            if (codeMatch != null) {
              final code = codeMatch.group(1);
              return getFirebaseAuthErrorMessage(
                FirebaseAuthException(code: code!, message: originalError),
              );
            }
          }
        }
      }
      return errorMessage.replaceAll('Exception: ', '');
    }

    return error.toString();
  }

  /// Get user-friendly error message for registration
  static String getRegistrationErrorMessage(dynamic error) {
    final message = getFirebaseAuthErrorMessage(error);
    if (message == FirebaseAuthStrings.emailAlreadyInUse) {
      return 'An account with this email already exists. Please sign in instead.';
    }
    return message;
  }

  /// Get user-friendly error message for login
  static String getLoginErrorMessage(dynamic error) {
    final message = getFirebaseAuthErrorMessage(error);
    if (message == FirebaseAuthStrings.userNotFound ||
        message == FirebaseAuthStrings.wrongPassword) {
      return 'Invalid email or password. Please try again.';
    }
    return message;
  }

  /// Get user-friendly error message for password reset
  static String getPasswordResetErrorMessage(dynamic error) {
    final message = getFirebaseAuthErrorMessage(error);
    if (message == FirebaseAuthStrings.userNotFound) {
      return 'No account found with this email address.';
    }
    return message;
  }
}
