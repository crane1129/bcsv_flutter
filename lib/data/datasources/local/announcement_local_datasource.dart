import 'package:bcsv_flutter_project/data/models/announcement_model.dart';
import 'package:bcsv_flutter_project/core/storage/cache_manager.dart';
import 'package:bcsv_flutter_project/core/config/app_config.dart';
import 'dart:developer';

/// Local datasource for caching announcements
class AnnouncementLocalDatasource {
  static const String _cacheKey = 'announcements';

  /// Save announcements to cache
  Future<void> cacheAnnouncements(List<AnnouncementModel> announcements) async {
    try {
      final jsonList = announcements.map((a) => a.toJson()).toList();

      await CacheManager.cacheData<List<Map<String, dynamic>>>(
        key: _cacheKey,
        data: jsonList,
        toJson: (data) => data,
        validFor: AppConfig.cacheValidDuration,
      );

      log('✅ Cached ${announcements.length} announcements');
    } catch (e) {
      log('❌ Error caching announcements: $e');
    }
  }

  /// Get cached announcements
  List<AnnouncementModel>? getCachedAnnouncements() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
      );

      if (cached == null) {
        log('📦 No cached announcements found');
        return null;
      }

      final announcements = cached.data
          .map((json) => AnnouncementModel.fromJson(json as Map<String, dynamic>))
          .toList();

      log('📦 Retrieved ${announcements.length} cached announcements');
      return announcements;
    } catch (e) {
      log('❌ Error reading cached announcements: $e');
      return null;
    }
  }

  /// Get cached announcements even if expired (for offline fallback)
  List<AnnouncementModel>? getCachedAnnouncementsIgnoreExpiry() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
        ignoreExpiry: true,
      );

      if (cached == null) {
        return null;
      }

      return cached.data
          .map((json) => AnnouncementModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('❌ Error reading cached announcements (ignore expiry): $e');
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

  /// Clear announcement cache
  Future<void> clearCache() async {
    await CacheManager.invalidate(_cacheKey);
    log('🗑️ Announcement cache cleared');
  }
}
