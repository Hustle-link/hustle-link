import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hustle_link/src/src.dart';

/// A [Notifier] that manages the app's [ThemeMode].
///
/// It persists the user's preference to [SharedPreferences].
class ThemeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    // Initialize with system default, effectively waiting for _init to run
    // or just default to system.
    _init();
    return ThemeMode.system;
  }

  Future<void> _init() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final savedMode = prefs.getString(_key);
    if (savedMode != null) {
      state = _stringToThemeMode(savedMode);
    }
  }

  /// Sets the [ThemeMode] and persists it.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(_key, _themeModeToString(mode));
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }

  ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}

/// Provider for the [ThemeNotifier].
final themeModeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
