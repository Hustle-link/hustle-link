// file to initialize settings

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hustle_link/firebase_options.dart';

void initServices() async {
  // TODO: remove init debug print
  // debugPrint firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
        debugPrint('Firebase initialized');
      })
      .onError((error, stackTrace) {
        debugPrint('Firebase initialization failed: $error');
      });
  // TODO: implement the initialization all services e.g api, storage etc

  // debugPrint success
  debugPrint('Services initialized');
}
