import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';

/// Returns a stable localization key representing an authentication error.
String mapAuthErrorKey(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'invalidEmail';
      case 'user-disabled':
        return 'authUserDisabled';
      case 'user-not-found':
        return 'userNotFound';
      case 'wrong-password':
        return 'authWrongPassword';
      case 'email-already-in-use':
        return 'authEmailInUse';
      case 'weak-password':
        return 'weakPassword';
      case 'network-request-failed':
        return 'authNetworkError';
      case 'too-many-requests':
        return 'authTooManyRequests';
      case 'operation-not-allowed':
        return 'authOpNotAllowed';
    }
  }
  final raw = error.toString();
  if (raw.contains('network')) return 'authNetworkError';
  return 'authGeneric';
}

/// Converts an auth error or key into a localized string using [AppLocalizations].
String localizeAuthError(BuildContext context, Object error) {
  final l10n = AppLocalizations.of(context);
  final key = error is String ? error : mapAuthErrorKey(error);
  switch (key) {
    case 'invalidEmail':
      return l10n.invalidEmail;
    case 'userNotFound':
      return l10n.userNotFound;
    case 'weakPassword':
      return l10n.weakPassword;
    case 'authUserDisabled':
      return l10n.authUserDisabled;
    case 'authWrongPassword':
      return l10n.authWrongPassword;
    case 'authEmailInUse':
      return l10n.authEmailInUse;
    case 'authNetworkError':
      return l10n.authNetworkError;
    case 'authTooManyRequests':
      return l10n.authTooManyRequests;
    case 'authOpNotAllowed':
      return l10n.authOpNotAllowed;
    case 'authPasswordResetFailed':
      return l10n.authPasswordResetFailed;
    case 'authGeneric':
    default:
      return l10n.authGeneric;
  }
}
