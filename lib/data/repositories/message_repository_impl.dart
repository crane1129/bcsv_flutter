import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/domain/repositories/message_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/message_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/message_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of MessageRepository with offline support
class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource _remoteDatasource;
  final MessageLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  /// Track whether the last fetch was from cache
  bool _lastFetchWasFromCache = false;

  MessageRepositoryImpl({
    MessageRemoteDatasource? remoteDatasource,
    MessageLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? MessageRemoteDatasource(),
        _localDatasource = localDatasource ?? MessageLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<List<MessageEntity>> getMessages({bool forceRefresh = false}) async {
    // Check if we have valid cached data and don't need to refresh
    if (!forceRefresh && _localDatasource.hasValidCache()) {
      log('📦 Using cached messages');
      final cached = _localDatasource.getCachedMessages();
      if (cached != null) {
        _lastFetchWasFromCache = true;
        return cached.map((m) => m.toEntity()).toList();
      }
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        log('🌐 Fetching messages from network');
        final remoteMessages = await _remoteDatasource.fetchMessages();

        // Cache the results
        await _localDatasource.cacheMessages(remoteMessages);

        _lastFetchWasFromCache = false;
        return remoteMessages.map((m) => m.toEntity()).toList();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        return _getFallbackFromCache();
      } catch (e) {
        log('❌ Unexpected error fetching messages: $e');
        return _getFallbackFromCache();
      }
    } else {
      log('📴 Offline mode - using cached messages');
      return _getFallbackFromCache();
    }
  }

  List<MessageEntity> _getFallbackFromCache() {
    final cached = _localDatasource.getCachedMessagesIgnoreExpiry();
    if (cached != null) {
      log('📦 Using fallback cache (${cached.length} items)');
      _lastFetchWasFromCache = true;
      return cached.map((m) => m.toEntity()).toList();
    }
    log('⚠️ No cached data available');
    _lastFetchWasFromCache = true;
    return [];
  }

  @override
  Future<List<MessageEntity>?> getCachedMessages() async {
    final cached = _localDatasource.getCachedMessages();
    return cached?.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> hasCachedMessages() async {
    return _localDatasource.hasValidCache();
  }

  @override
  bool wasLastFetchFromCache() {
    return _lastFetchWasFromCache;
  }

  @override
  Future<void> clearCache() async {
    await _localDatasource.clearCache();
  }

  @override
  DateTime? getLastUpdated() {
    return _localDatasource.getLastUpdated();
  }

  @override
  Future<int> getNewMessageCount() async {
    final messages = await getMessages();
    // Only count visible messages (same filter as what the user sees in the list)
    final visibleMessages = messages.where((m) => m.isVisible).toList();
    final lastSeen = getLastSeenTimestamp();

    // If no lastSeen timestamp, all visible messages are considered new
    if (lastSeen == null) return visibleMessages.length;

    // Count visible messages created after last seen timestamp
    return visibleMessages.where((m) => m.createdAt.isAfter(lastSeen)).length;
  }

  @override
  DateTime? getLastSeenTimestamp() {
    return _localDatasource.getLastSeenTimestamp();
  }

  @override
  Future<void> setLastSeenTimestamp(DateTime timestamp) async {
    await _localDatasource.setLastSeenTimestamp(timestamp);
  }
}
