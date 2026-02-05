import 'package:bcsv_flutter_project/domain/entities/announcement.dart';

/// Repository interface for announcement data access
abstract class AnnouncementRepository {
  /// Get all announcements
  /// Returns cached data if available and valid, otherwise fetches from remote
  Future<List<AnnouncementEntity>> getAnnouncements({bool forceRefresh = false});

  /// Get cached announcements only (for offline use)
  Future<List<AnnouncementEntity>?> getCachedAnnouncements();

  /// Check if cached announcements are available and valid
  Future<bool> hasCachedAnnouncements();

  /// Check if the last fetch was from cache (offline mode)
  bool wasLastFetchFromCache();

  /// Clear announcement cache
  Future<void> clearCache();

  /// Get the timestamp of when announcements were last updated
  DateTime? getLastUpdated();
}
