import 'package:bcsv_flutter_project/domain/entities/message.dart';

/// Repository interface for message data access
abstract class MessageRepository {
  /// Get all messages
  Future<List<MessageEntity>> getMessages({bool forceRefresh = false});

  /// Get cached messages only (for offline use)
  Future<List<MessageEntity>?> getCachedMessages();

  /// Check if cached messages are available and valid
  Future<bool> hasCachedMessages();

  /// Check if the last fetch was from cache (offline mode)
  bool wasLastFetchFromCache();

  /// Clear message cache
  Future<void> clearCache();

  /// Get the timestamp of when messages were last updated
  DateTime? getLastUpdated();

  /// Get the count of new/unread messages since last check
  Future<int> getNewMessageCount();

  /// Get the last seen message timestamp
  /// Returns null if no timestamp has been set (first time user)
  DateTime? getLastSeenTimestamp();

  /// Update last seen message timestamp
  Future<void> setLastSeenTimestamp(DateTime timestamp);
}
