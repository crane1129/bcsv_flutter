import 'dart:convert';
import 'package:bcsv_flutter_project/core/storage/local_storage.dart';
import 'package:bcsv_flutter_project/core/config/app_config.dart';
import 'dart:developer';

/// Cached data wrapper with timestamp for TTL validation
class CachedData<T> {
  final T data;
  final DateTime cachedAt;
  final Duration validFor;

  CachedData({
    required this.data,
    required this.cachedAt,
    this.validFor = const Duration(hours: 24),
  });

  bool get isValid {
    final now = DateTime.now();
    return now.difference(cachedAt) < validFor;
  }

  bool get isExpired => !isValid;

  Map<String, dynamic> toJson(Object Function(T) dataToJson) {
    return {
      'data': dataToJson(data),
      'cachedAt': cachedAt.toIso8601String(),
      'validForSeconds': validFor.inSeconds,
    };
  }

  static CachedData<T>? fromJson<T>(
    Map<String, dynamic>? json,
    T Function(Object) dataFromJson,
  ) {
    if (json == null) return null;
    try {
      return CachedData(
        data: dataFromJson(json['data']),
        cachedAt: DateTime.parse(json['cachedAt'] as String),
        validFor: Duration(seconds: json['validForSeconds'] as int),
      );
    } catch (e) {
      log('Error parsing cached data: $e');
      return null;
    }
  }
}

/// Unified cache manager with TTL support
class CacheManager {
  CacheManager._();

  /// Store data with timestamp
  static Future<void> cacheData<T>({
    required String key,
    required T data,
    required Object Function(T) toJson,
    Duration validFor = const Duration(hours: 24),
  }) async {
    final cached = CachedData(
      data: data,
      cachedAt: DateTime.now(),
      validFor: validFor,
    );
    final jsonString = jsonEncode(cached.toJson(toJson));
    await LocalStorage.setString('cache_$key', jsonString);
    log('Cached data for key: $key');
  }

  /// Retrieve cached data if still valid
  static CachedData<T>? getCachedData<T>({
    required String key,
    required T Function(Object) fromJson,
    bool ignoreExpiry = false,
  }) {
    final jsonString = LocalStorage.getString('cache_$key');
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final cached = CachedData.fromJson(json, fromJson);

      if (cached == null) return null;
      if (!ignoreExpiry && cached.isExpired) {
        log('Cache expired for key: $key');
        return null;
      }

      return cached;
    } catch (e) {
      log('Error reading cache for $key: $e');
      return null;
    }
  }

  /// Check if cached data exists and is valid
  static bool hasValidCache(String key) {
    final jsonString = LocalStorage.getString('cache_$key');
    if (jsonString == null) return false;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(json['cachedAt'] as String);
      final validForSeconds = json['validForSeconds'] as int;
      final validFor = Duration(seconds: validForSeconds);

      return DateTime.now().difference(cachedAt) < validFor;
    } catch (e) {
      return false;
    }
  }

  /// Get cache timestamp (for showing "last updated" info)
  static DateTime? getCacheTimestamp(String key) {
    final jsonString = LocalStorage.getString('cache_$key');
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return DateTime.parse(json['cachedAt'] as String);
    } catch (e) {
      return null;
    }
  }

  /// Invalidate cache for a specific key
  static Future<void> invalidate(String key) async {
    await LocalStorage.remove('cache_$key');
    log('Cache invalidated for key: $key');
  }

  /// Clear all cached data
  static Future<void> clearAll() async {
    final prefs = LocalStorage.instance;
    final keys = prefs.getKeys().where((k) => k.startsWith('cache_')).toList();
    for (final key in keys) {
      await prefs.remove(key);
    }
    log('All cache cleared (${keys.length} entries)');
  }

  // Convenience methods for specific cache types

  static Future<void> cacheAnnouncements(List<Map<String, dynamic>> data) async {
    await cacheData(
      key: AppConfig.announcementCacheKey,
      data: data,
      toJson: (d) => d,
      validFor: AppConfig.cacheValidDuration,
    );
  }

  static List<Map<String, dynamic>>? getAnnouncementsCache() {
    final cached = getCachedData<List<Map<String, dynamic>>>(
      key: AppConfig.announcementCacheKey,
      fromJson: (json) => (json as List).cast<Map<String, dynamic>>(),
    );
    return cached?.data;
  }

  static Future<void> cacheMessages(List<Map<String, dynamic>> data) async {
    await cacheData(
      key: AppConfig.messageCacheKey,
      data: data,
      toJson: (d) => d,
      validFor: AppConfig.cacheValidDuration,
    );
  }

  static List<Map<String, dynamic>>? getMessagesCache() {
    final cached = getCachedData<List<Map<String, dynamic>>>(
      key: AppConfig.messageCacheKey,
      fromJson: (json) => (json as List).cast<Map<String, dynamic>>(),
    );
    return cached?.data;
  }
}
