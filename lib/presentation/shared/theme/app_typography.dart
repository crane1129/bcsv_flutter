import 'package:flutter/material.dart';

/// Centralized typography system for the BCSV Flutter app
///
/// This file defines all text styles used throughout the app.
/// All styles are theme-aware and extend from the current theme's TextTheme.
class AppTypography {
  AppTypography._();

  // ============================================================================
  // Font Families
  // ============================================================================

  static const String systemFont = 'PoorStory';
  static const String systemFontAlt = 'Dongle-Light';

  // ============================================================================
  // App Bar Text Styles
  // ============================================================================

  /// Large app bar text style (30pt)
  static TextStyle appBarLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 30.0,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.primary,
        );
  }

  /// Small app bar text style (20pt)
  static TextStyle appBarSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 20.0,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.secondary,
        );
  }

  // ============================================================================
  // Body Text Styles
  // ============================================================================

  /// Default body text style (16pt, customizable size)
  static TextStyle body(BuildContext context, {double? fontSize}) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: fontSize ?? 16.0,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.onSurface,
        );
  }

  /// Small body text style (15pt, 60% opacity)
  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 15.0,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          fontFamily: systemFont,
          fontWeight: FontWeight.w400,
        );
  }

  /// Dialog body text style (15pt, 60% opacity)
  static TextStyle dialogBodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 15.0,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          fontFamily: systemFont,
          fontWeight: FontWeight.w400,
        );
  }

  // ============================================================================
  // Title Text Styles
  // ============================================================================

  /// Main display title (70pt, used for large headers)
  static TextStyle mainTitle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!.copyWith(
          fontSize: 70.0,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          fontFamily: systemFont,
          letterSpacing: 1.0,
          height: 0.0,
        );
  }

  /// Page title (25pt, on primary color)
  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: 25.0,
          color: Theme.of(context).colorScheme.onPrimary,
          fontFamily: systemFont,
          letterSpacing: 1.0,
          height: 0.0,
        );
  }

  /// Subtitle (25pt, light green)
  static TextStyle subtitle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 25.0,
          color: Colors.lightGreen,
          fontFamily: systemFont,
          textBaseline: TextBaseline.alphabetic,
        );
  }

  // ============================================================================
  // Card Text Styles
  // ============================================================================

  /// Card title (25pt)
  static TextStyle cardTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 25.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFont,
        );
  }

  /// Body card title (25pt, alternate font)
  static TextStyle bodyCardTitle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 25.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFontAlt,
        );
  }

  // ============================================================================
  // List Text Styles
  // ============================================================================

  /// List title (18pt, bold, theme-aware)
  static TextStyle listTitle(BuildContext context, {bool dark = true}) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18.0,
          fontFamily: systemFont,
          color: dark
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w700,
        );
  }

  /// List title with black text (18pt, bold, 60% opacity)
  static TextStyle listTitleBlack(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        );
  }

  /// List title with white text (18pt, bold)
  static TextStyle listTitleWhite(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.onPrimary,
        );
  }

  /// List subtitle (15pt, 90% opacity)
  static TextStyle listSubtitle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 15.0,
          fontFamily: systemFont,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
        );
  }

  // ============================================================================
  // Button Text Styles
  // ============================================================================

  /// Large button text (25pt)
  static TextStyle buttonLarge(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 25.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFont,
          fontWeight: FontWeight.w400,
        );
  }

  /// Regular button text (12pt)
  static TextStyle buttonRegular(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
          fontSize: 12.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFont,
        );
  }

  // ============================================================================
  // Label Text Styles
  // ============================================================================

  /// Standard label (16pt)
  static TextStyle label(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 16.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFont,
        );
  }

  // ============================================================================
  // Drawer Text Styles
  // ============================================================================

  /// Drawer title menu (20pt)
  static TextStyle drawerTitleMenu(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 20.0,
          color: Theme.of(context).colorScheme.onSurface,
          fontFamily: systemFont,
          textBaseline: TextBaseline.alphabetic,
        );
  }

  /// Drawer menu text (18pt, 80% opacity)
  static TextStyle drawerMenu(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 18.0,
          fontFamily: systemFont,
          textBaseline: TextBaseline.alphabetic,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
        );
  }
}
