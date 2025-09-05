import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthErrorAnalyticsLogger {
  void log(String code) {
    debugPrint('[AUTH][ERROR] code=$code');
    // TODO: integrate real analytics (Firebase Analytics, Sentry, etc.)
  }
}

final authErrorAnalyticsLoggerProvider = Provider<AuthErrorAnalyticsLogger>(
  (ref) => AuthErrorAnalyticsLogger(),
);
