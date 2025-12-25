import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Flutter Official Dark Blue Theme
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLightGray = Color(0xFFD3D3D3);
  static const Color bgJet = Color(0xFF2E2E2E);
  static const Color bgEerieBlack = Color(0xFF1E293B); // Dark blue-gray
  static const Color bgRichBlackFogra29 = Color(0xFF0F172A); // Darker blue
  static const Color bgSmokyBlack = Color(0xFF1A1F35); // Dark blue
  static const Color bgBlack = Color(0xFF0D1B2A); // Flutter official dark blue
  
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textLightGray = Color(0xFFD3D3D3);
  static const Color textRichBlackFogra29 = Color(0xFF0F1A2A);
  static const Color textSmokyBlack = Color(0xFF0F0F0F);
  static const Color textBlack = Color(0xFF000000);
  
  static const Color borderWhite = Color(0xFFFFFFFF);
  static const Color borderLightGray = Color(0xFFD3D3D3);
  static const Color borderGainsboro = Color(0xFFE8E8E8);
  static const Color borderEerieBlack = Color(0xFF212121);
  static const Color borderSmokyBlack = Color(0xFF0F0F0F);
  
  // Typography - Professional System Fonts
  static const String fontFamilyPrimary = 'Inter'; // Will fallback to system sans-serif
  static const String fontFamilyDisplay = 'Inter'; // Will fallback to system sans-serif
  
  // Font Sizes
  static const double fontSize1 = 46.0;
  static const double fontSize2 = 45.0;
  static const double fontSize3 = 40.0;
  static const double fontSize4 = 30.0;
  static const double fontSize5 = 24.0;
  static const double fontSize6 = 18.0;
  static const double fontSize7 = 20.0;
  static const double fontSize8 = 16.0;
  static const double fontSize9 = 15.0;
  static const double fontSize10 = 14.0;
  
  // Spacing
  static const double sectionSpacing = 70.0;
  
  // Border Radius
  static const double radiusPill = 500.0;
  static const double radiusCircle = 50.0;
  
  // Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgBlack,
      colorScheme: const ColorScheme.dark(
        primary: textWhite,
        secondary: textLightGray,
        surface: bgEerieBlack,
        background: bgBlack,
      ),
      fontFamily: fontFamilyPrimary,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: fontSize2,
          fontWeight: FontWeight.w700,
          color: textWhite,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: fontSize3,
          fontWeight: FontWeight.w700,
          color: textWhite,
          height: 1.3,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: fontSize4,
          fontWeight: FontWeight.w600,
          color: textWhite,
          height: 1.3,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSize5,
          fontWeight: FontWeight.w600,
          color: textWhite,
          height: 1.3,
          letterSpacing: -0.2,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSize7,
          fontWeight: FontWeight.w600,
          color: textWhite,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: fontSize6,
          fontWeight: FontWeight.w600,
          color: textWhite,
          height: 1.3,
        ),
        bodyLarge: TextStyle(
          fontSize: fontSize8,
          fontWeight: FontWeight.w400,
          color: textLightGray,
          height: 1.75,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgWhite,
      colorScheme: const ColorScheme.light(
        primary: textBlack,
        secondary: textSmokyBlack,
        surface: bgLightGray,
        background: bgWhite,
      ),
      fontFamily: fontFamilyPrimary,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: fontSize2,
          fontWeight: FontWeight.w700,
          color: textBlack,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: fontSize3,
          fontWeight: FontWeight.w700,
          color: textBlack,
          height: 1.3,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: fontSize4,
          fontWeight: FontWeight.w600,
          color: textBlack,
          height: 1.3,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSize5,
          fontWeight: FontWeight.w600,
          color: textBlack,
          height: 1.3,
          letterSpacing: -0.2,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSize7,
          fontWeight: FontWeight.w600,
          color: textBlack,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: fontSize6,
          fontWeight: FontWeight.w600,
          color: textBlack,
          height: 1.3,
        ),
        bodyLarge: TextStyle(
          fontSize: fontSize8,
          fontWeight: FontWeight.w400,
          color: textSmokyBlack,
          height: 1.75,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

