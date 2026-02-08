import 'package:bcsv_flutter_project/domain/entities/daily_bible.dart';

/// Repository interface for daily Bible data access
abstract class DailyBibleRepository {
  /// Get daily Bible reading for a specific date
  /// Returns cached data if available and valid, otherwise fetches from remote
  Future<DailyBibleEntity?> getDailyBible({
    required String date,
    bool forceRefresh = false,
  });

  /// Get today's daily Bible reading
  Future<DailyBibleEntity?> getTodaysDailyBible({bool forceRefresh = false});

  /// Get cached daily Bible only (for offline use)
  Future<DailyBibleEntity?> getCachedDailyBible(String date);

  /// Check if cached daily Bible is available for a date
  Future<bool> hasCachedDailyBible(String date);

  /// Check if the last fetch was from cache (offline mode)
  bool wasLastFetchFromCache();

  /// Clear daily Bible cache
  Future<void> clearCache();

  /// Get the timestamp of when daily Bible was last updated
  DateTime? getLastUpdated();
}
