/// An exception carrying a message (now a localization key) safe to display in the UI.
class UserFriendlyException implements Exception {
  /// Holds a localization key instead of raw text.
  final String message;

  /// Optional explicit error code (often the same as [message] key) for analytics.
  final String? code;

  UserFriendlyException(this.message, {this.code});

  @override
  String toString() => message;
}
