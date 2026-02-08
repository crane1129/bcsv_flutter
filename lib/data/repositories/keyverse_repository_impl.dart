import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';
import 'package:bcsv_flutter_project/domain/repositories/keyverse_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/keyverse_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/keyverse_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of KeyVerseRepository with offline support
class KeyVerseRepositoryImpl implements KeyVerseRepository {
  final KeyVerseRemoteDatasource _remoteDatasource;
  final KeyVerseLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  /// Track whether the last fetch was from cache
  bool _lastFetchWasFromCache = false;

  KeyVerseRepositoryImpl({
    KeyVerseRemoteDatasource? remoteDatasource,
    KeyVerseLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? KeyVerseRemoteDatasource(),
        _localDatasource = localDatasource ?? KeyVerseLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<KeyVerseEntity?> getKeyVerse({
    int? year,
    bool forceRefresh = false,
  }) async {
    final targetYear = year ?? DateTime.now().year;

    // Check if we have valid cached data and don't need to refresh
    if (!forceRefresh && _localDatasource.hasValidCache(targetYear)) {
      log('📦 Using cached key verse for year $targetYear');
      final cached = _localDatasource.getCachedKeyVerse(targetYear);
      if (cached != null) {
        _lastFetchWasFromCache = true;
        return cached.toEntity();
      }
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        log('🌐 Fetching key verse for year $targetYear from network');
        final remoteKeyVerse = await _remoteDatasource.fetchKeyVerse(targetYear);

        if (remoteKeyVerse == null) {
          // No key verse found for this year
          return _getFallbackFromCache(targetYear);
        }

        // Cache the results
        await _localDatasource.cacheKeyVerse(remoteKeyVerse);

        _lastFetchWasFromCache = false;
        return remoteKeyVerse.toEntity();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        return _getFallbackFromCache(targetYear);
      } catch (e) {
        log('❌ Unexpected error fetching key verse: $e');
        return _getFallbackFromCache(targetYear);
      }
    } else {
      log('📴 Offline mode - using cached key verse');
      return _getFallbackFromCache(targetYear);
    }
  }

  /// Get cached data as fallback (even if expired)
  KeyVerseEntity? _getFallbackFromCache(int year) {
    final cached = _localDatasource.getCachedKeyVerseIgnoreExpiry(year);
    if (cached != null) {
      log('📦 Using fallback cache for year $year');
      _lastFetchWasFromCache = true;
      return cached.toEntity();
    }
    log('⚠️ No cached data available for year $year');
    _lastFetchWasFromCache = true;
    return null;
  }

  @override
  Future<KeyVerseEntity?> getCurrentYearKeyVerse({bool forceRefresh = false}) async {
    return getKeyVerse(year: DateTime.now().year, forceRefresh: forceRefresh);
  }

  @override
  Future<KeyVerseEntity?> getCachedKeyVerse(int year) async {
    final cached = _localDatasource.getCachedKeyVerse(year);
    return cached?.toEntity();
  }

  @override
  Future<bool> hasCachedKeyVerse(int year) async {
    return _localDatasource.hasValidCache(year);
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
