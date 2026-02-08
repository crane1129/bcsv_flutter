/// Centralized spacing system for the BCSV Flutter app
///
/// This file defines consistent spacing values used for margins, padding, and gaps.
/// Uses a scale-based system for predictable and harmonious layouts.
class AppSpacing {
  AppSpacing._();

  // ============================================================================
  // Base Spacing Scale
  // ============================================================================

  /// Extra extra small spacing (2px)
  static const double xxs = 2.0;

  /// Extra small spacing (4px)
  static const double xs = 4.0;

  /// Small spacing (8px)
  static const double sm = 8.0;

  /// Medium spacing (12px)
  static const double md = 12.0;

  /// Large spacing (16px)
  static const double lg = 16.0;

  /// Extra large spacing (24px)
  static const double xl = 24.0;

  /// Extra extra large spacing (32px)
  static const double xxl = 32.0;

  /// Extra extra extra large spacing (48px)
  static const double xxxl = 48.0;

  // ============================================================================
  // Specific Use Cases (based on legacy code)
  // ============================================================================

  /// Card margin (10px) - from ReusableCard
  static const double cardMargin = 10.0;

  /// Card padding (2px) - from ReusableCard2/3
  static const double cardPadding = 2.0;

  /// Default card border radius
  static const double cardBorderRadius = 10.0;

  /// Large card border radius
  static const double cardBorderRadiusLarge = 15.0;

  /// Input field border radius
  static const double inputBorderRadius = 10.0;

  // ============================================================================
  // Common Patterns
  // ============================================================================

  /// Standard page horizontal padding
  static const double pageHorizontal = lg;

  /// Standard page vertical padding
  static const double pageVertical = lg;

  /// Standard section spacing
  static const double section = xl;

  /// Standard item spacing in lists
  static const double listItem = md;

  /// Standard gap between related elements
  static const double elementGap = sm;

  /// Standard gap between unrelated elements
  static const double componentGap = lg;
}
