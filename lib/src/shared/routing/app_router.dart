import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// part 'app_router.g.dart';

// gorouter refresh stream
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(
    Stream<dynamic> authStream,
    ValueNotifier<dynamic>? welcomeNotifier,
  ) {
    // Listen to auth state changes
    authSubscription = authStream.asBroadcastStream().listen((_) {
      notifyListeners();
    });

    // Listen to welcome page shared preferences changes via ValueNotifier
    if (welcomeNotifier != null) {
      _welcomeNotifier = welcomeNotifier;
      _welcomeNotifier!.addListener(_welcomeListener);
    }
  }

  late StreamSubscription<dynamic> authSubscription;
  ValueNotifier<dynamic>? _welcomeNotifier;

  void _welcomeListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    authSubscription.cancel();
    if (_welcomeNotifier != null) {
      _welcomeNotifier!.removeListener(_welcomeListener);
    }
    super.dispose();
  }
}

final appRouteProvider = Provider<GoRouter>((ref) {
  // watch the auth provider to get the auth state
  final auth = ref.watch(firebaseAuthServiceProvider);
  // welcome page shared preferences
  final firstTimeOpenApp = ref.watch(welcomePageSharedPreferencesProvider);

  // watch the shared preferences provider to get the first time open app state
  final sharedPrefs = ref.watch(welcomePageSharedPreferencesProvider);

  // allow navigation to register page
  final allowNavToRegister = ref.watch(allowNavToRegisterProvider);

  // else show the main app
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(
      auth.authStateChanges,
      ValueNotifier(sharedPrefs.firstTimeOpenApp),
    ),
    observers: [FlutterSmartDialog.observer],
    redirect: (context, state) async {
      // listen to first time open app state
      final firstTimeOpenApp = sharedPrefs;
      // debug print statements for auth state changes
      //todo: remove debug print statements in production
      debugPrint('First time open app: ${firstTimeOpenApp.firstTimeOpenApp}');
      debugPrint('Auth state changed: ${auth.currentUser?.uid}');
      debugPrint('Redirecting: ${state.path}');
      // Check if the user is logged in
      final loggedIn = auth.currentUser?.uid != null;
      final isLoginPage = state.path == AppRoutes.login;
      final isRegisterPage = state.path == AppRoutes.register;

      // debug print statements for allowNavToRegister
      debugPrint('Allow navigation to register: $allowNavToRegister');

      // If first time opening the app, redirect to welcome page
      if (firstTimeOpenApp.firstTimeOpenApp == true &&
          state.path != AppRoutes.welcome) {
        return AppRoutes.welcome;
      }

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
  // error initial page
  static const String errorInitial = '/error_initial';
  // initial loading page
  static const String initialLoading = '/initial_loading';

  // route names
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String homeRoute = 'home';
  static const String welcomeRoute = 'welcome';
  static const String errorInitialRoute = 'error_initial';
  static const String initialLoadingRoute = 'initial_loading';

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

class WelcomePageSharedPreferencesNotifier extends ChangeNotifier {
  bool? _firstTimeOpenApp;
  final Ref ref;

  WelcomePageSharedPreferencesNotifier(this.ref) {
    _init();
  }

  bool? get firstTimeOpenApp => _firstTimeOpenApp;

  Future<void> _init() async {
    _firstTimeOpenApp = await getFirstTimeOpenApp();
    notifyListeners();
  }

  Future<void> setFirstTimeOpenApp(bool value) async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    await prefs.setBool('first_time_open_app', value);
    _firstTimeOpenApp = value;
    notifyListeners();
  }

  Future<bool> getFirstTimeOpenApp() async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    return prefs.getBool('first_time_open_app') ?? true;
  }
}

final welcomePageSharedPreferencesProvider =
    ChangeNotifierProvider<WelcomePageSharedPreferencesNotifier>(
      (ref) => WelcomePageSharedPreferencesNotifier(ref),
    );

// listener for first time open app state
// @riverpod
// Raw<ValueNotifier<bool>> welcomePageSharedPreferences(
//   Ref ref,
// ) {
//   // listen to the shared preferences provider
//   final sharedPrefs = ref.watch(welcomePageSharedPreferencesProvider.future);

//   // intial value
//   final initialValue = ValueNotifier(sharedPrefs.asStream());

//   ref.onDispose(initialValue.dispose);

//   // listen to changes in the shared preferences
//   initialValue.addListener(ref.notifyListeners);

//   // return initial value notifier
//   return initialValue;
// }
