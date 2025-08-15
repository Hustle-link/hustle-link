import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/firebase_options.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';

/// The entry point of the application.
Future<void> main() async {
  // Ensure that the Flutter widget binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform.
  // TODO(Kenan): Consider moving this to the `firebaseInitProvider` and using a splash screen.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app within a `ProviderScope` to enable Riverpod for state management.
  runApp(const ProviderScope(child: MyApp()));
}

/// The root widget of the HustleLink application.
class MyApp extends HookConsumerWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router provider to get the app's routing configuration.
    final router = ref.watch(appRouteProvider);

    // Watch the theme provider to get the app's theme data.
    // TODO(Kenan): Implement a dark theme and allow the user to switch between themes.
    final theme = ref.watch(themeProvider);

    // Watch the locale provider to get the app's current locale.
    final locale = ref.watch(localeNotifierProvider);

    // Use the Sizer widget to make the UI responsive across different screen sizes.
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          // Disable the debug banner in the top-right corner.
          debugShowCheckedModeBanner: false,
          // Configure the app's router.
          routerConfig: router,
          // Set the light theme for the app.
          theme: theme.light(),
          // Set the current locale
          locale: locale,
          // -- Add the following two lines --
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('st', ''), // Setswana, no country code
          ],
          // Initialize FlutterSmartDialog for displaying custom dialogs, toasts, and loading indicators.
          builder: FlutterSmartDialog.init(
            builder: (context, child) {
              return child!;
            },
          ),
        );
      },
    );
  }
}
