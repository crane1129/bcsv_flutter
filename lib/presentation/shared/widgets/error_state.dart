import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_spacing.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_typography.dart';
import 'package:bcsv_flutter_project/presentation/shared/theme/app_colors.dart';

/// Error type for categorizing different error scenarios
enum ErrorType {
  /// Network connectivity error
  network,

  /// Server error (5xx)
  server,

  /// Client error (4xx)
  client,

  /// Unknown/generic error
  unknown,

  /// Timeout error
  timeout,
}

/// Error state widget for consistent error handling UI
///
/// Shows an icon, title, error message, and retry button
/// Supports different error types with appropriate icons and colors
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.title,
    this.message,
    this.errorType = ErrorType.unknown,
    this.onRetry,
    this.retryLabel = 'Try Again',
  });

  /// Error title
  final String title;

  /// Error message (optional)
  final String? message;

  /// Type of error
  final ErrorType errorType;

  /// Retry callback (optional)
  final VoidCallback? onRetry;

  /// Retry button label
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final errorIcon = _getErrorIcon();
    final errorColor = _getErrorColor(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Error icon
            Icon(
              errorIcon,
              size: 64.0,
              color: errorColor,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Error title
            Text(
              title,
              style: AppTypography.cardTitle(context).copyWith(
                color: errorColor,
              ),
              textAlign: TextAlign.center,
            ),

            // Error message (optional)
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: AppTypography.bodySmall(context),
                textAlign: TextAlign.center,
              ),
            ],

            // Retry button (optional)
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryLabel),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Get icon based on error type
  IconData _getErrorIcon() {
    switch (errorType) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.client:
        return Icons.error_outline;
      case ErrorType.timeout:
        return Icons.access_time;
      case ErrorType.unknown:
        return Icons.warning_amber_rounded;
    }
  }

  /// Get color based on error type
  Color _getErrorColor(BuildContext context) {
    switch (errorType) {
      case ErrorType.network:
        return AppColors.warning;
      case ErrorType.server:
      case ErrorType.client:
      case ErrorType.unknown:
        return AppColors.error;
      case ErrorType.timeout:
        return AppColors.warning;
    }
  }
}

/// Specialized error states for common scenarios
class ErrorStates {
  ErrorStates._();

  /// Network connection error
  static Widget networkError(BuildContext context, {VoidCallback? onRetry}) {
    return ErrorState(
      title: 'No Internet Connection',
      message: 'Please check your internet connection and try again.',
      errorType: ErrorType.network,
      onRetry: onRetry,
    );
  }

  /// Server error (5xx)
  static Widget serverError(BuildContext context, {VoidCallback? onRetry}) {
    return ErrorState(
      title: 'Server Error',
      message: 'Something went wrong on our end. Please try again later.',
      errorType: ErrorType.server,
      onRetry: onRetry,
    );
  }

  /// Request timeout error
  static Widget timeoutError(BuildContext context, {VoidCallback? onRetry}) {
    return ErrorState(
      title: 'Request Timeout',
      message: 'The request took too long. Please try again.',
      errorType: ErrorType.timeout,
      onRetry: onRetry,
    );
  }

  /// Generic error
  static Widget genericError(
    BuildContext context, {
    String? message,
    VoidCallback? onRetry,
  }) {
    return ErrorState(
      title: 'Something Went Wrong',
      message: message ?? 'An unexpected error occurred. Please try again.',
      errorType: ErrorType.unknown,
      onRetry: onRetry,
    );
  }

  /// Loading failed error
  static Widget loadingFailed(
    BuildContext context, {
    required String dataType,
    VoidCallback? onRetry,
  }) {
    return ErrorState(
      title: 'Failed to Load $dataType',
      message: 'Unable to load $dataType. Please try again.',
      errorType: ErrorType.unknown,
      onRetry: onRetry,
    );
  }
}
