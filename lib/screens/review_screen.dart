import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/sermon_review_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/sermon_review.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'package:bcsv_flutter_project/core/utils/endpoint_waiter.dart';
import 'dart:developer';

class SermonReviewScreen extends ConsumerStatefulWidget {
  const SermonReviewScreen({super.key});

  @override
  ConsumerState<SermonReviewScreen> createState() => _SermonReviewScreenState();
}

class _SermonReviewScreenState extends ConsumerState<SermonReviewScreen> {
  @override
  void initState() {
    super.initState();
    log('🟢 [SermonReviewScreen] initState called');
    // Load sermon reviews - wait for endpoints to initialize first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('🟢 [SermonReviewScreen] Post-frame callback - waiting for endpoints');

      // Wait for endpoints to be ready (max 3 seconds)
      await EndpointWaiter.waitForEndpoints();

      log('🟢 [SermonReviewScreen] Initiating loadSermonReviews');
      ref.read(sermonReviewNotifierProvider.notifier).loadSermonReviews(
        forceRefresh: false, // Use cache first
      );
    });
  }

  /// Refresh sermon reviews from network
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for sermon reviews');
    await ref.read(sermonReviewNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sermonReviewState = ref.watch(sermonReviewNotifierProvider);
    log('🔵 [SermonReviewScreen] build called - status: ${sermonReviewState.status}, count: ${sermonReviewState.sermonReviews.length}, isEmpty: ${sermonReviewState.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.8, 0.8)),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.sermonReview,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          // Show offline indicator if using cached data
          OfflineBanner(
            isOffline: sermonReviewState.isOfflineData,
            lastUpdated: sermonReviewState.lastUpdated,
            style: OfflineBannerStyle.icon,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0.95),
              theme.colorScheme.surface.withValues(alpha: 0.9),
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: sermonReviewState.isLoading
              ? _buildLoadingState()
              : sermonReviewState.hasError
                  ? _buildErrorState(sermonReviewState.errorMessage)
                  : sermonReviewState.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: _buildListPanel(sermonReviewState.sermonReviews),
                          ),
                        ),
        ),
      ),
    );
  }

  /// Build loading state
  Widget _buildLoadingState() {
    return const LoadingIndicator(
      style: LoadingStyle.spinner,
      size: 50.0,
    );
  }

  /// Build error state
  Widget _buildErrorState(String? errorMessage) {
    return ErrorState(
      title: 'Failed to load sermon reviews',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  /// Build empty state when no sermon reviews are available
  Widget _buildEmptyState() {
    return EmptyState(
      icon: FontAwesomeIcons.bible,
      title: 'No Sermon Reviews',
      message: 'There are no sermon reviews available.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }

  /// Build expansion panel list with sermon reviews
  Widget _buildListPanel(List<SermonReviewEntity> sermonReviews) {
    // Group the reviews - process them in the same way as the original
    final groupedReviews = _groupSermonReviews(sermonReviews);

    return ExpansionPanelList.radio(
      children: groupedReviews
          .map(
            (review) => ExpansionPanelRadio(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              value: review.headerText,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => _buildHeaderTile(review),
              body: _buildContentTile(review),
            ),
          )
          .toList(),
    );
  }

  /// Build header tile for expansion panel
  Widget _buildHeaderTile(_GroupedReview review) {
    return ListTile(
      leading: Icon(
        FontAwesomeIcons.bible,
        color: kActiveIconColor(context),
      ),
      title: Text(
        review.headerText,
        style: kBodyTextStyle(context),
      ),
    );
  }

  /// Build content tile for expansion panel
  Widget _buildContentTile(_GroupedReview review) {
    return ListTile(
      title: SelectableText(
        review.contentText,
        style: kBodyTextStyle(context),
      ).animate().fade(duration: 500.ms),
    );
  }

  /// Group sermon reviews - combines related questions into single entries
  /// This preserves the original screen's logic for grouping reviews
  List<_GroupedReview> _groupSermonReviews(List<SermonReviewEntity> reviews) {
    final grouped = <_GroupedReview>[];
    String applicationText = '';
    String inDepthText = '';
    String reviewText = '';

    // Process in reverse order (same as original)
    for (final review in reviews.reversed) {
      if (review.title.isEmpty) {
        // Accumulate questions without titles
        if (review.review.isNotEmpty) {
          reviewText += '\n📚복습 질문: ${review.review}\n';
        }
        if (review.application.isNotEmpty) {
          applicationText += '\n️💁‍♀️적용 질문: ${review.application}\n';
        }
        if (review.inDepth.isNotEmpty) {
          inDepthText += '\n🎓심화학습 질문: ${review.inDepth}\n';
        }
      } else {
        // Create grouped entry when we hit a title
        final contentText = '📚복습질문: ${review.review}\n$reviewText\n'
            '💁‍♀️️적용질문: ${review.application}\n$applicationText\n'
            '🎓심화학습 질문: ${review.inDepth}\n$inDepthText';

        grouped.add(_GroupedReview(
          date: review.date,
          title: review.title,
          headerText: review.headerText,
          contentText: contentText,
        ));

        // Reset accumulated texts
        applicationText = '';
        inDepthText = '';
        reviewText = '';
      }
    }

    return grouped;
  }
}

/// Helper class to hold grouped sermon review data
class _GroupedReview {
  final String date;
  final String title;
  final String headerText;
  final String contentText;

  _GroupedReview({
    required this.date,
    required this.title,
    required this.headerText,
    required this.contentText,
  });
}

/// Extension to add contentText getter to SermonReviewEntity
extension SermonReviewEntityExtension on SermonReviewEntity {
  String get contentText {
    return '📚복습질문: $review\n\n💁‍♀️️적용질문: $application\n\n🎓심화학습 질문: $inDepth';
  }
}
