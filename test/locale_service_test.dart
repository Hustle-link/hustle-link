import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/shared/services/locale_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Locale defaults to en and updates after prefs load', (
    tester,
  ) async {
    // Set up mock initial values for SharedPreferences.
    SharedPreferences.setMockInitialValues({});

    // Build a minimal app that reads the locale provider.
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Before async init, the notifier starts with default locale 'en'.
    expect(
      container.read(localeNotifierProvider).languageCode,
      equals(LocaleService.defaultLocale.languageCode),
    );

    // Wait for SharedPreferences to be ready.
    await container.read(sharedPreferencesProvider.future);
    // Allow the notifier to process the initialization.
    await tester.pump();

    // Re-read after async init; should still be 'en' as nothing was persisted.
    expect(container.read(localeNotifierProvider).languageCode, 'en');

    // Now update the locale via notifier and expect the state to change.
    final notifier = container.read(localeNotifierProvider.notifier);
    await notifier.setLocale(const Locale('tn'));

    expect(container.read(localeNotifierProvider).languageCode, 'tn');

    // Dispose the old container
    container.dispose();

    // Create a new container to simulate an app restart
    final container2 = ProviderContainer();
    addTearDown(container2.dispose);

    // Wait for SharedPreferences to be ready in the new container.
    await container2.read(sharedPreferencesProvider.future);
    await tester.pump();

    // New container should read back the persisted 'tn' locale.
    expect(container2.read(localeNotifierProvider).languageCode, 'tn');
  });
}
