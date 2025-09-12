import 'package:flutter/foundation.dart';

/// Debug helper for tracking authentication operations
class AuthDebugHelper {
  static const String _tag = '[AUTH_DEBUG]';

  /// Log sign-in attempt
  static void logSignInStart(String email) {
    debugPrint('$_tag Sign-in started for: ${_maskEmail(email)}');
  }

  /// Log sign-in success
  static void logSignInSuccess(String uid) {
    debugPrint('$_tag Sign-in successful for UID: $uid');
  }

  /// Log sign-in error
  static void logSignInError(Object error) {
    debugPrint('$_tag Sign-in error: $error');
  }

  /// Log mutation state changes
  static void logMutationState(String operation, String state) {
    debugPrint('$_tag Mutation [$operation]: $state');
  }

  /// Log Firebase Auth state
  static void logFirebaseAuthState(String? uid) {
    debugPrint('$_tag Firebase Auth State: ${uid ?? 'No user signed in'}');
  }

  /// Mask email for privacy in logs
  static String _maskEmail(String email) {
    if (email.contains('@')) {
      final parts = email.split('@');
      final username = parts[0];
      final domain = parts[1];
      final maskedUsername = username.length <= 3
          ? '*' * username.length
          : '${username.substring(0, 2)}${'*' * (username.length - 2)}';
      return '$maskedUsername@$domain';
    }
    return '*' * email.length;
  }
}
