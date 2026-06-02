import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/daily_bible_provider.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'package:bcsv_flutter_project/core/utils/endpoint_waiter.dart';
import 'dart:developer';

class DailyBibleTextScreen extends ConsumerStatefulWidget {
  const DailyBibleTextScreen({super.key});

  @override
  ConsumerState<DailyBibleTextScreen> createState() => _DailyBibleTextScreenState();
}

class _DailyBibleTextScreenState extends ConsumerState<DailyBibleTextScreen> {
  @override
  void initState() {
    super.initState();
    log('🟢 [DailyBibleScreen] initState called');
    // Load today's daily Bible - wait for endpoints to initialize first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('🟢 [DailyBibleScreen] Post-frame callback - waiting for endpoints');

      // Wait for endpoints to be ready (max 3 seconds)
      await EndpointWaiter.waitForEndpoints();

      log('🟢 [DailyBibleScreen] Initiating loadToday');
      ref.read(dailyBibleNotifierProvider.notifier).loadToday(forceRefresh: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dailyBibleNotifierProvider);
    log('🔵 [DailyBibleScreen] build called - status: ${state.status}, hasData: ${state.dailyBible != null}, isEmpty: ${state.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ).animate().fadeIn(delay: 200.ms).scale(begin: Offset(0.8, 0.8)),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.dailyBible,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          // Offline indicator
          OfflineBanner(
            isOffline: state.isOfflineData,
            lastUpdated: state.lastUpdated,
            style: OfflineBannerStyle.icon,
          ),
          // Font size controls
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.text_increase_rounded),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    ref.read(dailyBibleNotifierProvider.notifier).increaseFontSize();
                  },
                  tooltip: 'Increase Font Size',
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.3),
                ),
                IconButton(
                  icon: const Icon(Icons.text_decrease_rounded),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    ref.read(dailyBibleNotifierProvider.notifier).decreaseFontSize();
                  },
                  tooltip: 'Decrease Font Size',
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: state.isLoading
              ? _buildLoadingState()
              : state.hasError
                  ? _buildErrorState(state.errorMessage)
                  : RefreshIndicator(
                      onRefresh: _refreshData,
                      child: state.isEmpty
                          ? _buildEmptyState()
                          : CustomScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Date navigation section
                                        _buildDateNavigation(state),

                                        // Bible content card
                                        if (state.dailyBible != null)
                                          _buildBibleContentCard(state),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      title: 'Failed to load daily Bible',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  /// Build empty state
  Widget _buildEmptyState() {
    return EmptyState(
      icon: FontAwesomeIcons.bookBible,
      title: 'No Daily Bible',
      message: 'No daily Bible text available for this date.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }

  /// Refresh data
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for daily Bible');
    await ref.read(dailyBibleNotifierProvider.notifier).refresh();
  }

  Widget _buildDateNavigation(DailyBibleState state) {
    final theme = Theme.of(context);
    final currentDate = state.currentDate.isNotEmpty
        ? DateTime.tryParse(state.currentDate) ?? DateTime.now()
        : DateTime.now();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
            theme.colorScheme.surface,
            theme.colorScheme.secondaryContainer.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Date display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  FontAwesomeIcons.calendar,
                  size: 24,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE, MMMM d, yyyy').format(currentDate),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.isToday ? 'Today\'s Reading' : 'Previous Reading',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ref.read(dailyBibleNotifierProvider.notifier).goToPreviousDay();
                  },
                  icon: const Icon(Icons.chevron_left_rounded),
                  label: const Text('Previous Day'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: state.isToday ? null : () {
                    ref.read(dailyBibleNotifierProvider.notifier).goToNextDay();
                  },
                  icon: const Icon(Icons.chevron_right_rounded),
                  label: const Text('Next Day'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isToday
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.primaryContainer,
                    foregroundColor: state.isToday
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
  }

  /// Build modern Bible content card
  Widget _buildBibleContentCard(DailyBibleState state) {
    final theme = Theme.of(context);
    final dailyBible = state.dailyBible;
    if (dailyBible == null) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header with bible reference
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      FontAwesomeIcons.bookBible,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dailyBible.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                            fontSize: state.fontSize + 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dailyBible.date,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            fontSize: state.fontSize - 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),

            // Bible text content with verses
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: dailyBible.verses.map((verse) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${verse.verse} ',
                            style: kBodyTextStyle(context, fontSize: state.fontSize).copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: verse.content,
                            style: kBodyTextStyle(context, fontSize: state.fontSize).copyWith(
                              height: 1.6,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 800.ms)
                .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }
}
