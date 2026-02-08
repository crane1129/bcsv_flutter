import 'package:flutter/material.dart';

/// Centralized color palette for the BCSV Flutter app
///
/// This file defines all colors used throughout the app, organized by:
/// - Brand colors
/// - Semantic colors (success, error, warning, info)
/// - UI element colors
/// - Theme-specific colors
class AppColors {
  AppColors._();

  // ============================================================================
  // Brand Colors (from legacy constants.dart)
  // ============================================================================

  static const Color opinionCard = Color(0xFF54636B);
  static const Color navBackButton = Color(0xFFFF9C02);
  static const Color inactiveIcon = Color(0xFFB7C7CE);
  static const Color cardIcon = Color(0xFFF9AA33);
  static const Color mainAppBar = Color(0xFF232F34);
  static const Color mainTheme = Color(0xFF0C1B21);

  // ============================================================================
  // Semantic Colors
  // ============================================================================

  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  // ============================================================================
  // Offline Indicator Colors
  // ============================================================================

  static const Color offlineIndicator = Colors.orange;
  static const Color onlineIndicator = Colors.green;

  // ============================================================================
  // Theme-Aware Colors (functions that depend on BuildContext)
  // ============================================================================

  /// Returns the primary active icon color from current theme
  static Color activeIcon(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  /// Returns the secondary active icon color (for admin/staff features)
  static Color activeIconAdmin(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  /// Returns surface color from current theme
  static Color surface(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  /// Returns primary color from current theme
  static Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  /// Returns onSurface color from current theme
  static Color onSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// Returns onPrimary color from current theme
  static Color onPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  // ============================================================================
  // Theme-Specific Color Palettes
  // ============================================================================

  /// Bible Theme colors
  static const Color bibleBackground = Color(0xFFFAF3E0);
  static const Color biblePrimary = Colors.brown;

  /// Sepia Theme colors
  static const Color sepiaBackground = Color(0xFFF4ECD8);
  static const Color sepiaPrimary = Color(0xFF704214);
  static const Color sepiaOnSurface = Color(0xFF4B3832);

  /// Midnight Blue Theme colors
  static const Color midnightBlueBackground = Color(0xFF0D111C);
  static const Color midnightBluePrimary = Color(0xFF536DFE);
  static const Color midnightBlueSurface = Color(0xFF1E1E2C);

  // ============================================================================
  // Gradient Colors
  // ============================================================================

  /// Card gradient (for ReusableCard2 style)
  static const List<Color> cardGradient = [
    Colors.white10,
    Colors.black12,
  ];

  // ============================================================================
  // Utility Functions
  // ============================================================================

  /// Returns a color with specified opacity (0.0 - 1.0)
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Returns onSurface color with 60% opacity
  static Color onSurfaceMuted(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);
  }

  /// Returns onSurface color with 80% opacity
  static Color onSurfaceDim(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8);
  }

  /// Returns onSurface color with 90% opacity
  static Color onSurfaceSubtle(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9);
  }
}
