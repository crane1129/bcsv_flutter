import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/domain/repositories/message_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/message_repository_impl.dart';
import 'package:bcsv_flutter_project/services/app_badge_service.dart';
import 'dart:developer';

/// State for message list
enum MessageStatus { initial, loading, loaded, error }

class MessageState {
  final List<MessageEntity> messages;
  final MessageStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;
  final int unreadCount;

  const MessageState({
    this.messages = const [],
    this.status = MessageStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
    this.unreadCount = 0,
  });

  MessageState copyWith({
    List<MessageEntity>? messages,
    MessageStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
    int? unreadCount,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  bool get isLoading => status == MessageStatus.loading;
  bool get hasError => status == MessageStatus.error;
  bool get hasData => messages.isNotEmpty;
  bool get isEmpty => messages.isEmpty && status == MessageStatus.loaded;
  bool get hasUnread => unreadCount > 0;
}

/// Notifier for message state
/// This replaces the global messageCnt variable from globals.dart
class MessageNotifier extends StateNotifier<MessageState> {
  final MessageRepository _repository;

  MessageNotifier(this._repository) : super(const MessageState());

  /// Load messages (with caching)
  /// Filters to only show visible messages based on startDate/endDate
  Future<void> loadMessages({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    if (!state.hasData) {
      state = state.copyWith(status: MessageStatus.loading);
    }
    log('🔄 Loading messages (forceRefresh: $forceRefresh)');

    try {
      final allMessages = await _repository.getMessages(forceRefresh: forceRefresh);

      // Debug: log each message's visibility
      final now = DateTime.now();
      for (final m in allMessages) {
        log('📅 Message "${m.title}": startDate=${m.startDate}, now=$now, isVisible=${m.isVisible}');
      }

      // Filter to only visible messages based on startDate/endDate
      final visibleMessages = allMessages.where((m) => m.isVisible).toList();

      final lastUpdated = _repository.getLastUpdated();
      final wasFromCache = _repository.wasLastFetchFromCache();
      final unreadCount = await _repository.getNewMessageCount();

      // Update app badge
      log('🔴 [MessageProvider] Setting app badge count: $unreadCount');
      await AppBadgeService.updateBadgeCount(unreadCount);

      state = state.copyWith(
        messages: visibleMessages,
        status: MessageStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: wasFromCache,
        unreadCount: unreadCount,
        errorMessage: null,
      );

      log('✅ Loaded ${visibleMessages.length} visible messages (${allMessages.length} total), $unreadCount unread');
    } catch (e) {
      log('❌ Error loading messages: $e');
      if (!state.hasData) {
        state = state.copyWith(
          status: MessageStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  /// Refresh messages from network
  Future<void> refresh() async {
    await loadMessages(forceRefresh: true);
  }

  /// Mark all messages as read
  /// Uses the most recent message's createdAt timestamp
  Future<void> markAllAsRead() async {
    if (state.messages.isEmpty) return;

    // Find the most recent message timestamp
    final maxTimestamp = state.messages
        .map((m) => m.createdAt)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    await _repository.setLastSeenTimestamp(maxTimestamp);
    state = state.copyWith(unreadCount: 0);

    // Clear app badge
    AppBadgeService.removeBadge();
    log('✅ Marked all messages as read (lastSeen: $maxTimestamp)');
  }

  /// Update unread count
  Future<void> updateUnreadCount() async {
    final count = await _repository.getNewMessageCount();
    state = state.copyWith(unreadCount: count);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload() async {
    await _repository.clearCache();
    await loadMessages(forceRefresh: true);
  }
}

/// Provider for message repository
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepositoryImpl();
});

/// Provider for message state
final messageNotifierProvider =
    StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  final repository = ref.watch(messageRepositoryProvider);
  return MessageNotifier(repository);
});

/// Convenience provider for just the messages list
final messagesProvider = Provider<List<MessageEntity>>((ref) {
  return ref.watch(messageNotifierProvider).messages;
});

/// Provider for unread message count (replaces globals.messageCnt)
final unreadMessageCountProvider = Provider<int>((ref) {
  return ref.watch(messageNotifierProvider).unreadCount;
});

/// Provider for loading state
final messagesLoadingProvider = Provider<bool>((ref) {
  return ref.watch(messageNotifierProvider).isLoading;
});

/// Provider for checking if there are unread messages
final hasUnreadMessagesProvider = Provider<bool>((ref) {
  return ref.watch(messageNotifierProvider).hasUnread;
});
