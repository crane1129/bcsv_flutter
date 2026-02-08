import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_spacing.dart';

/// Unified card widget that replaces ReusableCard, ReusableCard2, and ReusableCard3
///
/// Supports three variants:
/// - basic: Simple card with border radius (replaces ReusableCard)
/// - elevated: Card with elevation and gradient overlay (replaces ReusableCard2)
/// - simple: Card with elevation only (replaces ReusableCard3)
enum AppCardVariant {
  /// Basic card with container and border radius (ReusableCard style)
  basic,

  /// Elevated card with gradient overlay (ReusableCard2 style)
  elevated,

  /// Simple elevated card (ReusableCard3 style)
  simple,
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    required this.onTap,
    this.color,
    this.variant = AppCardVariant.basic,
    this.margin,
    this.padding,
    this.borderRadius,
    this.elevation,
  });

  /// The child widget to display inside the card
  final Widget child;

  /// Callback when card is tapped
  final VoidCallback onTap;

  /// Background color of the card
  final Color? color;

  /// Card variant (basic, elevated, simple)
  final AppCardVariant variant;

  /// Custom margin (defaults based on variant)
  final EdgeInsetsGeometry? margin;

  /// Custom padding (defaults based on variant)
  final EdgeInsetsGeometry? padding;

  /// Custom border radius (defaults based on variant)
  final double? borderRadius;

  /// Custom elevation (only for elevated and simple variants)
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppCardVariant.basic:
        return _buildBasicCard(context);
      case AppCardVariant.elevated:
        return _buildElevatedCard(context);
      case AppCardVariant.simple:
        return _buildSimpleCard(context);
    }
  }

  /// Build basic card (ReusableCard style)
  Widget _buildBasicCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.all(AppSpacing.cardMargin),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppSpacing.cardBorderRadius,
          ),
        ),
        child: child,
      ),
    );
  }

  /// Build elevated card with gradient (ReusableCard2 style)
  Widget _buildElevatedCard(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppSpacing.cardBorderRadiusLarge;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
        child: Card(
          elevation: elevation ?? 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          color: color ?? Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white10,
                  Colors.black12,
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Build simple elevated card (ReusableCard3 style)
  Widget _buildSimpleCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
        child: Card(
          elevation: elevation ?? 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppSpacing.cardBorderRadius,
            ),
          ),
          color: color ?? Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      ),
    );
  }
}

// ============================================================================
// Legacy Compatibility Wrappers
// ============================================================================

/// Backward compatible wrapper for ReusableCard
/// Use AppCard with variant: AppCardVariant.basic instead
@Deprecated('Use AppCard with variant: AppCardVariant.basic')
class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.color,
    required this.cardChild,
    required this.onPress,
  });

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: color,
      onTap: onPress,
      variant: AppCardVariant.basic,
      child: cardChild,
    );
  }
}

/// Backward compatible wrapper for ReusableCard2
/// Use AppCard with variant: AppCardVariant.elevated instead
@Deprecated('Use AppCard with variant: AppCardVariant.elevated')
class ReusableCard2 extends StatelessWidget {
  const ReusableCard2({
    super.key,
    required this.color,
    required this.cardChild,
    required this.onPress,
  });

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: color,
      onTap: onPress,
      variant: AppCardVariant.elevated,
      child: cardChild,
    );
  }
}

/// Backward compatible wrapper for ReusableCard3
/// Use AppCard with variant: AppCardVariant.simple instead
@Deprecated('Use AppCard with variant: AppCardVariant.simple')
class ReusableCard3 extends StatelessWidget {
  const ReusableCard3({
    super.key,
    required this.color,
    required this.cardChild,
    required this.onPress,
    this.msg_widget,
  });

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;
  final dynamic msg_widget;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: color,
      onTap: onPress,
      variant: AppCardVariant.simple,
      child: cardChild,
    );
  }
}
