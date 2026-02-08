import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_spacing.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_typography.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_colors.dart';
import 'package:intl/intl.dart';

/// Offline banner widget that shows network status and last updated time
///
/// Can be displayed as:
/// - AppBar action (small icon)
/// - Banner at top of screen
/// - Banner at bottom of screen
enum OfflineBannerStyle {
  /// Small icon in app bar
  icon,

  /// Banner at top of screen
  topBanner,

  /// Banner at bottom of screen
  bottomBanner,
}

/// Offline banner widget for showing offline status
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    super.key,
    required this.isOffline,
    this.lastUpdated,
    this.style = OfflineBannerStyle.icon,
    this.showLastUpdated = true,
  });

  /// Whether the app is currently offline
  final bool isOffline;

  /// Last updated timestamp (optional)
  final DateTime? lastUpdated;

  /// Display style (icon, topBanner, bottomBanner)
  final OfflineBannerStyle style;

  /// Whether to show last updated time
  final bool showLastUpdated;

  @override
  Widget build(BuildContext context) {
    if (!isOffline) return const SizedBox.shrink();

    switch (style) {
      case OfflineBannerStyle.icon:
        return _buildIcon(context);
      case OfflineBannerStyle.topBanner:
      case OfflineBannerStyle.bottomBanner:
        return _buildBanner(context);
    }
  }

  /// Build small icon for app bar
  Widget _buildIcon(BuildContext context) {
    return Tooltip(
      message: _getTooltipMessage(),
      child: const Padding(
        padding: EdgeInsets.only(right: AppSpacing.lg),
        child: Icon(
          Icons.cloud_off,
          color: AppColors.offlineIndicator,
          size: 20,
        ),
      ),
    );
  }

  /// Build banner (top or bottom)
  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.offlineIndicator.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: style == OfflineBannerStyle.topBanner
                ? const Offset(0, 2)
                : const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cloud_off,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              _getBannerMessage(),
              style: AppTypography.bodySmall(context).copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Get tooltip message for icon
  String _getTooltipMessage() {
    if (lastUpdated != null && showLastUpdated) {
      return 'Offline - Last updated ${_formatLastUpdated()}';
    }
    return 'Offline - Showing cached data';
  }

  /// Get banner message
  String _getBannerMessage() {
    if (lastUpdated != null && showLastUpdated) {
      return 'Offline - Last updated ${_formatLastUpdated()}';
    }
    return 'Offline - Showing cached data';
  }

  /// Format last updated time in a human-friendly way
  String _formatLastUpdated() {
    if (lastUpdated == null) return 'unknown';

    final now = DateTime.now();
    final difference = now.difference(lastUpdated!);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(lastUpdated!);
    }
  }
}

/// Network status indicator with online/offline states
class NetworkStatusIndicator extends StatelessWidget {
  const NetworkStatusIndicator({
    super.key,
    required this.isOnline,
    this.showLabel = false,
  });

  /// Whether the network is online
  final bool isOnline;

  /// Whether to show online/offline label
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOnline ? AppColors.onlineIndicator : AppColors.offlineIndicator,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(width: AppSpacing.xs),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: AppTypography.bodySmall(context).copyWith(
              color: isOnline ? AppColors.onlineIndicator : AppColors.offlineIndicator,
            ),
          ),
        ],
      ],
    );
  }
}

/// Last updated indicator widget
class LastUpdatedIndicator extends StatelessWidget {
  const LastUpdatedIndicator({
    super.key,
    required this.lastUpdated,
    this.prefix = 'Updated',
  });

  /// Last updated timestamp
  final DateTime? lastUpdated;

  /// Prefix text (e.g., "Updated", "Last synced")
  final String prefix;

  @override
  Widget build(BuildContext context) {
    if (lastUpdated == null) return const SizedBox.shrink();

    return Text(
      '$prefix ${_formatLastUpdated()}',
      style: AppTypography.bodySmall(context),
    );
  }

  /// Format last updated time
  String _formatLastUpdated() {
    if (lastUpdated == null) return 'unknown';

    final now = DateTime.now();
    final difference = now.difference(lastUpdated!);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return 'on ${DateFormat('MMM d').format(lastUpdated!)}';
    }
  }
}
