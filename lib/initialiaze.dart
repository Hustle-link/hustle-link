// file to initialize settings

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hustle_link/firebase_options.dart';
import 'package:riverpod/riverpod.dart';

import 'src/src.dart';

/// A [FutureProvider] that initializes Firebase.
///
/// This provider is responsible for initializing the Firebase app instance.
/// It should be overridden in the `main.dart` file to ensure Firebase is
/// ready before the app starts. Other providers can depend on this to ensure
/// Firebase services are available.
final firebaseInitProvider = FutureProvider<FirebaseApp>((ref) async {
  // TODO(Kenan): Add more robust error handling for Firebase initialization.
  debugPrint("Initializing Firebase...");
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Firebase Initialized successfully.");
  return app;
});
