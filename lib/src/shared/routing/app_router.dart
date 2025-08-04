import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/pages/auth/role_selection/role_selection_page_new.dart';
import 'package:hustle_link/src/pages/auth/password_reset/password_reset_page.dart';
import 'package:hustle_link/src/pages/hustler/dashboard/hustler_dashboard_page.dart';
import 'package:hustle_link/src/pages/hustler/profile/hustler_profile_page.dart';
import 'package:hustle_link/src/pages/hustler/profile/edit_hustler_profile_page.dart';
import 'package:hustle_link/src/pages/hustler/applications/hustler_applications_page.dart';
import 'package:hustle_link/src/pages/hustler/job_details/job_details_page.dart';
import 'package:hustle_link/src/pages/employer/dashboard/employer_dashboard_page.dart';
import 'package:hustle_link/src/pages/employer/profile/employer_profile_page.dart';
import 'package:hustle_link/src/pages/employer/profile/edit_employer_profile_page.dart';
import 'package:hustle_link/src/pages/employer/job_management/job_management_page.dart';
import 'package:hustle_link/src/pages/employer/post_job/post_job_page.dart';
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
      final isResetPasswordPage = state.path == AppRoutes.resetPassword;

      // debug print statements for allowNavToRegister
      debugPrint('Allow navigation to register: $allowNavToRegister');

      // If first time opening the app, redirect to welcome page
      if (firstTimeOpenApp.firstTimeOpenApp == true &&
          state.path != AppRoutes.welcome) {
        return AppRoutes.welcome;
      }

      // If the user is logged in, redirect to home
      if (loggedIn && (isLoginPage || isRegisterPage || isResetPasswordPage)) {
        // If logged in, don't allow access to login/register/reset-password
        return AppRoutes.home;
      }
      if (!loggedIn &&
          !(isLoginPage || isRegisterPage || isResetPasswordPage) &&
          !allowNavToRegister) {
        // If not logged in and not on login/register/reset-password, redirect to login
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
        path: AppRoutes.resetPassword,
        name: AppRoutes.resetPasswordRoute,
        builder: (context, state) {
          return const PasswordResetPage();
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeRoute,
        redirect: (context, state) async {
          final currentUser = auth.currentUser;
          if (currentUser == null) return AppRoutes.login;

          // Get user role from Firestore
          try {
            final userService = ref.read(firestoreUserServiceProvider);
            final userProfile = await userService.getUserProfile(
              currentUser.uid,
            );

            if (userProfile == null) return AppRoutes.roleSelection;

            // Redirect based on role
            if (userProfile.role == UserRole.hustler.value) {
              return AppRoutes.hustlerDashboard;
            } else if (userProfile.role == UserRole.employer.value) {
              return AppRoutes.employerDashboard;
            }

            return AppRoutes.roleSelection; // Fallback
          } catch (e) {
            return AppRoutes.login;
          }
        },
        builder: (context, state) =>
            const AppLoadingScreen(message: 'Setting up your dashboard...'),
      ),

      // Role selection page
      GoRoute(
        path: AppRoutes.roleSelection,
        name: AppRoutes.roleSelectionRoute,
        builder: (context, state) => const RoleSelectionPageNew(),
      ),

      // Hustler routes
      ShellRoute(
        builder: (context, state, child) => HustlerShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.hustlerDashboard,
            name: AppRoutes.hustlerDashboardRoute,
            builder: (context, state) => const HustlerDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.hustlerProfile,
            name: AppRoutes.hustlerProfileRoute,
            builder: (context, state) => const HustlerProfilePage(),
          ),
          GoRoute(
            path: AppRoutes.hustlerEditProfile,
            name: AppRoutes.hustlerEditProfileRoute,
            builder: (context, state) {
              final profileJson = state.extra as Map<String, dynamic>;
              final profile = Hustler.fromJson(profileJson);
              return EditHustlerProfilePage(profile: profile);
            },
          ),
          GoRoute(
            path: AppRoutes.hustlerApplications,
            name: AppRoutes.hustlerApplicationsRoute,
            builder: (context, state) => const HustlerApplicationsPage(),
          ),
          GoRoute(
            path: '${AppRoutes.jobDetails}/:jobId',
            name: AppRoutes.jobDetailsRoute,
            builder: (context, state) {
              final jobId = state.pathParameters['jobId']!;
              return JobDetailsPage(jobId: jobId);
            },
          ),
        ],
      ),

      // Employer routes
      ShellRoute(
        builder: (context, state, child) => EmployerShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.employerDashboard,
            name: AppRoutes.employerDashboardRoute,
            builder: (context, state) => const EmployerDashboardPage(),
          ),
          GoRoute(
            path: AppRoutes.employerProfile,
            name: AppRoutes.employerProfileRoute,
            builder: (context, state) => const EmployerProfilePage(),
          ),
          GoRoute(
            path: AppRoutes.employerEditProfile,
            name: AppRoutes.employerEditProfileRoute,
            builder: (context, state) {
              final profileJson = state.extra as Map<String, dynamic>;
              final profile = Employer.fromJson(profileJson);
              return EditEmployerProfilePage(profile: profile);
            },
          ),
          GoRoute(
            path: AppRoutes.employerJobs,
            name: AppRoutes.employerJobsRoute,
            builder: (context, state) => const JobManagementPage(),
          ),
          GoRoute(
            path: AppRoutes.employerPostJob,
            name: AppRoutes.employerPostJobRoute,
            builder: (context, state) => const PostJobPage(),
          ),
        ],
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
  static const String resetPassword = '/reset-password';
  // home page
  static const String home = '/';
  // welcome page
  static const String welcome = '/welcome';
  // error initial page
  static const String errorInitial = '/error_initial';
  // initial loading page
  static const String initialLoading = '/initial_loading';

  // role selection
  static const String roleSelection = '/role-selection';

  // hustler routes
  static const String hustlerDashboard = '/hustler/dashboard';
  static const String hustlerProfile = '/hustler/profile';
  static const String hustlerEditProfile = '/hustler/profile/edit';
  static const String hustlerApplications = '/hustler/applications';
  static const String jobDetails = '/hustler/job';

  // employer routes
  static const String employerDashboard = '/employer/dashboard';
  static const String employerProfile = '/employer/profile';
  static const String employerEditProfile = '/employer/profile/edit';
  static const String employerJobs = '/employer/jobs';
  static const String employerPostJob = '/employer/post-job';

  // route names
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String resetPasswordRoute = 'reset_password';
  static const String homeRoute = 'home';
  static const String welcomeRoute = 'welcome';
  static const String errorInitialRoute = 'error_initial';
  static const String initialLoadingRoute = 'initial_loading';

  // role selection
  static const String roleSelectionRoute = 'role_selection';

  // hustler route names
  static const String hustlerDashboardRoute = 'hustler_dashboard';
  static const String hustlerProfileRoute = 'hustler_profile';
  static const String hustlerEditProfileRoute = 'hustler_edit_profile';
  static const String hustlerApplicationsRoute = 'hustler_applications';
  static const String jobDetailsRoute = 'job_details';

  // employer route names
  static const String employerDashboardRoute = 'employer_dashboard';
  static const String employerProfileRoute = 'employer_profile';
  static const String employerEditProfileRoute = 'employer_edit_profile';
  static const String employerJobsRoute = 'employer_jobs';
  static const String employerPostJobRoute = 'employer_post_job';

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

/// Shell widget for hustler navigation
class HustlerShell extends ConsumerWidget {
  final Widget child;

  const HustlerShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getCurrentIndex(context),
        onDestinationSelected: (index) => _onTap(context, index),
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment),
            selectedIcon: Icon(
              Icons.assignment,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Applications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;
    if (location.startsWith('/hustler/applications')) return 1;
    if (location.startsWith('/hustler/profile')) return 2;
    return 0; // Dashboard
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.hustlerDashboard);
        break;
      case 1:
        context.go(AppRoutes.hustlerApplications);
        break;
      case 2:
        context.go(AppRoutes.hustlerProfile);
        break;
    }
  }
}

/// Shell widget for employer navigation
class EmployerShell extends ConsumerWidget {
  final Widget child;

  const EmployerShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getCurrentIndex(context),
        onDestinationSelected: (index) => _onTap(context, index),
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            selectedIcon: Icon(
              Icons.dashboard,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.work),
            selectedIcon: Icon(
              Icons.work,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Jobs',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle),
            selectedIcon: Icon(
              Icons.add_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Post Job',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;
    if (location.startsWith('/employer/jobs')) return 1;
    if (location.startsWith('/employer/post-job')) return 2;
    if (location.startsWith('/employer/profile')) return 3;
    return 0; // Dashboard
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.employerDashboard);
        break;
      case 1:
        context.go(AppRoutes.employerJobs);
        break;
      case 2:
        context.go(AppRoutes.employerPostJob);
        break;
      case 3:
        context.go(AppRoutes.employerProfile);
        break;
    }
  }
}

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
