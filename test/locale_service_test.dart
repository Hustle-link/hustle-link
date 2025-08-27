import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/shared/services/locale_service.dart';

void main() {
  testWidgets('Locale defaults to en and updates after prefs load', (
    tester,
  ) async {
    // Build a minimal app that reads the locale provider.
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Before building any widget, the notifier starts with default locale 'en'.
    expect(
      container.read(localeNotifierProvider).languageCode,
      equals(LocaleService.defaultLocale.languageCode),
    );

    // Force prefs to be created/resolved once; this simulates async init completing.
    await container.read(cachedSharedPreferencesProvider.future);

    // Re-read after async init; should still be a valid locale (en unless persisted otherwise).
    expect([
      'en',
      'st',
      'tn',
    ], contains(container.read(localeNotifierProvider).languageCode));

    // Now update the locale via notifier and expect the state to change.
    final notifier = container.read(localeNotifierProvider.notifier);
    await notifier.setLocale(const Locale('tn'));

    expect(container.read(localeNotifierProvider).languageCode, 'tn');

    // Ensure it persists and survives a new container (fresh app start).
    final container2 = ProviderContainer();
    addTearDown(container2.dispose);

    // Wait for cached prefs to be ready in new container.
    await container2.read(cachedSharedPreferencesProvider.future);

    // New container should read back persisted 'tn'.
    expect(container2.read(localeNotifierProvider).languageCode, 'tn');
  });
}
