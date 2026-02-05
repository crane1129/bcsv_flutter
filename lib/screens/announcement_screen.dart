import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/link.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/announcement_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
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
    // Load announcements with force refresh on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(announcementNotifierProvider.notifier).loadAnnouncements(
        forceRefresh: true,
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
          // Show indicator if using offline data
          if (announcementState.isOfflineData)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.cloud_off,
                color: Colors.orange,
                size: 20,
              ),
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: SpinKitFadingCube(
              itemBuilder: (BuildContext context, int index) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.dataLoading ??
                'Loading announcements...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String? errorMessage) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.networkErrorMessage ??
                'Failed to load announcements',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (errorMessage != null)
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5),
                  ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            label:
                Text(AppLocalizations.of(context)?.tryAgain ?? 'Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state when no announcements are available
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement_outlined,
            size: 80,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.announcement ??
                'No announcements available',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Pull down to refresh or check your connection',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: const Icon(Icons.refresh),
            label:
                Text(AppLocalizations.of(context)?.tryAgain ?? 'Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
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
