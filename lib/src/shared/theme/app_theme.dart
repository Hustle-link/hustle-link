import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

class AppMaterialTheme {
  final TextTheme textTheme;

  const AppMaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a64),
      surfaceTint: Color(0xff006a64),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df2e9),
      onPrimaryContainer: Color(0xff00504b),
      secondary: Color(0xff8d4e2c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdbcb),
      onSecondaryContainer: Color(0xff703717),
      tertiary: Color(0xff48617a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcfe5ff),
      onTertiaryContainer: Color(0xff304962),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4947),
      outline: Color(0xff6f7977),
      outlineVariant: Color(0xffbec9c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5cd),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff00504b),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff341100),
      secondaryFixedDim: Color(0xffffb692),
      onSecondaryFixedVariant: Color(0xff703717),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff001d33),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xffd5dbd9),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003e3a),
      surfaceTint: Color(0xff006a64),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1a7a73),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5b2707),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9f5c39),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1e3850),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff566f8a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff0c1212),
      onSurfaceVariant: Color(0xff2e3837),
      outline: Color(0xff4a5453),
      outlineVariant: Color(0xff656f6d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5cd),
      primaryFixed: Color(0xff1a7a73),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f5a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff9f5c39),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff814423),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff566f8a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3e5770),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c6),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe3e9e8),
      surfaceContainerHigh: Color(0xffd8dedc),
      surfaceContainerHighest: Color(0xffccd3d1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00322f),
      surfaceTint: Color(0xff006a64),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00534e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff4e1d01),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff733919),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff132e45),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff324b64),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff242e2d),
      outlineVariant: Color(0xff414b4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5cd),
      primaryFixed: Color(0xff00534e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003a36),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff733919),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff572404),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff324b64),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff1a354c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4bab8),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f0),
      surfaceContainer: Color(0xffdde4e2),
      surfaceContainerHigh: Color(0xffcfd6d4),
      surfaceContainerHighest: Color(0xffc1c8c6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff81d5cd),
      surfaceTint: Color(0xff81d5cd),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff00504b),
      onPrimaryContainer: Color(0xff9df2e9),
      secondary: Color(0xffffb692),
      onSecondary: Color(0xff542103),
      secondaryContainer: Color(0xff703717),
      onSecondaryContainer: Color(0xffffdbcb),
      tertiary: Color(0xffafc9e7),
      onTertiary: Color(0xff18324a),
      tertiaryContainer: Color(0xff304962),
      onTertiaryContainer: Color(0xffcfe5ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffbec9c6),
      outline: Color(0xff899391),
      outlineVariant: Color(0xff3f4947),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a64),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff00504b),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff341100),
      secondaryFixedDim: Color(0xffffb692),
      onSecondaryFixedVariant: Color(0xff703717),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff001d33),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a39),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff303635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff97ebe3),
      surfaceTint: Color(0xff81d5cd),
      onPrimary: Color(0xff002b28),
      primaryContainer: Color(0xff489e97),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd3bf),
      onSecondary: Color(0xff441800),
      secondaryContainer: Color(0xffc97e58),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc5dffd),
      onTertiary: Color(0xff0a273f),
      tertiaryContainer: Color(0xff7a93af),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dedc),
      outline: Color(0xffaab4b2),
      outlineVariant: Color(0xff889290),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514c),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff003e3a),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff240900),
      secondaryFixedDim: Color(0xffffb692),
      onSecondaryFixedVariant: Color(0xff5b2707),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff001223),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff1e3850),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff3f4645),
      surfaceContainerLowest: Color(0xff040808),
      surfaceContainerLow: Color(0xff181f1e),
      surfaceContainer: Color(0xff232928),
      surfaceContainerHigh: Color(0xff2d3433),
      surfaceContainerHighest: Color(0xff383f3e),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffacfff6),
      surfaceTint: Color(0xff81d5cd),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7dd1c9),
      onPrimaryContainer: Color(0xff000e0c),
      secondary: Color(0xffffece5),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffb089),
      onSecondaryContainer: Color(0xff1a0500),
      tertiary: Color(0xffe7f1ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffabc5e3),
      onTertiaryContainer: Color(0xff000c1a),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f0),
      outlineVariant: Color(0xffbac5c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514c),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff001413),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb692),
      onSecondaryFixedVariant: Color(0xff240900),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff001223),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff4b5150),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2120),
      surfaceContainer: Color(0xff2b3231),
      surfaceContainerHigh: Color(0xff363d3c),
      surfaceContainerHighest: Color(0xff414847),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

final themeProvider = Provider<AppMaterialTheme>((ref) {
  return AppMaterialTheme(ThemeData.light().textTheme);
});
