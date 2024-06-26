import 'package:flutter/material.dart';

class CustomColorScheme {
  static ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: LightColorTheme.primary,
    onPrimary: LightColorTheme.onPrimary,
    secondary: LightColorTheme.secondary,
    onSecondary: LightColorTheme.onPrimary,
    error: LightColorTheme.error,
    onError: LightColorTheme.onError,
    surface: LightColorTheme.surface,
    onSurface: LightColorTheme.onPrimary,
    primaryContainer: LightColorTheme.background,
  );

  static ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: DarkColorTheme.primary,
    onPrimary: DarkColorTheme.onPrimary,
    secondary: DarkColorTheme.secondary,
    onSecondary: DarkColorTheme.primary,
    error: DarkColorTheme.error,
    onError: DarkColorTheme.onError,
    surface: DarkColorTheme.surface,
    onSurface: DarkColorTheme.primary,
    primaryContainer: DarkColorTheme.background,
  );
}

class LightColorTheme {
  static Color get primary => const Color(0xfff2951b);
  static Color get onPrimary => const Color(0xffffffff);
  static Color get error => const Color(0xffd31d3e);
  static Color get onError => const Color(0xffffffff);
  static Color get surface => const Color(0xff545454);
  static Color get background => const Color(0xfffafafb);
  static Color get secondary => const Color(0xff141218);
}

class DarkColorTheme {
  static Color get primary => const Color(0xfff2951b);
  static Color get onPrimary => const Color(0xffffffff);
  static Color get error => const Color(0xffcf6679);
  static Color get onError => const Color(0xff0a0a0a);
  static Color get surface => const Color(0xfffcfcfc);
  static Color get background => const Color(0xff141218);
  static Color get secondary => const Color(0xff2e2926);
}
