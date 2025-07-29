import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorIntialPage extends HookConsumerWidget {
  const ErrorIntialPage({super.key, required this.errorMessage});
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
