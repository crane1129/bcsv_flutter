import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/data/models/sunday_bible_text_model.dart';
import 'package:bcsv_flutter_project/domain/repositories/sunday_bible_text_repository.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'dart:developer';

/// Local datasource for caching Sunday Bible texts
class SundayBibleTextLocalDatasource {
  static const String _cacheFileName = 'sunday_bible_texts_cache.json';
  static const Duration _cacheDuration = Duration(days: 7); // 1 week cache

  /// Get cached Sunday Bible texts
  Future<List<SundayBibleTextModel>?> getCachedSundayBibleTexts() async {
    try {
      final cacheData = await _readCacheFile();
      if (cacheData == null) return null;

      final textsList = cacheData['texts'] as List?;
      if (textsList == null) return null;

      return textsList
          .map((json) => SundayBibleTextModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('❌ Error reading cached Sunday Bible texts: $e');
      return null;
    }
  }

  /// Cache Sunday Bible texts with the filter used to fetch them
  Future<void> cacheSundayBibleTexts(
    List<SundayBibleTextModel> texts, {
    SundayBibleTextFilter? filter,
  }) async {
    try {
      final json = {
        'texts': texts
            .map((t) => {
                  'Date': t.date,
                  'Title': t.title,
                  'Bible_chapter': t.bibleChapter,
                  'Bible_text': t.bibleText,
                  'File_url': t.fileUrl,
                  'References': t.references
                      .map((r) => {
                            'Text_Class': r.textClass,
                            'Bible_chapter': r.bibleChapter,
                            'Bible_text': r.bibleText,
                          })
                      .toList(),
                  'ReviewQuestion': t.reviewQuestion != null
                      ? {
                          'Text_Class': t.reviewQuestion!.textClass,
                          'Bible_chapter': t.reviewQuestion!.bibleChapter,
                          'Bible_text': t.reviewQuestion!.bibleText,
                        }
                      : null,
                })
            .toList(),
        'cachedAt': DateTime.now().millisecondsSinceEpoch,
        // Store filter parameters to validate cache later
        'filter': filter != null
            ? {
                'year': filter.year,
                'month': filter.month,
                'startMonth': filter.startMonth,
                'endMonth': filter.endMonth,
                'keyword': filter.keyword,
              }
            : null,
      };

      await _writeCacheFile(json);
      await UserSharedPreferences.setSundayBibleTextCacheTimestamp(
        DateTime.now().millisecondsSinceEpoch,
      );

      log('💾 Cached ${texts.length} Sunday Bible texts (filter: ${filter?.description ?? "none"})');
    } catch (e) {
      log('❌ Error caching Sunday Bible texts: $e');
    }
  }

  /// Check if cache is valid for the given filter
  Future<bool> hasValidCacheForFilter(SundayBibleTextFilter filter) async {
    final timestamp = UserSharedPreferences.getSundayBibleTextCacheTimestamp();
    if (timestamp == null) {
      return false;
    }

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final isExpired = DateTime.now().difference(cacheTime) > _cacheDuration;

    if (isExpired) {
      return false;
    }

    // Check if the cached filter matches the requested filter
    final cacheData = await _readCacheFile();
    if (cacheData == null) return false;

    final cachedFilter = cacheData['filter'] as Map<String, dynamic>?;
    if (cachedFilter == null) return false;

    // Compare filter parameters
    final filterMatches = cachedFilter['year'] == filter.year &&
        cachedFilter['month'] == filter.month &&
        cachedFilter['startMonth'] == filter.startMonth &&
        cachedFilter['endMonth'] == filter.endMonth &&
        cachedFilter['keyword'] == filter.keyword;

    if (!filterMatches) {
      log('🔄 Cache filter mismatch - cached: $cachedFilter, requested: ${filter.description}');
      return false;
    }

    final cached = await getCachedSundayBibleTexts();
    return cached != null && cached.isNotEmpty;
  }

  /// Check if cache is valid (not expired) - legacy method for fallback
  Future<bool> hasValidCache() async {
    final timestamp = UserSharedPreferences.getSundayBibleTextCacheTimestamp();
    if (timestamp == null) {
      return false;
    }

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final isExpired = DateTime.now().difference(cacheTime) > _cacheDuration;

    if (isExpired) {
      return false;
    }

    final cached = await getCachedSundayBibleTexts();
    return cached != null && cached.isNotEmpty;
  }

  /// Get cached Sunday Bible texts even if expired (for offline fallback)
  Future<List<SundayBibleTextModel>?> getCachedSundayBibleTextsIgnoreExpiry() async {
    return getCachedSundayBibleTexts();
  }

  /// Clear all cached data
  Future<void> clearCache() async {
    try {
      final file = await _getCacheFile();
      if (await file.exists()) {
        await file.delete();
      }

      await UserSharedPreferences.setSundayBibleTextCacheTimestamp(null);

      log('🗑️ Cleared Sunday Bible texts cache');
    } catch (e) {
      log('❌ Error clearing cache: $e');
    }
  }

  /// Get last updated timestamp
  DateTime? getLastUpdated() {
    final timestamp = UserSharedPreferences.getSundayBibleTextCacheTimestamp();
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
