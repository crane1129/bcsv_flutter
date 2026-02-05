import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
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
    // Load messages with force refresh on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageNotifierProvider.notifier).loadMessages(
        forceRefresh: true,
      );
      // Mark all messages as read when user opens the screen
      ref.read(messageNotifierProvider.notifier).markAllAsRead();
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
          // Show indicator if using offline data
          if (messageState.isOfflineData)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.cloud_off,
                color: Colors.orange,
                size: 20,
              ),
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
    return Center(
      child: SizedBox(
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
                'Failed to load messages',
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

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 80,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.newMessage ?? 'No messages available',
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
            'Pull down to refresh',
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

  Widget _buildMessageCard(MessageEntity message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // Image section
            message.hasImage
                ? Image.network(
                    message.imageLink,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/bridgeway.png',
                        height: 100,
                        width: 200,
                        fit: BoxFit.fitWidth,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/bridgeway.png',
                    height: 100,
                    width: 200,
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
            // Message content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectableText(
                message.message,
                style: kBodyTextStyle(context),
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
