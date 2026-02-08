import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/serving_turn_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'package:bcsv_flutter_project/core/utils/endpoint_waiter.dart';
import 'dart:developer';

class ServingTurnPage extends ConsumerStatefulWidget {
  const ServingTurnPage({super.key});

  @override
  ConsumerState<ServingTurnPage> createState() => _ServingTurnPageState();
}

class _ServingTurnPageState extends ConsumerState<ServingTurnPage> {
  @override
  void initState() {
    super.initState();
    log('🟢 [ServingTurnScreen] initState called');
    // Load serving turns - wait for endpoints to initialize first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('🟢 [ServingTurnScreen] Post-frame callback - waiting for endpoints');

      // Wait for endpoints to be ready (max 3 seconds)
      await EndpointWaiter.waitForEndpoints();

      log('🟢 [ServingTurnScreen] Initiating loadServingTurns');
      ref.read(servingTurnNotifierProvider.notifier).loadServingTurns(
        forceRefresh: false, // Use cache first
      );
    });
  }

  /// Refresh serving turns from network
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for serving turns');
    await ref.read(servingTurnNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final servingTurnState = ref.watch(servingTurnNotifierProvider);
    log('🔵 [ServingTurnScreen] build called - status: ${servingTurnState.status}, count: ${servingTurnState.servingTurns.length}, isEmpty: ${servingTurnState.isEmpty}');

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
          text1: AppLocalizations.of(context)!.servingTurn,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          // Show offline indicator if using cached data
          OfflineBanner(
            isOffline: servingTurnState.isOfflineData,
            lastUpdated: servingTurnState.lastUpdated,
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
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: servingTurnState.isLoading
              ? _buildLoadingState(theme)
              : servingTurnState.hasError
                  ? _buildErrorState(servingTurnState.errorMessage)
                  : servingTurnState.isEmpty
                      ? _buildEmptyState(theme)
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    // Modern header section
                                    Container(
                                      margin: EdgeInsets.only(bottom: 24),
                                      padding: EdgeInsets.all(20),
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
                                            offset: Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Icon(
                                              Icons.people_outline_rounded,
                                              size: 28,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.servingTurn,
                                                  style: theme.textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: theme.colorScheme.onSurface,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Church service schedule',
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).animate()
                                      .fadeIn(duration: 600.ms)
                                      .slideY(begin: -0.2, end: 0),
                                    
                                    // Modern card grid
                                    Column(
                                      children: servingTurnState.servingTurns.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        ServingTurnEntity servingTurn = entry.value;
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 16),
                                          child: _buildModernServingCard(servingTurn),
                                        ).animate()
                                          .fadeIn(delay: (400 + (index * 100)).ms)
                                          .slideX(begin: 0.3, end: 0);
                                      }).toList(),
                                    ),
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

  /// Build modern loading state
  Widget _buildLoadingState(ThemeData theme) {
    return const LoadingIndicator(
      style: LoadingStyle.spinner,
      size: 50.0,
    );
  }

  /// Build empty state when no serving turns are available
  Widget _buildEmptyState(ThemeData theme) {
    return EmptyState(
      icon: Icons.event_available_outlined,
      title: 'No Serving Turns',
      message: 'There are no serving turns scheduled.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }

  /// Build error state
  Widget _buildErrorState(String? errorMessage) {
    return ErrorState(
      title: 'Failed to load serving turns',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  /// Build modern serving card with enhanced styling
  Widget _buildModernServingCard(ServingTurnEntity content) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header with date
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      content.date.isEmpty ? 'N/A' : content.date,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content tiles
            ModernServingTurnTile(
              content: content.prayer,
              leadingText: Text(
                AppLocalizations.of(context)!.prayer,
                style: kBodyTextStyle(context),
              ),
              icon: Icons.mic_outlined,
            ),
            ModernServingTurnTile(
              content: content.food,
              leadingText: Text(
                AppLocalizations.of(context)!.foodPrep,
                style: kBodyTextStyle(context),
                maxLines: 1,
              ),
              icon: Icons.restaurant_rounded,
            ),
            ModernServingTurnTile(
              content: '${content.prayerDate}\n${content.babysitter}',
              leadingText: Text(
                AppLocalizations.of(context)!.wednesday_worship,
                style: kBodyTextStyle(context),
                maxLines: 1,
              ),
              icon: Icons.baby_changing_station,
            ),
          ],
        ),
      ),
    );
  }
}

class ModernServingTurnTile extends StatelessWidget {
  const ModernServingTurnTile({
    super.key,
    required this.content,
    required this.leadingText,
    required this.icon,
  });

  final Widget leadingText;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 16,
            ),
          ),
          SizedBox(width: 4),
          
          // Leading text
          Expanded(
            flex: 1,
            child: leadingText,
          ),
          
          SizedBox(width: 4),
          
          // Content
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                content.isEmpty ? 'N/A' : content,
                style: kBodyTextStyle(context),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Keep the original ServingTurnTile for backward compatibility if needed
class ServingTurnTile extends StatelessWidget {
  const ServingTurnTile({
    super.key,
    required this.content,
    required this.leadingText,
  });

  final Widget leadingText;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
      leading: leadingText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                content.isEmpty ? 'N/A' : content,
                style: kBodyTextStyle(context),
                overflow: TextOverflow.ellipsis, // Optional
                maxLines: 1, // Optional
              ),
            ),
          ),
        ],
      ),
    );
  }
}
