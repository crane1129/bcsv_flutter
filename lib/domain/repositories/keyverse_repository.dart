import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';

/// Repository interface for key verse data access
abstract class KeyVerseRepository {
  /// Get key verse for a specific year
  /// Returns cached data if available and valid, otherwise fetches from remote
  Future<KeyVerseEntity?> getKeyVerse({
    int? year,
    bool forceRefresh = false,
  });

  /// Get key verse for current year
  Future<KeyVerseEntity?> getCurrentYearKeyVerse({bool forceRefresh = false});

  /// Get cached key verse only (for offline use)
  Future<KeyVerseEntity?> getCachedKeyVerse(int year);

  /// Check if cached key verse is available and valid for a year
  Future<bool> hasCachedKeyVerse(int year);

  /// Check if the last fetch was from cache (offline mode)
  bool wasLastFetchFromCache();

  /// Clear key verse cache
  Future<void> clearCache();

  /// Get the timestamp of when key verse was last updated
  DateTime? getLastUpdated();
}
