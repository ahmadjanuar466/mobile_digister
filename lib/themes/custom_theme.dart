import 'package:digister/themes/custom_color_scheme.dart';
import 'package:digister/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData darkTheme = DarkTheme.render;
  static ThemeData lightTheme = LightTheme.render;
}

class DarkTheme {
  static ThemeData render = ThemeData(
    brightness: Brightness.dark,
    colorScheme: CustomColorScheme.dark,
    scaffoldBackgroundColor: DarkColorTheme.background,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      height: 50,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: DarkColorTheme.primary,
        foregroundColor: DarkColorTheme.onPrimary,
        textStyle: TextThemeStyle.textTheme.titleLarge!.copyWith(
          color: DarkColorTheme.onPrimary,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: LightColorTheme.primary),
        foregroundColor: LightColorTheme.primary,
        textStyle: TextThemeStyle.textTheme.titleLarge!.copyWith(
          color: LightColorTheme.primary,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextThemeStyle.textTheme.apply(
      displayColor: DarkColorTheme.onPrimary,
      bodyColor: DarkColorTheme.onPrimary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    applyElevationOverlayColor: false,
    appBarTheme: AppBarTheme(
      backgroundColor: DarkColorTheme.background,
      centerTitle: false,
      foregroundColor: DarkColorTheme.onPrimary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkColorTheme.background,
      selectedItemColor: DarkColorTheme.primary,
      unselectedItemColor: DarkColorTheme.onPrimary.withOpacity(0.4),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      labelStyle: TextStyle(color: DarkColorTheme.onPrimary),
      iconColor: DarkColorTheme.onPrimary,
      suffixIconColor: DarkColorTheme.onPrimary,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: DarkColorTheme.onPrimary),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: DarkColorTheme.onPrimary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: DarkColorTheme.onPrimary),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(DarkColorTheme.background),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return DarkColorTheme.primary;
          }
          return DarkColorTheme.background;
        },
      ),
    ),
    dividerColor: DarkColorTheme.secondary,
    dividerTheme: DividerThemeData(
      color: DarkColorTheme.secondary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: DarkColorTheme.primary,
    ),
    iconTheme: IconThemeData(
      color: DarkColorTheme.onPrimary,
    ),
    listTileTheme: ListTileThemeData(
      textColor: DarkColorTheme.onPrimary,
      iconColor: DarkColorTheme.onPrimary,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: DarkColorTheme.onPrimary.withOpacity(0.4),
      dividerColor: DarkColorTheme.onPrimary.withOpacity(0.5),
    ),
    dialogBackgroundColor: DarkColorTheme.background,
  );
}

class LightTheme {
  static ThemeData render = ThemeData(
    brightness: Brightness.light,
    colorScheme: CustomColorScheme.light,
    scaffoldBackgroundColor: LightColorTheme.background,
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      height: 50,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: LightColorTheme.primary,
        foregroundColor: LightColorTheme.onPrimary,
        textStyle: TextThemeStyle.textTheme.titleLarge!.copyWith(
          color: LightColorTheme.onPrimary,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: LightColorTheme.primary),
        foregroundColor: LightColorTheme.primary,
        textStyle: TextThemeStyle.textTheme.titleLarge!.copyWith(
          color: LightColorTheme.primary,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    textTheme: TextThemeStyle.textTheme.apply(
      displayColor: LightColorTheme.secondary,
      bodyColor: LightColorTheme.secondary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    applyElevationOverlayColor: false,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColorTheme.background,
      centerTitle: false,
      foregroundColor: LightColorTheme.secondary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.transparent,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (light icons)
        statusBarBrightness: Brightness.light, // For iOS (light icons)
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: LightColorTheme.background,
      selectedItemColor: LightColorTheme.primary,
      unselectedItemColor: LightColorTheme.secondary.withOpacity(0.4),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 2.0,
      ),
      labelStyle: TextStyle(color: LightColorTheme.secondary),
      iconColor: LightColorTheme.secondary,
      suffixIconColor: LightColorTheme.secondary,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: LightColorTheme.secondary),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: LightColorTheme.secondary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: LightColorTheme.secondary),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(LightColorTheme.background),
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return LightColorTheme.primary;
          }
          return LightColorTheme.background;
        },
      ),
    ),
    dividerColor: LightColorTheme.secondary.withOpacity(0.4),
    dividerTheme: DividerThemeData(
      color: LightColorTheme.secondary.withOpacity(0.4),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: const CircleBorder(),
      backgroundColor: LightColorTheme.primary,
    ),
    iconTheme: IconThemeData(
      color: LightColorTheme.secondary,
    ),
    listTileTheme: ListTileThemeData(
      textColor: LightColorTheme.secondary,
      iconColor: LightColorTheme.secondary,
    ),
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: LightColorTheme.secondary.withOpacity(0.4),
      dividerColor: LightColorTheme.secondary.withOpacity(0.4),
    ),
    dialogBackgroundColor: DarkColorTheme.onPrimary,
    dialogTheme: DialogTheme(
      titleTextStyle: TextThemeStyle.textTheme.titleMedium!.copyWith(
        color: LightColorTheme.secondary,
      ),
    ),
  );
}
