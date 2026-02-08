import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Loading indicator widget that replaces SpinKitFadingCube
///
/// Supports multiple loading styles:
/// - Spinner: Rotating spinner indicator
/// - Shimmer: Skeleton screen placeholder (for lists/cards)
/// - Custom: Use provided child widget
enum LoadingStyle {
  /// Rotating spinner (default, replaces SpinKitFadingCube)
  spinner,

  /// Shimmer/skeleton placeholder for lists and cards
  shimmer,

  /// Custom loading widget
  custom,
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.style = LoadingStyle.spinner,
    this.color,
    this.size = 50.0,
    this.customChild,
  });

  /// Loading style (spinner, shimmer, custom)
  final LoadingStyle style;

  /// Color of the loading indicator
  final Color? color;

  /// Size of the loading indicator
  final double size;

  /// Custom child widget (only used with LoadingStyle.custom)
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case LoadingStyle.spinner:
        return _buildSpinner(context);
      case LoadingStyle.shimmer:
        return _buildShimmer(context);
      case LoadingStyle.custom:
        return customChild ?? _buildSpinner(context);
    }
  }

  /// Build rotating spinner (replaces SpinKitFadingCube)
  Widget _buildSpinner(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;

    return Center(
      child: SizedBox(
        height: size * 4, // Match legacy 200px container
        width: size * 4,
        child: SpinKitFadingCube(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: effectiveColor,
              ),
            );
          },
          size: size,
        ),
      ),
    );
  }

  /// Build shimmer placeholder for skeleton screens
  Widget _buildShimmer(BuildContext context) {
    return ShimmerPlaceholder(
      color: color ?? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
    );
  }
}

/// Shimmer placeholder for skeleton screens
class ShimmerPlaceholder extends StatefulWidget {
  const ShimmerPlaceholder({
    super.key,
    this.color,
    this.baseColor,
    this.highlightColor,
  });

  /// Base shimmer color
  final Color? color;

  /// Base background color
  final Color? baseColor;

  /// Highlight color for shimmer animation
  final Color? highlightColor;

  @override
  State<ShimmerPlaceholder> createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor =
        widget.baseColor ?? Theme.of(context).colorScheme.surface.withValues(alpha: 0.3);
    final highlightColor = widget.highlightColor ??
        Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Card shimmer placeholder for loading lists
class CardShimmer extends StatelessWidget {
  const CardShimmer({
    super.key,
    this.height = 100,
    this.margin = const EdgeInsets.all(8.0),
  });

  /// Height of the shimmer card
  final double height;

  /// Margin around the shimmer card
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: const ShimmerPlaceholder(),
    );
  }
}

/// List shimmer placeholder for loading list views
class ListShimmer extends StatelessWidget {
  const ListShimmer({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 100,
  });

  /// Number of shimmer items to display
  final int itemCount;

  /// Height of each shimmer item
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CardShimmer(height: itemHeight);
      },
    );
  }
}
