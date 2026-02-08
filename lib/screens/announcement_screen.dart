import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/link.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/announcement_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'package:bcsv_flutter_project/core/utils/endpoint_waiter.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'dart:developer';

class AnnouncementPage extends ConsumerStatefulWidget {
  const AnnouncementPage({super.key});

  @override
  ConsumerState<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends ConsumerState<AnnouncementPage> {
  /// Track which card is expanded (null = none expanded)
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    log('🟢 [AnnouncementScreen] initState called');
    // Load announcements - wait for endpoints to initialize first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('🟢 [AnnouncementScreen] Post-frame callback - waiting for endpoints');

      // Ensure background services are initializing
      if (!BackgroundService().isInitialized && !BackgroundService().isLoading) {
        log('🔄 [AnnouncementScreen] Triggering background service initialization');
        BackgroundService().initializeInBackground();
      }

      // Also try to initialize endpoints directly if not ready
      if (!ApiEndpoint().isInitialized) {
        log('🔄 [AnnouncementScreen] Triggering endpoint initialization');
        await ApiEndpoint().initializeEndpoints();
      }

      // Wait for endpoints to be ready (max 10 seconds)
      final endpointsReady = await EndpointWaiter.waitForEndpoints();
      log('🟢 [AnnouncementScreen] Endpoints ready: $endpointsReady');

      log('🟢 [AnnouncementScreen] Initiating loadAnnouncements');
      ref.read(announcementNotifierProvider.notifier).loadAnnouncements(
        forceRefresh: false, // Use cache first
      );
    });
  }

  /// Refresh announcements from network
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for announcements');

    // Ensure endpoints are initialized before refreshing
    if (!ApiEndpoint().isInitialized) {
      log('🔄 [AnnouncementScreen] Initializing endpoints before refresh');
      await ApiEndpoint().initializeEndpoints();
      await EndpointWaiter.waitForEndpoints();
    }

    await ref.read(announcementNotifierProvider.notifier).refresh();
  }

  /// Toggle card expansion (radio behavior - only one at a time)
  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // Collapse if same card tapped
      } else {
        _expandedIndex = index; // Expand new card, collapse previous
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final announcementState = ref.watch(announcementNotifierProvider);
    log('🔵 [AnnouncementScreen] build called - status: ${announcementState.status}, count: ${announcementState.announcements.length}, isEmpty: ${announcementState.isEmpty}');

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
          text1: AppLocalizations.of(context)!.announcement,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          // Show offline indicator if using cached data
          OfflineBanner(
            isOffline: announcementState.isOfflineData,
            lastUpdated: announcementState.lastUpdated,
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
          child: announcementState.isLoading
              ? _buildLoadingState()
              : announcementState.hasError
                  ? _buildErrorState(announcementState.errorMessage)
                  : announcementState.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Modern header section
                                      _buildHeaderSection(theme),
                                      // Announcement cards
                                      _buildAnnouncementList(
                                        announcementState.announcements,
                                        theme,
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

  /// Build modern header section with icon
  Widget _buildHeaderSection(ThemeData theme) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.campaign_rounded,
              size: 28,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.announcement,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Weekly church announcements',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
  }

  /// Build the list of announcement cards
  Widget _buildAnnouncementList(
    List<AnnouncementEntity> announcements,
    ThemeData theme,
  ) {
    final filteredAnnouncements =
        announcements.where((a) => a.hasContent).toList();

    return Column(
      children: filteredAnnouncements.asMap().entries.map((entry) {
        final index = entry.key;
        final announcement = entry.value;
        final isExpanded = _expandedIndex == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: _buildAnnouncementCard(announcement, index, isExpanded, theme),
        )
            .animate()
            .fadeIn(delay: (400 + (index * 100)).ms)
            .slideX(begin: 0.3, end: 0);
      }).toList(),
    );
  }

  /// Build individual announcement card
  Widget _buildAnnouncementCard(
    AnnouncementEntity announcement,
    int index,
    bool isExpanded,
    ThemeData theme,
  ) {
    return Container(
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
            // Tappable header section
            _buildCardHeader(announcement, isExpanded, index, theme),
            // Preacher and prayer info (always visible)
            _buildInfoSection(announcement, theme),
            // Expandable content section
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: _buildExpandedContent(announcement, theme),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  /// Build card header with date and expand/collapse icon
  Widget _buildCardHeader(
    AnnouncementEntity announcement,
    bool isExpanded,
    int index,
    ThemeData theme,
  ) {
    return InkWell(
      onTap: () => _toggleExpanded(index),
      child: Container(
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
                Icons.calendar_today_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                announcement.date.isEmpty ? 'N/A' : announcement.date,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build info section with preacher and prayer (always visible)
  Widget _buildInfoSection(AnnouncementEntity announcement, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.person_outline_rounded,
            label: '설교',
            value: announcement.preacher,
            theme: theme,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            icon: Icons.volunteer_activism_rounded,
            label: '기도',
            value: announcement.prayer,
            theme: theme,
          ),
        ],
      ),
    );
  }

  /// Build a single info row (preacher/prayer)
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
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
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: kBodyTextStyle(context).copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? 'N/A' : value,
              style: kBodyTextStyle(context),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  /// Build expanded content section
  Widget _buildExpandedContent(
    AnnouncementEntity announcement,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.outline.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Announcement content section
          _buildContentSection(
            icon: Icons.campaign_outlined,
            title: '광고내용',
            content: announcement.announcement,
            theme: theme,
          ),
          const SizedBox(height: 12),
          // Offering section
          _buildContentSection(
            icon: Icons.favorite_outline_rounded,
            title: '헌금',
            content: announcement.offering.isEmpty
                ? 'N/A'
                : announcement.offering,
            theme: theme,
            isCompact: true,
          ),
          // PDF button (if available)
          if (announcement.hasPdfAttachment) ...[
            const SizedBox(height: 16),
            _buildPdfButton(announcement.fileUrl, theme),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  /// Build content section (announcement text or offering)
  Widget _buildContentSection({
    required IconData icon,
    required String title,
    required String content,
    required ThemeData theme,
    bool isCompact = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: isCompact
          // Compact layout: icon, title, and value in a single row
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.secondary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '$title:',
                  style: kListTitleStyle(context).copyWith(
                    fontSize: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    content,
                    style: kBodyTextStyle(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            )
          // Full layout: title row, then content below
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: theme.colorScheme.secondary,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: kListTitleStyle(context).copyWith(
                        fontSize: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SelectableText(
                  content.isEmpty ? 'No content available' : content,
                  style: kBodyTextStyle(context).copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
    );
  }

  /// Build modern PDF button
  Widget _buildPdfButton(String url, ThemeData theme) {
    return Link(
      target: LinkTarget.blank,
      uri: Uri.parse(url),
      builder: (context, followLink) => SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: followLink,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          icon: Icon(
            Icons.picture_as_pdf_rounded,
            size: 20,
          ),
          label: Text(
            'Open PDF',
            style: kBodyTextStyle(context).copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const LoadingIndicator(
      style: LoadingStyle.spinner,
      size: 50.0,
    );
  }

  Widget _buildErrorState(String? errorMessage) {
    return ErrorState(
      title: AppLocalizations.of(context)?.networkErrorMessage ??
          'Failed to load announcements',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  /// Build empty state when no announcements are available
  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.campaign_outlined,
      title: 'No Announcements',
      message: 'There are no announcements at this time.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }
}
