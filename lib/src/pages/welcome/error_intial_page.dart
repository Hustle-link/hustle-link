import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO(ux): Enhance this page with more user-friendly error details and potential actions, like a "Retry" or "Report" button.

/// A simple page used to display an error message.
///
/// This page is typically shown during the app's initialization phase if a
/// critical error occurs that prevents the app from starting correctly.
class ErrorIntialPage extends HookConsumerWidget {
  /// Creates an [ErrorIntialPage].
  ///
  /// Requires an [errorMessage] to display.
  const ErrorIntialPage({super.key, required this.errorMessage});

  /// The error message to be displayed on the page.
  final String errorMessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
