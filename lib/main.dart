import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/firebase_options.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  // ensure widgets binding are intialized
  WidgetsFlutterBinding.ensureInitialized();

  // init services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run app
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch router
    final router = ref.watch(appRouteProvider);

    // watch theme
    final theme = ref.watch(themeProvider);

    return Sizer(
      builder: (context, orientation, screenType) {
        // listen to first time open app state
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: theme.light(),
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
