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
import 'dart:developer';

class AnnouncementPage extends ConsumerStatefulWidget {
  const AnnouncementPage({super.key});

  @override
  ConsumerState<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends ConsumerState<AnnouncementPage> {
  @override
  void initState() {
    super.initState();
    log('🟢 [AnnouncementScreen] initState called');
    // Load announcements - wait for endpoints to initialize first
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('🟢 [AnnouncementScreen] Post-frame callback - waiting for endpoints');

      // Wait for endpoints to be ready (max 3 seconds)
      await EndpointWaiter.waitForEndpoints();

      log('🟢 [AnnouncementScreen] Initiating loadAnnouncements');
      ref.read(announcementNotifierProvider.notifier).loadAnnouncements(
        forceRefresh: false, // Use cache first
      );
    });
  }

  /// Refresh announcements from network
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for announcements');
    await ref.read(announcementNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final announcementState = ref.watch(announcementNotifierProvider);
    log('🔵 [AnnouncementScreen] build called - status: ${announcementState.status}, count: ${announcementState.announcements.length}, isEmpty: ${announcementState.isEmpty}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.announcement,
          text2: '',
        ),
        actions: [
          // Show offline indicator if using cached data
          OfflineBanner(
            isOffline: announcementState.isOfflineData,
            lastUpdated: announcementState.lastUpdated,
            style: OfflineBannerStyle.icon,
          ),
        ],
      ),
      body: SafeArea(
        child: announcementState.isLoading
            ? _buildLoadingState()
            : announcementState.hasError
                ? _buildErrorState(announcementState.errorMessage)
                : announcementState.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: _refreshData,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: _buildListPanel(announcementState.announcements),
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

  Widget _buildListPanel(List<AnnouncementEntity> announcements) {
    return ExpansionPanelList.radio(
      children: announcements
          .where((announcement) => announcement.hasContent)
          .map(
            (announcement) => ExpansionPanelRadio(
              value: announcement.date + announcement.preacher,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) =>
                  _buildHeaderTile(announcement),
              body: _buildContentSection(announcement),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHeaderTile(AnnouncementEntity announcement) {
    return ListTile(
      leading: const Icon(Icons.calendar_today_outlined),
      title: Text(
        announcement.headerText,
        style: kBodyTextStyle(context),
      ),
      iconColor: Theme.of(context).colorScheme.surface,
    );
  }

  Widget _buildContentSection(AnnouncementEntity announcement) {
    return Column(
      children: [
        ListTile(
          title: Text(
            announcement.prayerInfo,
            style: kBodyTextStyle(context),
          ),
        ),
        ListTile(
          title: SelectableText(
            announcement.contentText,
            style: kBodyTextStyle(context),
          ).animate().fade(duration: 500.ms),
        ),
        if (announcement.hasPdfAttachment)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Link(
              target: LinkTarget.blank,
              uri: Uri.parse(announcement.fileUrl),
              builder: (context, followLink) => ElevatedButton(
                onPressed: followLink,
                child: const Text('Open PDF'),
              ),
            ),
          ),
      ],
    );
  }
}
