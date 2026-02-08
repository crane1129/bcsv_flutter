import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_colors.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_spacing.dart';

/// Centralized theme configuration for the BCSV Flutter app
///
/// This file defines all app themes using the AppColors and AppSpacing systems.
/// Maintains the five existing themes: light, dark, bible, sepia, and midnightBlue.
class AppTheme {
  AppTheme._();

  // ============================================================================
  // Theme Definitions
  // ============================================================================

  /// Light theme
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    inputDecorationTheme: _inputDecorationTheme(Colors.white),
  );

  /// Dark theme
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple,
      secondary: Colors.deepPurpleAccent,
    ),
    inputDecorationTheme: _inputDecorationTheme(const Color(0xFF1E1E2C)),
  );

  /// Bible theme (warm, parchment-like)
  static final ThemeData bible = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.biblePrimary,
    scaffoldBackgroundColor: AppColors.bibleBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.biblePrimary,
      onPrimary: Colors.white,
      surface: AppColors.bibleBackground,
      onSurface: Colors.brown[900]!,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.brown[900]),
    ),
    inputDecorationTheme: _inputDecorationTheme(AppColors.bibleBackground),
  );

  /// Sepia theme (vintage, warm tones)
  static final ThemeData sepia = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.sepiaPrimary,
    scaffoldBackgroundColor: AppColors.sepiaBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.sepiaPrimary,
      onPrimary: Colors.white,
      surface: AppColors.sepiaBackground,
      onSurface: AppColors.sepiaOnSurface,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColors.sepiaOnSurface),
    ),
    inputDecorationTheme: _inputDecorationTheme(AppColors.sepiaBackground),
  );

  /// Midnight Blue theme (dark, blue-tinted)
  static final ThemeData midnightBlue = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.midnightBluePrimary,
    scaffoldBackgroundColor: AppColors.midnightBlueBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.midnightBluePrimary,
      onPrimary: Colors.white,
      surface: AppColors.midnightBlueSurface,
      onSurface: Colors.white70,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white70,
        fontSize: 14.0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.midnightBlueSurface,
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // ============================================================================
  // Helper Methods
  // ============================================================================

  /// Common input decoration theme for all themes except midnight blue
  static InputDecorationTheme _inputDecorationTheme(Color fillColor) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
        borderSide: BorderSide.none,
      ),
    );
  }

  /// Get theme by index (for backward compatibility with ThemeNotifier)
  static ThemeData getThemeByIndex(int index) {
    switch (index) {
      case 0:
        return light;
      case 1:
        return dark;
      case 2:
        return bible;
      case 3:
        return sepia;
      case 4:
        return midnightBlue;
      default:
        return light;
    }
  }

  /// Get all available themes as a list
  static List<ThemeData> get allThemes => [
        light,
        dark,
        bible,
        sepia,
        midnightBlue,
      ];

  /// Get theme names for display
  static List<String> get themeNames => [
        'Light',
        'Dark',
        'Bible',
        'Sepia',
        'Midnight Blue',
      ];
}
