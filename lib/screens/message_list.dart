import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'package:bcsv_flutter_project/services/app_badge_service.dart';
import 'dart:developer';

class MessageListScreen extends ConsumerStatefulWidget {
  const MessageListScreen({super.key});

  @override
  ConsumerState<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends ConsumerState<MessageListScreen> {
  @override
  void initState() {
    super.initState();
    // Load messages with force refresh on initial load, then mark as read
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // First load messages
      await ref.read(messageNotifierProvider.notifier).loadMessages(
        forceRefresh: true,
      );
      // Then mark all messages as read (after loading completes)
      await ref.read(messageNotifierProvider.notifier).markAllAsRead();
      // Clear app badge when user views messages
      AppBadgeService.removeBadge();
      log('✅ Messages loaded and marked as read, badge cleared');
    });
  }

  /// Refresh messages from network
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for messages');
    await ref.read(messageNotifierProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.newMessage,
          text2: '',
        ),
        actions: [
          // Show offline indicator if using cached data
          OfflineBanner(
            isOffline: messageState.isOfflineData,
            lastUpdated: messageState.lastUpdated,
            style: OfflineBannerStyle.icon,
          ),
        ],
      ),
      body: SafeArea(
        child: messageState.isLoading
            ? _buildLoadingState()
            : messageState.hasError
                ? _buildErrorState(messageState.errorMessage)
                : messageState.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: _refreshData,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: messageState.messages
                                .map((message) => _buildMessageCard(message))
                                .toList(),
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
          'Failed to load messages',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      icon: Icons.message_outlined,
      title: 'No Messages',
      message: 'There are no messages at this time.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }

  /// Check if URL points to an image file
  /// Supports standard extensions and Wix media URLs
  bool _isImageFile(String url) {
    if (url.isEmpty) return false;

    try {
      final lowerUrl = url.toLowerCase();

      // Check for Wix static media URLs (always images)
      if (lowerUrl.contains('static.wixstatic.com/media/')) {
        return true;
      }

      // Check for standard image extensions
      final uri = Uri.parse(url);
      final path = uri.path.toLowerCase();
      return path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.png') ||
          path.endsWith('.gif') ||
          path.endsWith('.webp') ||
          path.contains('.jpg') ||
          path.contains('.jpeg') ||
          path.contains('.png') ||
          path.contains('.gif') ||
          path.contains('.webp');
    } catch (_) {
      return false;
    }
  }

  Widget _buildMessageCard(MessageEntity message) {
    // Debug: log image URL to diagnose issues
    log('🖼️ Message "${message.title}" imageUrl: "${message.imageUrl}" (hasImage: ${message.hasImage}, isImageFile: ${_isImageFile(message.imageUrl)})');

    final theme = Theme.of(context);
    final bool showImage = message.hasImage && _isImageFile(message.imageUrl);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // Image section - same pattern as unconfirmed_opinion_screen.dart
            if (showImage)
              Image.network(
                message.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  log('❌ Failed to load image: $error');
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_rounded,
                            color: theme.colorScheme.error,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Image failed to load",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            else
              Image.asset(
                'assets/images/bridgeway.png',
                height: 100,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            // Title section
            ListTile(
              leading: Icon(Icons.event, color: kActiveIconColor(context)),
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  message.title,
                  overflow: TextOverflow.ellipsis,
                  style: kCardTitleStyle(context),
                ),
              ),
            ),
            // Message content - using Html widget for rich text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Html(
                data: message.message,
                style: {
                  "body": Style(
                    fontSize: FontSize(16),
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "p": Style(
                    fontSize: FontSize(16),
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  "a": Style(
                    color: Theme.of(context).colorScheme.primary,
                    textDecoration: TextDecoration.underline,
                  ),
                },
                onLinkTap: (url, _, __) async {
                  if (url != null) {
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  }
                },
              ),
            ),
            // External link button
            if (message.hasExternalLink)
              Padding(
                padding: const EdgeInsets.all(15),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(message.externalLink);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(Icons.link),
                  label: const Text('Link'),
                ),
              )
            else
              const SizedBox(height: 1.0),
          ],
        ),
      ),
    );
  }
}
