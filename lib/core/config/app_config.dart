/// Application configuration constants
class AppConfig {
  AppConfig._();

  /// API timeout durations
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration googleSheetsTimeout = Duration(seconds: 20);
  static const Duration cacheValidDuration = Duration(hours: 24);

  /// Cache keys
  static const String announcementCacheKey = 'announcement_cache';
  static const String messageCacheKey = 'message_cache';
  static const String bibleTextCacheKey = 'bible_text_cache';
  static const String dailyBibleCacheKey = 'daily_bible_cache';
  static const String servingTurnCacheKey = 'serving_turn_cache';

  /// Secure storage keys
  static const String googleCredentialsKey = 'google_service_credentials';
  static const String googleSpreadsheetIdKey = 'google_spreadsheet_id';

  /// Feature flags for gradual migration
  static bool useRiverpodSettings = false;
  static bool useRiverpodAnnouncements = false;
  static bool useRiverpodMessages = false;
  static bool useRiverpodBible = false;
}
