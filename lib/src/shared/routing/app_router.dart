import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/pages/subscribe/subscription_page.dart';
import 'package:hustle_link/src/src.dart';
import 'package:shared_preferences/shared_preferences.dart';

// part 'app_router.g.dart';

// gorouter refresh stream
/// A [ChangeNotifier] that listens to authentication and welcome page state changes
/// to refresh the GoRouter state.
// TODO(refactor): Consider merging auth and welcome logic into a single stream for simplicity.
class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a new instance of [GoRouterRefreshStream].
  ///
  /// It takes an [authStream] to listen for authentication state changes and
  /// an optional [welcomeNotifier] to listen for changes in the welcome page
  /// shared preferences.
  GoRouterRefreshStream(
    Stream<dynamic> authStream,
    List<Listenable> listenables,
  ) {
    // Listen to auth state changes
    authSubscription = authStream.asBroadcastStream().listen((_) {
      notifyListeners();
    });

    // Listen to provided listenables (e.g., welcome & language pref notifiers)
    for (final l in listenables) {
      l.addListener(_otherListener);
      _others.add(l);
    }
  }

  /// The subscription to the authentication state stream.
  late StreamSubscription<dynamic> authSubscription;
  final List<Listenable> _others = [];

  void _otherListener() => notifyListeners();

  @override
  void dispose() {
    authSubscription.cancel();
    for (final l in _others) {
      l.removeListener(_otherListener);
    }
    super.dispose();
  }
}

/// Provider for the [GoRouter] instance.
///
/// This provider creates and configures the GoRouter instance for the app,
/// handling routing, redirection, and authentication.
final appRouteProvider = Provider<GoRouter>((ref) {
  // watch the auth provider to get the auth state
  final auth = ref.watch(firebaseAuthServiceProvider);
  // welcome page shared preferences
  final sharedPrefs = ref.watch(welcomePageSharedPreferencesProvider);
  // language selection shared preferences
  final languagePrefs = ref.watch(languageSelectionSharedPreferencesProvider);

  // allow navigation to register page
  final allowNavToRegister = ref.watch(allowNavToRegisterProvider);

  // else show the main app
  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges, [
      sharedPrefs,
      languagePrefs,
    ]),
    observers: [FlutterSmartDialog.observer],
    // TODO(security): Enhance redirection logic to handle more edge cases and roles.
    redirect: (context, state) async {
      // listen to first time open app state
      final firstTimeOpenApp = sharedPrefs;
      final languageSelected = languagePrefs.languageSelected;
      // debug print statements for auth state changes
      //todo: remove debug print statements in production
      final location = state.uri.path; // Use uri.path for reliable matching
      debugPrint('First time open app: ${firstTimeOpenApp.firstTimeOpenApp}');
      debugPrint('Language selected: $languageSelected');
      debugPrint('Auth state changed: ${auth.currentUser?.uid}');
      debugPrint('Redirecting: $location');
      // Check if the user is logged in
      final loggedIn = auth.currentUser?.uid != null;
      final isLoginPage = location == AppRoutes.login;
      final isRegisterPage = location == AppRoutes.register;
      final isResetPasswordPage = location == AppRoutes.resetPassword;

      // debug print statements for allowNavToRegister
      debugPrint('Allow navigation to register: $allowNavToRegister');

      // If language not selected yet, redirect to select language page
      if (languageSelected != true && location != AppRoutes.selectLanguage) {
        return AppRoutes.selectLanguage;
      }

      // If first time opening the app, redirect to welcome page
      if (firstTimeOpenApp.firstTimeOpenApp == true &&
          location != AppRoutes.welcome &&
          location != AppRoutes.selectLanguage) {
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
        // If not logged in and not on auth pages, redirect to login
        return AppRoutes.login;
      } else if (!loggedIn && isRegisterPage && !allowNavToRegister) {
        // If not logged in and on register page without permission, redirect to login
        return AppRoutes.login;
      } else if (!loggedIn &&
          !isRegisterPage &&
          !isResetPasswordPage &&
          allowNavToRegister) {
        // If not logged in and not on register/reset pages, allow navigation to register
        return AppRoutes.register;
      }
      // Otherwise, allow navigation
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.selectLanguage,
        name: AppRoutes.selectLanguageRoute,
        builder: (context, state) => const LanguageSelectionPage(),
      ),
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
        // TODO(optimization): Cache user profile to avoid repeated lookups on redirect.
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
      // TODO(UI/UX): Consider a more unified ShellRoute for both user roles if possible.
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
          GoRoute(
            path: '${AppRoutes.employerJobDetails}/:jobId',
            name: AppRoutes.employerJobDetailsRoute,
            builder: (context, state) {
              final jobId = state.pathParameters['jobId']!;
              return EmployerJobDetailsPage(jobId: jobId);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.subscription,
        name: AppRoutes.subscriptionRoute,
        builder: (context, state) => const SubscriptionPage(),
      ),
    ],
  );
});

/// A utility class that holds the application's route paths and names.
/// This helps in avoiding typos and provides a centralized place for route management.
// TODO(refactor): Organize routes into nested classes for better structure if the app grows.
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
  // language selection page
  static const String selectLanguage = '/select-language';
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
  static const String employerJobDetails = '/employer/job';
  static const String subscription = '/subscribe';

  // route names
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String resetPasswordRoute = 'reset_password';
  static const String homeRoute = 'home';
  static const String welcomeRoute = 'welcome';
  static const String selectLanguageRoute = 'select_language';
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
  static const String employerJobDetailsRoute = 'employer_job_details';
  static const String subscriptionRoute = 'subscription';

  // add more routes as needed
}

/// A [Notifier] to control whether navigation to the register page is allowed.
/// This is used to manage the flow between the login and register pages.
class AllowNavToRegisterNotifier extends Notifier<bool> {
  @override
  bool build() {
    // Initially disallow navigation to register page
    return false;
  }

  /// Allows navigation to the register page.
  void allowNavigation() {
    state = true;
  }

  /// Disallows navigation to the register page.
  void disallowNavigation() {
    state = false;
  }
}

/// Provider for the [AllowNavToRegisterNotifier].
final allowNavToRegisterProvider =
    NotifierProvider<AllowNavToRegisterNotifier, bool>(
      AllowNavToRegisterNotifier.new,
    );

/// A [Notifier] to control whether navigation to the reset password page is allowed.
/// This is used to manage the flow between the login and reset password pages.
class AllowNavToResetPasswordNotifier extends Notifier<bool> {
  @override
  bool build() {
    // Initially disallow navigation to reset password page
    return false;
  }

  /// Allows navigation to the reset password page.
  void allowNavigation() {
    state = true;
  }

  /// Disallows navigation to the reset password page.
  void disallowNavigation() {
    state = false;
  }
}

/// Provider for the [AllowNavToResetPasswordNotifier].
final allowNavToResetPasswordProvider =
    NotifierProvider<AllowNavToResetPasswordNotifier, bool>(
      AllowNavToResetPasswordNotifier.new,
    );

/// Provider for a [SharedPreferencesWithCache] instance.
/// This is used to cache shared preferences for performance.
// TODO(optimization): Evaluate if a future provider is the best approach here.
final sharedPrefsFutureProvider = FutureProvider<SharedPreferencesWithCache>((
  ref,
) async {
  return await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );
});

/// A [ChangeNotifier] for managing the 'first time open app' state using SharedPreferences.
/// It provides methods to get and set this value.
class WelcomePageSharedPreferencesNotifier extends ChangeNotifier {
  bool? _firstTimeOpenApp;
  final Ref ref;

  /// Creates a new instance of [WelcomePageSharedPreferencesNotifier].
  WelcomePageSharedPreferencesNotifier(this.ref) {
    _init();
  }

  /// The current value of the 'first time open app' flag.
  bool? get firstTimeOpenApp => _firstTimeOpenApp;

  /// Initializes the notifier by reading the value from SharedPreferences.
  Future<void> _init() async {
    _firstTimeOpenApp = await getFirstTimeOpenApp();
    notifyListeners();
  }

  /// Sets the 'first time open app' flag in SharedPreferences.
  ///
  /// [value] The new boolean value to set.
  Future<void> setFirstTimeOpenApp(bool value) async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    await prefs.setBool('first_time_open_app', value);
    _firstTimeOpenApp = value;
    notifyListeners();
  }

  /// Gets the 'first time open app' flag from SharedPreferences.
  ///
  /// Returns `true` if the flag is not set, indicating it's the first time.
  Future<bool> getFirstTimeOpenApp() async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    return prefs.getBool('first_time_open_app') ?? true;
  }
}

/// Provider for the [WelcomePageSharedPreferencesNotifier].
final welcomePageSharedPreferencesProvider =
    ChangeNotifierProvider<WelcomePageSharedPreferencesNotifier>(
      (ref) => WelcomePageSharedPreferencesNotifier(ref),
    );

/// A [ChangeNotifier] for tracking whether the user has selected an app language.
/// This is used to ensure we prompt for language on the very first launch.
class LanguageSelectionSharedPreferencesNotifier extends ChangeNotifier {
  bool _languageSelected = false;
  final Ref ref;

  LanguageSelectionSharedPreferencesNotifier(this.ref) {
    _init();
  }

  bool get languageSelected => _languageSelected;

  Future<void> _init() async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    final storedFlag = prefs.getBool('language_selected');
    if (storedFlag == null) {
      // If user already has a language code stored by LocaleService, respect it.
      final existingLanguage = prefs.getString('languageCode');
      if (existingLanguage != null) {
        await prefs.setBool('language_selected', true);
        _languageSelected = true;
      } else {
        _languageSelected = false;
      }
    } else {
      _languageSelected = storedFlag;
    }
    notifyListeners();
  }

  Future<void> setLanguageSelected(bool value) async {
    final prefs = await ref.read(sharedPrefsFutureProvider.future);
    await prefs.setBool('language_selected', value);
    _languageSelected = value;
    notifyListeners();
  }
}

/// Provider for the [LanguageSelectionSharedPreferencesNotifier].
final languageSelectionSharedPreferencesProvider =
    ChangeNotifierProvider<LanguageSelectionSharedPreferencesNotifier>(
      (ref) => LanguageSelectionSharedPreferencesNotifier(ref),
    );

/// A shell widget for the Hustler user role, providing a bottom navigation bar.
/// It wraps the main content of the Hustler-specific pages.
class HustlerShell extends ConsumerWidget {
  /// The child widget to be displayed in the shell.
  final Widget child;

  /// Creates a new instance of [HustlerShell].
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
        // TODO(UI/UX): Add tooltips to navigation destinations for better accessibility.
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

  /// Determines the current index of the navigation bar based on the current route.
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;
    if (location.startsWith('/hustler/applications')) return 1;
    if (location.startsWith('/hustler/profile')) return 2;
    return 0; // Dashboard
  }

  /// Handles tap events on the navigation bar destinations.
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

/// A shell widget for the Employer user role, providing a bottom navigation bar
/// and a custom theme.
class EmployerShell extends ConsumerWidget {
  /// The child widget to be displayed in the shell.
  final Widget child;

  /// Creates a new instance of [EmployerShell].
  const EmployerShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Swap primary/secondary so employer uses the secondary palette for primary accents
    final swappedScheme = _swapPrimarySecondary(Theme.of(context).colorScheme);
    final employerTheme = Theme.of(
      context,
    ).copyWith(colorScheme: swappedScheme);

    return Theme(
      data: employerTheme,
      child: Builder(
        builder: (context) => Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _getCurrentIndex(context),
            onDestinationSelected: (index) => _onTap(context, index),
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            // TODO(UI/UX): Add tooltips to navigation destinations for better accessibility.
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.dashboard),
                selectedIcon: Icon(
                  Icons.dashboard,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: const Icon(Icons.work),
                selectedIcon: Icon(
                  Icons.work,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Jobs',
              ),
              NavigationDestination(
                icon: const Icon(Icons.add_circle),
                selectedIcon: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Post Job',
              ),
              NavigationDestination(
                icon: const Icon(Icons.person),
                selectedIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a new [ColorScheme] by swapping the primary and secondary colors.
  /// This is used to give the employer section a distinct visual theme.
  // Creates a ColorScheme where primary uses the original secondary palette.
  ColorScheme _swapPrimarySecondary(ColorScheme cs) {
    return cs.copyWith(
      primary: cs.secondary,
      onPrimary: cs.onSecondary,
      primaryContainer: cs.secondaryContainer,
      onPrimaryContainer: cs.onSecondaryContainer,
      // Keep existing secondary to avoid changing secondary usages directly
      // You can also swap back if you prefer a full swap:
      // secondary: cs.primary,
      // onSecondary: cs.onPrimary,
      // secondaryContainer: cs.primaryContainer,
      // onSecondaryContainer: cs.onPrimaryContainer,
    );
  }

  /// Determines the current index of the navigation bar based on the current route.
  int _getCurrentIndex(BuildContext context) {
    final location = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.path;
    if (location.startsWith('/employer/jobs')) return 1;
    // Ensure job details route highlights the Jobs tab as well
    if (location.startsWith('/employer/job')) return 1;
    if (location.startsWith('/employer/post-job')) return 2;
    if (location.startsWith('/employer/profile')) return 3;
    return 0; // Dashboard
  }

  /// Handles tap events on the navigation bar destinations.
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
