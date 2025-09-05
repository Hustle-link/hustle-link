import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _languageCodeKey = 'languageCode';

/// A service for managing the application's locale.
///
/// It uses [SharedPreferences] to persist the user's selected language.
class LocaleService {
  final SharedPreferences _prefs;

  LocaleService(this._prefs);

  /// The default locale of the application.
  static const defaultLocale = Locale('en');

  /// The currently selected locale.
  ///
  /// Defaults to [defaultLocale] if no locale is stored.
  Locale get locale {
    final languageCode = _prefs.getString(_languageCodeKey);
    if (languageCode == null) {
      return defaultLocale;
    }
    return Locale(languageCode);
  }

  /// Updates the application's locale.
  ///
  /// The new locale is persisted to [SharedPreferences].
  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_languageCodeKey, locale.languageCode);
  }
}

/// Provider for [SharedPreferences].
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

/// A notifier for the application's locale.
///
/// This notifier manages the state of the current locale and provides a way
/// to update it.
class LocaleNotifier extends StateNotifier<Locale> {
  final Ref ref;

  LocaleNotifier(this.ref) : super(LocaleService.defaultLocale) {
    _init();
  }

  Future<void> _init() async {
    // Wait for SharedPreferences to be ready, then set initial locale.
    final prefs = await ref.read(sharedPreferencesProvider.future);
    state = LocaleService(prefs).locale;
  }

  /// Updates the application's locale.
  Future<void> setLocale(Locale locale) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await LocaleService(prefs).setLocale(locale);
    state = locale;
  }
}

/// Provider for the [LocaleNotifier].
final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>((
  ref,
) {
  return LocaleNotifier(ref);
});
