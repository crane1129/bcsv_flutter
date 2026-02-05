import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
import 'package:bcsv_flutter_project/domain/repositories/announcement_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/announcement_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/announcement_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of AnnouncementRepository with offline support
class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDatasource _remoteDatasource;
  final AnnouncementLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  /// Track whether the last fetch was from cache
  bool _lastFetchWasFromCache = false;

  AnnouncementRepositoryImpl({
    AnnouncementRemoteDatasource? remoteDatasource,
    AnnouncementLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? AnnouncementRemoteDatasource(),
        _localDatasource = localDatasource ?? AnnouncementLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<List<AnnouncementEntity>> getAnnouncements({
    bool forceRefresh = false,
  }) async {
    // Check if we have valid cached data and don't need to refresh
    if (!forceRefresh && _localDatasource.hasValidCache()) {
      log('📦 Using cached announcements');
      final cached = _localDatasource.getCachedAnnouncements();
      if (cached != null) {
        _lastFetchWasFromCache = true;
        return cached.map((m) => m.toEntity()).toList();
      }
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        // Fetch from remote
        log('🌐 Fetching announcements from network');
        final remoteAnnouncements = await _remoteDatasource.fetchAnnouncements();

        // Cache the results
        await _localDatasource.cacheAnnouncements(remoteAnnouncements);

        _lastFetchWasFromCache = false;
        return remoteAnnouncements.map((m) => m.toEntity()).toList();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        // Fall back to cache on error
        return _getFallbackFromCache();
      } catch (e) {
        log('❌ Unexpected error fetching announcements: $e');
        return _getFallbackFromCache();
      }
    } else {
      // Offline - use cached data
      log('📴 Offline mode - using cached announcements');
      return _getFallbackFromCache();
    }
  }

  /// Get cached data as fallback (even if expired)
  List<AnnouncementEntity> _getFallbackFromCache() {
    final cached = _localDatasource.getCachedAnnouncementsIgnoreExpiry();
    if (cached != null) {
      log('📦 Using fallback cache (${cached.length} items)');
      _lastFetchWasFromCache = true;
      return cached.map((m) => m.toEntity()).toList();
    }
    log('⚠️ No cached data available');
    _lastFetchWasFromCache = true;
    return [];
  }

  @override
  Future<List<AnnouncementEntity>?> getCachedAnnouncements() async {
    final cached = _localDatasource.getCachedAnnouncements();
    return cached?.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> hasCachedAnnouncements() async {
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
