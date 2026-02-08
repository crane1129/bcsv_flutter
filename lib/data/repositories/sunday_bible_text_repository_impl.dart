import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';
import 'package:bcsv_flutter_project/domain/repositories/sunday_bible_text_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/sunday_bible_text_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/sunday_bible_text_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of SundayBibleTextRepository with offline support
class SundayBibleTextRepositoryImpl implements SundayBibleTextRepository {
  final SundayBibleTextRemoteDatasource _remoteDatasource;
  final SundayBibleTextLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  /// Track whether the last fetch was from cache
  bool _lastFetchWasFromCache = false;

  SundayBibleTextRepositoryImpl({
    SundayBibleTextRemoteDatasource? remoteDatasource,
    SundayBibleTextLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? SundayBibleTextRemoteDatasource(),
        _localDatasource = localDatasource ?? SundayBibleTextLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<List<SundayBibleTextEntity>> getSundayBibleTexts({
    required SundayBibleTextFilter filter,
    bool forceRefresh = false,
  }) async {
    // Check if we have valid cached data for this specific filter
    if (!forceRefresh && await _localDatasource.hasValidCacheForFilter(filter)) {
      log('📦 Using cached Sunday Bible texts for filter: ${filter.description}');
      final cached = await _localDatasource.getCachedSundayBibleTexts();
      if (cached != null) {
        _lastFetchWasFromCache = true;
        // No need to apply filters - cache already contains filtered data
        return cached.map((m) => m.toEntity()).toList();
      }
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        log('🌐 Fetching Sunday Bible texts from network');
        final remoteTexts = await _remoteDatasource.fetchSundayBibleTexts(filter);

        // Cache the results with the filter used
        await _localDatasource.cacheSundayBibleTexts(remoteTexts, filter: filter);

        _lastFetchWasFromCache = false;
        return remoteTexts.map((m) => m.toEntity()).toList();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        return _getFallbackFromCache(filter);
      } catch (e) {
        log('❌ Unexpected error fetching Sunday Bible texts: $e');
        return _getFallbackFromCache(filter);
      }
    } else {
      log('📴 Offline mode - using cached Sunday Bible texts');
      return _getFallbackFromCache(filter);
    }
  }

  /// Get cached data as fallback (even if expired)
  Future<List<SundayBibleTextEntity>> _getFallbackFromCache(SundayBibleTextFilter filter) async {
    try {
      final cached = await _localDatasource.getCachedSundayBibleTextsIgnoreExpiry();
      if (cached != null) {
        log('📦 Using fallback cache (${cached.length} items)');
        _lastFetchWasFromCache = true;
        return _applyFilters(cached.map((m) => m.toEntity()).toList(), filter);
      }
      log('⚠️ No cached data available');
      _lastFetchWasFromCache = true;
      return <SundayBibleTextEntity>[];
    } catch (e) {
      log('❌ Error loading cache: $e');
      _lastFetchWasFromCache = true;
      return <SundayBibleTextEntity>[];
    }
  }

  /// Apply filters to the list of texts
  List<SundayBibleTextEntity> _applyFilters(
    List<SundayBibleTextEntity> texts,
    SundayBibleTextFilter filter,
  ) {
    var filtered = texts;

    // Filter by year
    filtered = filtered.where((t) => t.year == filter.year).toList();

    // Apply keyword filter (highest priority)
    if (filter.keyword?.isNotEmpty ?? false) {
      filtered = filtered.where((t) => t.matchesKeyword(filter.keyword!)).toList();
    }
    // Apply exact month filter
    else if (filter.month != null) {
      filtered = filtered.where((t) => t.month == filter.month).toList();
    }
    // Apply month range filter
    else if (filter.startMonth != null && filter.endMonth != null) {
      filtered = filtered.where((t) {
        if (t.month == null) return false;
        return t.month! >= filter.startMonth! && t.month! <= filter.endMonth!;
      }).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) {
      final dateA = a.parsedDate;
      final dateB = b.parsedDate;
      if (dateA == null || dateB == null) return 0;
      return dateB.compareTo(dateA);
    });

    log('✅ Applied filters: ${filter.description} → ${filtered.length} results');
    return filtered;
  }

  @override
  Future<List<SundayBibleTextEntity>> getCurrentYearTexts({
    bool forceRefresh = false,
  }) async {
    final currentYear = DateTime.now().year;
    final filter = SundayBibleTextFilter(year: currentYear);
    return getSundayBibleTexts(filter: filter, forceRefresh: forceRefresh);
  }

  @override
  Future<List<SundayBibleTextEntity>?> getCachedSundayBibleTexts() async {
    final cached = await _localDatasource.getCachedSundayBibleTexts();
    return cached?.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> hasCachedSundayBibleTexts() async {
    return _localDatasource.hasValidCache();
  }

  @override
  bool wasLastFetchFromCache() {
    return _lastFetchWasFromCache;
  }

  @override
  Future<void> clearCache() async {
    await _localDatasource.clearCache();
  }

  @override
  DateTime? getLastUpdated() {
    return _localDatasource.getLastUpdated();
  }
}
