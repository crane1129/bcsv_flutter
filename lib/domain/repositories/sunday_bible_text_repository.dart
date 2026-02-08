import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';

/// Filter parameters for Sunday Bible text search
class SundayBibleTextFilter {
  final int year;
  final int? month;
  final int? startMonth;
  final int? endMonth;
  final String? keyword;

  const SundayBibleTextFilter({
    required this.year,
    this.month,
    this.startMonth,
    this.endMonth,
    this.keyword,
  });

  /// Check if has any active filters
  bool get hasActiveFilters =>
      month != null || startMonth != null || endMonth != null || (keyword?.isNotEmpty ?? false);

  /// Get filter description
  String get description {
    if (keyword?.isNotEmpty ?? false) {
      return 'Keyword: $keyword';
    }
    if (month != null) {
      return 'Year $year, Month $month';
    }
    if (startMonth != null && endMonth != null) {
      return 'Year $year, Months $startMonth-$endMonth';
    }
    return 'Year $year';
  }

  @override
  String toString() => description;
}

/// Repository interface for Sunday Bible text data access
abstract class SundayBibleTextRepository {
  /// Get Sunday Bible texts with optional filters
  /// Returns cached data if available and valid, otherwise fetches from remote
  Future<List<SundayBibleTextEntity>> getSundayBibleTexts({
    required SundayBibleTextFilter filter,
    bool forceRefresh = false,
  });

  /// Get Sunday Bible texts for current year
  Future<List<SundayBibleTextEntity>> getCurrentYearTexts({
    bool forceRefresh = false,
  });

  /// Get cached Sunday Bible texts only (for offline use)
  Future<List<SundayBibleTextEntity>?> getCachedSundayBibleTexts();

  /// Check if cached Sunday Bible texts are available
  Future<bool> hasCachedSundayBibleTexts();

  /// Check if the last fetch was from cache (offline mode)
  bool wasLastFetchFromCache();

  /// Clear Sunday Bible text cache
  Future<void> clearCache();

  /// Get the timestamp of when Sunday Bible texts were last updated
  DateTime? getLastUpdated();
}
