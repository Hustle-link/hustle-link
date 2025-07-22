import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseAuthServiceProvider).currentUser;
    // auth controller to handle sign out
    final authController = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Welcome, ${user?.email} ',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // call signOut method from auth controller
                await authController.signOut();
              },
              child: const Text('Log Out'),
            ),
            const SizedBox(height: 20),
            // links to login and register pages
            ElevatedButton(onPressed: () {}, child: const Text('Login')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
