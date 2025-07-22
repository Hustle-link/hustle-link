import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

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
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges),
    redirect: (context, state) {
      final loggedIn = auth.currentUser != null;
      final isLoginPage = state.path == AppRoutes.login;
      final isRegisterPage = state.path == AppRoutes.register;

      // If the user is logged in, redirect to home
      if (loggedIn) {
        if (isLoginPage || isRegisterPage) {
          return AppRoutes.home;
        }
        return null; // Stay on the current page
      }

      // If the user is not logged in, redirect to login
      if (!loggedIn && !isLoginPage && !isRegisterPage) {
        return AppRoutes.login;
      }

      return null; // No redirection needed
    },
    routes: [
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

  // route names
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String homeRoute = 'home';

  // add more routes as needed
}
