import 'dart:convert';
import 'package:bcsv_flutter_project/data/models/keyverse_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'dart:developer';

/// Local datasource for caching key verse data
class KeyVerseLocalDatasource {
  static const Duration _cacheDuration = Duration(hours: 24);

  /// Get cached key verse for a specific year
  KeyVerseModel? getCachedKeyVerse(int year) {
    try {
      // Check both new and old cache year keys for backward compatibility
      final cachedYear = UserSharedPreferences.getKeyverseCachedYear() ??
                         UserSharedPreferences.getInt('keyverse_year');
      if (cachedYear != year) {
        log('⚠️ Cached year ($cachedYear) does not match requested year ($year)');
        return null;
      }

      final cachedJson = UserSharedPreferences.getKeyverseCache();
      if (cachedJson == null || cachedJson.isEmpty) {
        return null;
      }

      var json = jsonDecode(cachedJson) as Map<String, dynamic>;

      // Handle old cache format: {results: [{...}]}
      if (json.containsKey('results')) {
        final results = json['results'] as List?;
        if (results == null || results.isEmpty) {
          log('⚠️ Old cache format with empty results');
          return null;
        }
        json = results.first as Map<String, dynamic>;
      }

      // Normalize snake_case to camelCase for backward compatibility
      json = _normalizeJsonKeys(json);

      log('📦 Parsed cached key verse: title=${json['title']}, verse=${(json['verse'] as String?)?.substring(0, 20) ?? 'null'}...');
      return KeyVerseModel.fromJson(json);
    } catch (e) {
      log('❌ Error reading cached key verse: $e');
      return null;
    }
  }

  /// Normalize JSON keys from snake_case to camelCase
  Map<String, dynamic> _normalizeJsonKeys(Map<String, dynamic> json) {
    return {
      'year': json['year'],
      'title': json['title'],
      'book': json['book'],
      'chapter': json['chapter'],
      'verseFrom': json['verseFrom'] ?? json['verse_from'],
      'verseEnd': json['verseEnd'] ?? json['verse_end'],
      'verse': json['verse'],
    };
  }

  /// Cache key verse data
  Future<void> cacheKeyVerse(KeyVerseModel keyVerse) async {
    try {
      final json = {
        'year': keyVerse.year,
        'title': keyVerse.title,
        'book': keyVerse.book,
        'chapter': keyVerse.chapter,
        'verseFrom': keyVerse.verseFrom,
        'verseEnd': keyVerse.verseEnd,
        'verse': keyVerse.verse,
      };

      await UserSharedPreferences.setKeyverseCache(jsonEncode(json));
      await UserSharedPreferences.setKeyverseCacheTimestamp(
        DateTime.now().millisecondsSinceEpoch,
      );
      await UserSharedPreferences.setKeyverseCachedYear(keyVerse.year);

      log('💾 Cached key verse for year ${keyVerse.year}');
    } catch (e) {
      log('❌ Error caching key verse: $e');
    }
  }

  /// Check if cache is valid (not expired and for correct year)
  bool hasValidCache(int year) {
    // Check both new and old cache year keys for backward compatibility
    final cachedYear = UserSharedPreferences.getKeyverseCachedYear() ??
                       UserSharedPreferences.getInt('keyverse_year');
    if (cachedYear != year) {
      return false;
    }

    // Check both new and old timestamp keys
    final timestamp = UserSharedPreferences.getKeyverseCacheTimestamp() ??
                      UserSharedPreferences.getInt('keyverse_cache_timestamp');
    if (timestamp == null) {
      return false;
    }

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final isExpired = DateTime.now().difference(cacheTime) > _cacheDuration;

    return !isExpired && getCachedKeyVerse(year) != null;
  }

  /// Get cached key verse even if expired (for offline fallback)
  KeyVerseModel? getCachedKeyVerseIgnoreExpiry(int year) {
    return getCachedKeyVerse(year);
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    await UserSharedPreferences.setKeyverseCache(null);
    await UserSharedPreferences.setKeyverseCacheTimestamp(null);
    await UserSharedPreferences.setKeyverseCachedYear(null);
    log('🗑️ Cleared key verse cache');
  }

  /// Get last updated timestamp
  DateTime? getLastUpdated() {
    final timestamp = UserSharedPreferences.getKeyverseCacheTimestamp();
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
