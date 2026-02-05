import 'package:bcsv_flutter_project/data/models/serving_turn_model.dart';
import 'package:bcsv_flutter_project/core/storage/cache_manager.dart';
import 'package:bcsv_flutter_project/core/config/app_config.dart';
import 'dart:developer';

/// Local datasource for caching serving turns
class ServingTurnLocalDatasource {
  static const String _cacheKey = 'serving_turns';

  /// Save serving turns to cache
  Future<void> cacheServingTurns(List<ServingTurnModel> servingTurns) async {
    try {
      final jsonList = servingTurns.map((s) => s.toJson()).toList();

      await CacheManager.cacheData<List<Map<String, dynamic>>>(
        key: _cacheKey,
        data: jsonList,
        toJson: (data) => data,
        validFor: AppConfig.cacheValidDuration,
      );

      log('✅ Cached ${servingTurns.length} serving turns');
    } catch (e) {
      log('❌ Error caching serving turns: $e');
    }
  }

  /// Get cached serving turns
  List<ServingTurnModel>? getCachedServingTurns() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
      );

      if (cached == null) {
        log('📦 No cached serving turns found');
        return null;
      }

      final servingTurns = cached.data
          .map((json) => ServingTurnModel.fromJson(json as Map<String, dynamic>))
          .toList();

      log('📦 Retrieved ${servingTurns.length} cached serving turns');
      return servingTurns;
    } catch (e) {
      log('❌ Error reading cached serving turns: $e');
      return null;
    }
  }

  /// Get cached serving turns even if expired (for offline fallback)
  List<ServingTurnModel>? getCachedServingTurnsIgnoreExpiry() {
    try {
      final cached = CacheManager.getCachedData<List<dynamic>>(
        key: _cacheKey,
        fromJson: (json) => json as List<dynamic>,
        ignoreExpiry: true,
      );

      if (cached == null) return null;

      return cached.data
          .map((json) => ServingTurnModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('❌ Error reading cached serving turns (ignore expiry): $e');
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

  /// Clear serving turn cache
  Future<void> clearCache() async {
    await CacheManager.invalidate(_cacheKey);
    log('🗑️ Serving turn cache cleared');
  }
}
