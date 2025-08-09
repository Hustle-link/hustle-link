import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

/// A more modern and professional color palette.
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0077B6); // A professional blue
  static const Color onPrimary = Colors.white;
  static const Color primaryContainer = Color(0xFFE0F7FA);
  static const Color onPrimaryContainer = Color(0xFF004D70);

  // Secondary colors (for the Employer role)
  static const Color secondary = Color(0xFF009688); // A calm teal
  static const Color onSecondary = Colors.white;
  static const Color secondaryContainer = Color(0xFFB2DFDB);
  static const Color onSecondaryContainer = Color(0xFF004D40);

  // Accent/Tertiary colors
  static const Color tertiary = Color(0xFFFFA000); // A warm amber for accents
  static const Color onTertiary = Colors.black;

  // Error colors
  static const Color error = Color(0xFFD32F2F);
  static const Color onError = Colors.white;

  // Surface and Background colors
  static const Color surface = Color(0xFFF8F9FA);
  static const Color onSurface = Color(0xFF212529);
  static const Color background = Colors.white;
  static const Color onBackground = Color(0xFF212529);

  // Neutral/Variant colors
  static const Color outline = Color(0xFFADB5BD);
  static const Color shadow = Color(0x40000000);
}

class AppMaterialTheme {
  final TextTheme textTheme;

  const AppMaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      background: AppColors.background,
      onBackground: AppColors.onBackground,
      outline: AppColors.outline,
      shadow: AppColors.shadow,
      surfaceTint: AppColors.primary,
    );
  }

  /// The main light theme for the application.
  ThemeData light() {
    return _theme(lightScheme());
  }

  /// A dark theme for the application.
  /// TODO: Implement a full dark theme color palette.
  ThemeData dark() {
    // For now, let's just return the light theme.
    // A proper dark theme would require defining dark-mode specific colors.
    return _theme(lightScheme());
  }

  ThemeData _theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.latoTextTheme(textTheme).apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.surface,
      // Define other properties like button themes, input decoration themes, etc.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
      ),
    );
  }
}

/// Provides the application's theme.
/// It uses the default TextTheme from ThemeData and applies the Lato font.
final themeProvider = Provider<AppMaterialTheme>((ref) {
  final textTheme = ThemeData.light().textTheme;
  return AppMaterialTheme(textTheme);
});
