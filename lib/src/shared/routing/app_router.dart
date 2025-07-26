import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_router.g.dart';

// gorouter refresh stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    // Initialize the stream
    notifyListeners();
    subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late StreamSubscription<dynamic> subscription;

  // Add methods to update the stream
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

final appRouteProvider = Provider<GoRouter>((ref) {
  // watch the auth provider to get the auth state
  final auth = ref.watch(firebaseAuthServiceProvider);

  // watch the shared preferences provider to get the first time open app state
  final sharedPrefs = ref.watch(welcomePageSharedPreferencesProvider);

  // allow navigation to register page
  final allowNavToRegister = ref.watch(allowNavToRegisterProvider);
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges),
    redirect: (context, state) async {
      // get the shared preferences instance
      final firstTimeOpenApp = sharedPrefs.asData?.value;

      // If the app is opened for the first time, redirect to welcome page
      if (firstTimeOpenApp == true && state.path != AppRoutes.login) {
        // If first time opening the app, redirect to welcome page
        return '/welcome';
      }

      // debug print for shared preferences
      debugPrint('Shared Preferences: $firstTimeOpenApp');
      //todo: remove debug print statements in production
      debugPrint('Auth state changed: ${auth.currentUser?.uid}');
      debugPrint('Redirecting: ${state.path}');
      // Check if the user is logged in
      final loggedIn = auth.currentUser?.uid != null;
      final isLoginPage = state.path == AppRoutes.login;
      final isRegisterPage = state.path == AppRoutes.register;

      // debug print statements for allowNavToRegister
      debugPrint('Allow navigation to register: $allowNavToRegister');

      // If the user is logged in, redirect to home
      if (loggedIn && (isLoginPage || isRegisterPage)) {
        // If logged in, don't allow access to login/register
        return AppRoutes.home;
      }
      if (!loggedIn &&
          !(isLoginPage || isRegisterPage) &&
          !allowNavToRegister) {
        // If not logged in and not on login/register, redirect to login
        return AppRoutes.login;
      } else if (!loggedIn && isRegisterPage && !allowNavToRegister) {
        // If not logged in and on register page, redirect to login
        return AppRoutes.login;
      } else if (!loggedIn && !isRegisterPage && allowNavToRegister) {
        // If not logged in and not register page, allow navigation
        return AppRoutes.register;
      }
      // Otherwise, allow navigation
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: AppRoutes.welcomeRoute,
        builder: (context, state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginRoute,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerRoute,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeRoute,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
  );
});

// app routes
class AppRoutes {
  // paths
  // auth routes
  static const String login = '/login';
  static const String register = '/register';
  // home page
  static const String home = '/';
  // welcome page
  static const String welcome = '/welcome';

  // route names
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String homeRoute = 'home';
  static const String welcomeRoute = 'welcome';

  // add more routes as needed
}

class AllowNavToRegisterNotifier extends Notifier<bool> {
  @override
  bool build() {
    // Initially allow navigation to register page
    return false;
  }

  void allowNavigation() {
    state = true;
  }

  void disallowNavigation() {
    state = false;
  }
}

final allowNavToRegisterProvider =
    NotifierProvider<AllowNavToRegisterNotifier, bool>(
      AllowNavToRegisterNotifier.new,
    );

// sharedpreferences for first time opening app
final sharedPrefsFutureProvider = FutureProvider<SharedPreferencesWithCache>((
  ref,
) async {
  return await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );
});

@riverpod
class WelcomePageSharedPreferences extends _$WelcomePageSharedPreferences {
  @override
  Future<bool> build() async {
    // Return the shared preferences instance
    final firstTimeOpenApp = await getFirstTimeOpenApp();
    //todo: remove debug print statements in production
    debugPrint('First time open app: $firstTimeOpenApp');
    return firstTimeOpenApp;
  }

  Future<void> setFirstTimeOpenApp(bool value) async {
    final prefs = await ref.watch(sharedPrefsFutureProvider.future);
    await prefs.setBool('first_time_open_app', value);
  }

  Future<bool> getFirstTimeOpenApp() async {
    final prefs = await ref.watch(sharedPrefsFutureProvider.future);
    return prefs.getBool('first_time_open_app') ?? true;
  }
}
