import 'package:bcsv_flutter_project/domain/entities/daily_bible.dart';
import 'package:bcsv_flutter_project/domain/repositories/daily_bible_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/daily_bible_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/daily_bible_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of DailyBibleRepository with offline support
class DailyBibleRepositoryImpl implements DailyBibleRepository {
  final DailyBibleRemoteDatasource _remoteDatasource;
  final DailyBibleLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  /// Track whether the last fetch was from cache
  bool _lastFetchWasFromCache = false;

  DailyBibleRepositoryImpl({
    DailyBibleRemoteDatasource? remoteDatasource,
    DailyBibleLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? DailyBibleRemoteDatasource(),
        _localDatasource = localDatasource ?? DailyBibleLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<DailyBibleEntity?> getDailyBible({
    required String date,
    bool forceRefresh = false,
  }) async {
    // Check if we have valid cached data for this specific date
    if (!forceRefresh && await _localDatasource.hasValidCache(date)) {
      log('📦 Using cached daily Bible for date $date');
      final cached = await _localDatasource.getCachedDailyBible(date);
      if (cached != null) {
        _lastFetchWasFromCache = true;
        return cached.toEntity();
      }
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        log('🌐 Fetching daily Bible for date $date from network');
        final remoteDailyBible = await _remoteDatasource.fetchDailyBible(date);

        if (remoteDailyBible == null) {
          // No daily Bible found for this date
          return _getFallbackFromCache(date);
        }

        // Cache the results
        await _localDatasource.cacheDailyBible(remoteDailyBible);

        _lastFetchWasFromCache = false;
        return remoteDailyBible.toEntity();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        return _getFallbackFromCache(date);
      } catch (e) {
        log('❌ Unexpected error fetching daily Bible: $e');
        return _getFallbackFromCache(date);
      }
    } else {
      log('📴 Offline mode - using cached daily Bible');
      return _getFallbackFromCache(date);
    }
  }

  /// Get cached data as fallback (even if for different date)
  Future<DailyBibleEntity?> _getFallbackFromCache(String date) async {
    // First try exact date match
    final exactMatch = await _localDatasource.getCachedDailyBible(date);
    if (exactMatch != null) {
      log('📦 Using exact date cache for $date');
      _lastFetchWasFromCache = true;
      return exactMatch.toEntity();
    }

    // If no exact match, try any cached data (for offline mode)
    final cached = await _localDatasource.getCachedDailyBibleIgnoreDate();
    if (cached != null) {
      log('📦 Using fallback cache (cached date: ${cached.date}, requested: $date)');
      _lastFetchWasFromCache = true;
      return cached.toEntity();
    }

    log('⚠️ No cached data available');
    _lastFetchWasFromCache = true;
    return null;
  }

  @override
  Future<DailyBibleEntity?> getTodaysDailyBible({
    bool forceRefresh = false,
  }) async {
    final today = DateTime.now();
    final dateString = _formatDate(today);
    return getDailyBible(date: dateString, forceRefresh: forceRefresh);
  }

  @override
  Future<DailyBibleEntity?> getCachedDailyBible(String date) async {
    final cached = await _localDatasource.getCachedDailyBible(date);
    return cached?.toEntity();
  }

  @override
  Future<bool> hasCachedDailyBible(String date) async {
    return _localDatasource.hasValidCache(date);
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

  /// Format DateTime to date string (YYYY-MM-DD)
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
