import 'package:extended_image/extended_image.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

// TODO(refactor): This page is currently a placeholder. Implement a proper home page UI.
// TODO(feature): Fetch and display real data instead of dummy cards.

/// The main home page of the application.
///
/// This page is intended to be the landing screen for users, but it currently
/// contains placeholder content and dummy data.
class HomePage extends HookConsumerWidget {
  /// Creates a [HomePage].
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the auth controller to handle actions like signing out.
    final authController = ref.read(authControllerProvider.notifier);

    // Dummy data for placeholder UI.
    // TODO(data): Replace this with a real data source and model.
    final dummyCards = List.generate(
      10,
      (index) => Card(
        child: ListTile(
          title: Text('Card $index'),
          subtitle: Text('This is a dummy card for home page'),
        ),
      ),
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // An extended app bar that can be customized.
          // TODO(ui): Implement a proper app bar with a title and actions.
          ExtendedSliverAppbar(
            // title: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            toolBarColor: Theme.of(context).colorScheme.secondaryContainer,
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          ),
          // A simple text adapter in the scroll view.
          // TODO(ui): Replace with a more meaningful header or content.
          const SliverToBoxAdapter(
            child: Text('Find the best hustle links for you!'),
          ),
          // The main content area of the page.
          ExtendedSliverFillViewport(
            delegate: SliverChildListDelegate([
              // TODO(ui): Display a proper welcome message for the logged-in user.
              // Center(
              //   child: Text(
              //     'Welcome, ${user?.email} ',
              //     style: TextStyle(fontSize: 24),
              //   ),
              // ),
              // Display the list of dummy cards.
              dummyCards.isNotEmpty
                  ? Column(children: dummyCards)
                  : const Text('No cards available'),
              const SizedBox(height: 20),
              // A button to log the user out.
              ElevatedButton(
                onPressed: () async {
                  // call signOut method from auth controller
                  await authController.signOut();
                },
                child: const Text('Log Out'),
              ),
              const SizedBox(height: 20),
              // Placeholder buttons for login and register.
              // TODO(navigation): Implement correct navigation to login/register pages.
              ElevatedButton(onPressed: () {}, child: const Text('Login')),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: const Text('Register')),
            ]),
          ),
        ],
      ),
    );
  }
}
