import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/data/models/daily_bible_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'dart:developer';

/// Local datasource for caching daily Bible data
class DailyBibleLocalDatasource {
  static const String _cacheFileName = 'daily_bible_cache.json';

  /// Get cached daily Bible for a specific date
  Future<DailyBibleModel?> getCachedDailyBible(String date) async {
    try {
      final cacheData = await _readCacheFile();
      if (cacheData == null) return null;

      // Check if cached date matches requested date
      if (cacheData['date'] != date) {
        log('⚠️ Cached date (${cacheData['date']}) does not match requested date ($date)');
        return null;
      }

      return DailyBibleModel.fromJson(cacheData);
    } catch (e) {
      log('❌ Error reading cached daily Bible: $e');
      return null;
    }
  }

  /// Cache daily Bible data
  /// Only caches if there are verses (empty verses indicates fetch error)
  Future<void> cacheDailyBible(DailyBibleModel dailyBible) async {
    try {
      // Don't cache if no verses - this indicates a partial/failed fetch
      if (dailyBible.verses.isEmpty) {
        log('⚠️ Skipping cache - no verses to cache for date ${dailyBible.date}');
        return;
      }

      final json = {
        'date': dailyBible.date,
        'bibleName': dailyBible.bibleName,
        'bibleChapter': dailyBible.bibleChapter,
        'verses': dailyBible.verses
            .map((v) => {
                  'Verse': v.verse,
                  'Bible_Cn': v.content,
                })
            .toList(),
      };

      await _writeCacheFile(json);
      await UserSharedPreferences.setDailyBibleCacheDate(dailyBible.date);
      await UserSharedPreferences.setDailyBibleCacheTimestamp(
        DateTime.now().millisecondsSinceEpoch,
      );

      log('💾 Cached daily Bible for date ${dailyBible.date} (${dailyBible.verses.length} verses)');
    } catch (e) {
      log('❌ Error caching daily Bible: $e');
    }
  }

  /// Check if cache is valid for a specific date
  /// Daily Bible cache is valid only for the same date and must have verses
  Future<bool> hasValidCache(String date) async {
    final cachedDate = UserSharedPreferences.getDailyBibleCacheDate();
    if (cachedDate != date) {
      return false;
    }

    final cached = await getCachedDailyBible(date);
    // Cache is only valid if it has verses
    return cached != null && cached.verses.isNotEmpty;
  }

  /// Get cached daily Bible even if for different date (for offline fallback)
  Future<DailyBibleModel?> getCachedDailyBibleIgnoreDate() async {
    try {
      final cacheData = await _readCacheFile();
      if (cacheData == null) return null;

      return DailyBibleModel.fromJson(cacheData);
    } catch (e) {
      log('❌ Error reading cached daily Bible (ignore date): $e');
      return null;
    }
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      final file = await _getCacheFile();
      if (await file.exists()) {
        await file.delete();
      }

      await UserSharedPreferences.setDailyBibleCacheDate(null);
      await UserSharedPreferences.setDailyBibleCacheTimestamp(null);

      log('🗑️ Cleared daily Bible cache');
    } catch (e) {
      log('❌ Error clearing cache: $e');
    }
  }

  /// Get last updated timestamp
  DateTime? getLastUpdated() {
    final timestamp = UserSharedPreferences.getDailyBibleCacheTimestamp();
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Get cache file
  Future<File> _getCacheFile() async {
    final dir = await getTemporaryDirectory();
    return File('${dir.path}/$_cacheFileName');
  }

  /// Read cache file
  Future<Map<String, dynamic>?> _readCacheFile() async {
    try {
      final file = await _getCacheFile();
      if (!await file.exists()) return null;

      final contents = await file.readAsString();
      return jsonDecode(contents) as Map<String, dynamic>;
    } catch (e) {
      log('❌ Error reading cache file: $e');
      return null;
    }
  }

  /// Write cache file
  Future<void> _writeCacheFile(Map<String, dynamic> data) async {
    try {
      final file = await _getCacheFile();
      await file.writeAsString(
        jsonEncode(data),
        flush: true,
        mode: FileMode.write,
      );
    } catch (e) {
      log('❌ Error writing cache file: $e');
    }
  }
}
