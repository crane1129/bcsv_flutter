import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_spacing.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_typography.dart';

/// Empty state widget for consistent empty displays
///
/// Shows an icon, title, optional message, and optional action button
/// when there's no data to display.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.iconSize = 64.0,
    this.actionLabel,
    this.onAction,
  });

  /// Title text (required)
  final String title;

  /// Optional descriptive message
  final String? message;

  /// Icon to display (defaults to Icons.inbox_outlined)
  final IconData? icon;

  /// Size of the icon
  final double iconSize;

  /// Optional action button label
  final String? actionLabel;

  /// Optional action button callback
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon ?? Icons.inbox_outlined,
              size: iconSize,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Title
            Text(
              title,
              style: AppTypography.cardTitle(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),

            // Message (optional)
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppTypography.bodySmall(context),
                textAlign: TextAlign.center,
              ),
            ],

            // Action button (optional)
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Specialized empty states for common scenarios
class EmptyStates {
  EmptyStates._();

  /// No announcements available
  static Widget noAnnouncements(BuildContext context, {VoidCallback? onRefresh}) {
    return EmptyState(
      icon: Icons.campaign_outlined,
      title: 'No Announcements',
      message: 'There are no announcements at this time.',
      actionLabel: onRefresh != null ? 'Refresh' : null,
      onAction: onRefresh,
    );
  }

  /// No messages available
  static Widget noMessages(BuildContext context, {VoidCallback? onRefresh}) {
    return EmptyState(
      icon: Icons.message_outlined,
      title: 'No Messages',
      message: 'There are no messages at this time.',
      actionLabel: onRefresh != null ? 'Refresh' : null,
      onAction: onRefresh,
    );
  }

  /// No serving turns available
  static Widget noServingTurns(BuildContext context, {VoidCallback? onRefresh}) {
    return EmptyState(
      icon: Icons.event_available_outlined,
      title: 'No Serving Turns',
      message: 'There are no serving turns scheduled.',
      actionLabel: onRefresh != null ? 'Refresh' : null,
      onAction: onRefresh,
    );
  }

  /// No Bible texts available
  static Widget noBibleTexts(BuildContext context, {VoidCallback? onRefresh}) {
    return EmptyState(
      icon: Icons.menu_book_outlined,
      title: 'No Bible Texts',
      message: 'There are no Bible texts available.',
      actionLabel: onRefresh != null ? 'Refresh' : null,
      onAction: onRefresh,
    );
  }

  /// No search results
  static Widget noSearchResults(BuildContext context, {VoidCallback? onClear}) {
    return EmptyState(
      icon: Icons.search_off,
      title: 'No Results Found',
      message: 'Try adjusting your search or filters.',
      actionLabel: onClear != null ? 'Clear Filters' : null,
      onAction: onClear,
    );
  }

  /// No data available (generic)
  static Widget noData(BuildContext context, {VoidCallback? onRetry}) {
    return EmptyState(
      icon: Icons.inbox_outlined,
      title: 'No Data',
      message: 'No data is available at this time.',
      actionLabel: onRetry != null ? 'Try Again' : null,
      onAction: onRetry,
    );
  }
}
