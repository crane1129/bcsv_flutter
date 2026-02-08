import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/core/storage/cache_manager.dart';
import 'package:bcsv_flutter_project/core/config/app_config.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'dart:developer';

/// Local datasource for caching messages
class MessageLocalDatasource {
  static const String _cacheKey = 'messages';

  /// Save messages to cache
  Future<void> cacheMessages(List<MessageModel> messages) async {
    try {
      final jsonList = messages.map((m) => m.toJson()).toList();

      await CacheManager.cacheData<List<Map<String, dynamic>>>(
        key: _cacheKey,
        data: jsonList,
        toJson: (data) => data,
        validFor: AppConfig.cacheValidDuration,
      );

      log('✅ Cached ${messages.length} messages');
    } catch (e) {
      log('❌ Error caching messages: $e');
    }
  }

  /// Get cached messages
  List<MessageModel>? getCachedMessages() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
      );

      if (cached == null) {
        log('📦 No cached messages found');
        return null;
      }

      final messages = cached.data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();

      log('📦 Retrieved ${messages.length} cached messages');
      return messages;
    } catch (e) {
      log('❌ Error reading cached messages: $e');
      return null;
    }
  }

  /// Get cached messages even if expired (for offline fallback)
  List<MessageModel>? getCachedMessagesIgnoreExpiry() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
        ignoreExpiry: true,
      );

      if (cached == null) return null;

      return cached.data
          .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('❌ Error reading cached messages (ignore expiry): $e');
      return null;
    }
  }

  /// Check if valid cache exists
  bool hasValidCache() {
    return CacheManager.hasValidCache(_cacheKey);
  }

  /// Get cache timestamp
  DateTime? getLastUpdated() {
    return CacheManager.getCacheTimestamp(_cacheKey);
  }

  /// Clear message cache
  Future<void> clearCache() async {
    await CacheManager.invalidate(_cacheKey);
    log('🗑️ Message cache cleared');
  }

  /// Get last seen message timestamp from SharedPreferences
  /// Returns null if no timestamp has been set (first time user)
  DateTime? getLastSeenTimestamp() {
    final timestamp = UserSharedPreferences.getLastSeenMessageTimestamp();
    if (timestamp == null) return null;
    return DateTime.tryParse(timestamp);
  }

  /// Set last seen message timestamp (ISO8601 string)
  Future<void> setLastSeenTimestamp(DateTime timestamp) async {
    await UserSharedPreferences.setLastSeenMessageTimestamp(
      timestamp.toIso8601String(),
    );
  }
}
