import 'package:extended_image/extended_image.dart';
import 'package:extended_sliver/extended_sliver.dart';
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

    // dummy data for home page
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
          ExtendedSliverAppbar(
            // title: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            toolBarColor: Theme.of(context).colorScheme.secondaryContainer,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ),
          SliverToBoxAdapter(
            child: Text('Find the best hustle links for you!'),
          ),
          ExtendedSliverFillViewport(
            delegate: SliverChildListDelegate([
              // Center(
              //   child: Text(
              //     'Welcome, ${user?.email} ',
              //     style: TextStyle(fontSize: 24),
              //   ),
              // ),
              dummyCards.isNotEmpty
                  ? Column(children: dummyCards)
                  : const Text('No cards available'),
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
            ]),
          ),
        ],
      ),
    );
  }
}
