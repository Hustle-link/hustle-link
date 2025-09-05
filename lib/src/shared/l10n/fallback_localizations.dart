import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Provides a fallback (English) Material localization for locales that the
/// stock [GlobalMaterialLocalizations] delegate does not support (e.g. `tn`).
class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  static const _fallbackLocale = Locale('en');

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tn';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    // Reuse the existing global delegate to load English strings.
    return GlobalMaterialLocalizations.delegate.load(_fallbackLocale);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<MaterialLocalizations> old,
  ) => false;
}

/// Provides a fallback (English) Cupertino localization for unsupported locales.
class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  static const _fallbackLocale = Locale('en');

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tn';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return GlobalCupertinoLocalizations.delegate.load(_fallbackLocale);
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) => false;
}
