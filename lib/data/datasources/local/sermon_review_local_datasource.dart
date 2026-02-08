import 'dart:convert';
import 'package:bcsv_flutter_project/data/models/sermon_review_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'dart:developer';

/// Local datasource for sermon review caching
class SermonReviewLocalDatasource {
  static const _cacheKey = 'sermon_review_cache_data';

  /// Get cached sermon reviews from local storage
  Future<List<SermonReviewModel>?> getCachedSermonReviews() async {
    try {
      final cached = UserSharedPreferences.getString(_cacheKey);
      if (cached == null || cached.isEmpty) {
        log('📦 No cached sermon reviews found');
        return null;
      }

      final jsonData = jsonDecode(cached);
      final reviewsList = jsonData['sundayReview'] as List?;

      if (reviewsList == null || reviewsList.isEmpty) {
        log('📦 Empty cached sermon reviews');
        return null;
      }

      final reviews = reviewsList
          .map((json) => SermonReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      log('📦 Retrieved ${reviews.length} cached sermon reviews');
      return reviews;
    } catch (e) {
      log('❌ Error reading cached sermon reviews: $e');
      return null;
    }
  }

  /// Cache sermon reviews to local storage
  Future<void> cacheSermonReviews(List<SermonReviewModel> reviews) async {
    try {
      final jsonData = {
        'sundayReview': reviews.map((r) => r.toJson()).toList(),
      };
      final jsonString = jsonEncode(jsonData);
      await UserSharedPreferences.setString(_cacheKey, jsonString);
      log('✅ Cached ${reviews.length} sermon reviews');
    } catch (e) {
      log('❌ Error caching sermon reviews: $e');
    }
  }

  /// Clear cached sermon reviews
  Future<void> clearCache() async {
    try {
      await UserSharedPreferences.setString(_cacheKey, '');
      log('🗑️ Cleared sermon review cache');
    } catch (e) {
      log('❌ Error clearing sermon review cache: $e');
    }
  }

  /// Get last update timestamp
  DateTime? getLastUpdated() {
    final cached = UserSharedPreferences.getString(_cacheKey);
    if (cached == null || cached.isEmpty) {
      return null;
    }
    // For now, return current time as we don't store timestamp separately
    // In production, you might want to store this separately
    return DateTime.now();
  }
}
