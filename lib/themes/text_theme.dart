import 'package:flutter/material.dart';

class TextThemeStyle {
  static const TextTheme textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins_regular",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins_regular",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins_regular",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins_500",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 1.25,
    ),
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins_regular",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 1.5,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins_regular",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 1.5,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins_500",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.15,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins_500",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins_500",
      fontFamilyFallback: [
        'Poppins',
      ],
      letterSpacing: 0.1,
    ),
  );
}
