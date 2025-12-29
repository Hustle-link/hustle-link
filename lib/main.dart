import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/theme/theme_notifier.dart';
import 'package:sizer/sizer.dart';
import 'package:hustle_link/src/shared/l10n/fallback_localizations.dart';

/// The entry point of the application.
Future<void> main() async {
  // Ensure that the Flutter widget binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

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
    final theme = ref.watch(themeProvider);
    // Watch the theme mode provider
    final themeMode = ref.watch(themeModeProvider);

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
          // Set the dark theme
          darkTheme: theme.dark(),
          // Mode
          themeMode: themeMode,
          // Set the current locale
          locale: locale,
          // Localization setup
          localizationsDelegates: const [
            // App generated localizations.
            ...AppLocalizations.localizationsDelegates,
            // Fallback delegates (provide English strings for unsupported locales like 'tn').
            FallbackMaterialLocalizationsDelegate(),
            FallbackCupertinoLocalizationsDelegate(),
            // Global delegates (kept after fallback so fallback wins for targeted locales).
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
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
