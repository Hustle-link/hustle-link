import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/initialize.dart';
import 'package:hustle_link/src/shared/routing/app_router.dart';
import 'package:hustle_link/src/src.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // Watch the initialization provider
    final initAsync = ref.watch(firebaseInitProvider);

    // Listen to the result to navigate once ready
    ref.listen(firebaseInitProvider, (previous, next) {
      next.when(
        data: (_) => _onInitialized(),
        error: (err, stack) => _onError(err),
        loading: () {},
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo placeholder or actual logo asset
            Icon(
              Icons.bolt,
              size: 100,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 24),
            Text(
              'Hustle Link',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            if (initAsync.isLoading)
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            if (initAsync.hasError)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error initializing app. Please restart.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onInitialized() async {
    // Artificial delay for branding impact (optional, consider removing for speed)
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Force refresh of prefs to ensure we have latest
    // Not strictly necessary if provider manages itself well, but safe for init
    // Accessing .languageSelected property which is synchronous getter from notifier state
    // but the notifier loads async in constructor.

    // A safer way is to check the router redirection logic which already handles this.
    // We can just go to Home and let the router redirect us if needed.
    // However, since Splash is the initial route, we want to be explicit.

    // Note: The AppRouter redirection logic handles:
    // 1. Language not selected -> SelectLanguage
    // 2. First time open -> Welcome
    // 3. Auth status -> Login vs Home

    // So we can simply navigate to Home, and GoRouter should redirect appropriate
    // if language is missing or user is not logged in.

    context.go(AppRoutes.home);
  }

  void _onError(Object error) {
    debugPrint('Splash Initialization Error: $error');
  }
}
