import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';
import 'package:bcsv_flutter_project/domain/repositories/serving_turn_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/serving_turn_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/serving_turn_local_datasource.dart';
import 'package:bcsv_flutter_project/core/network/network_info.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of ServingTurnRepository with offline support
class ServingTurnRepositoryImpl implements ServingTurnRepository {
  final ServingTurnRemoteDatasource _remoteDatasource;
  final ServingTurnLocalDatasource _localDatasource;
  final NetworkInfo _networkInfo;

  ServingTurnRepositoryImpl({
    ServingTurnRemoteDatasource? remoteDatasource,
    ServingTurnLocalDatasource? localDatasource,
    NetworkInfo? networkInfo,
  })  : _remoteDatasource = remoteDatasource ?? ServingTurnRemoteDatasource(),
        _localDatasource = localDatasource ?? ServingTurnLocalDatasource(),
        _networkInfo = networkInfo ?? NetworkInfo();

  @override
  Future<List<ServingTurnEntity>> getServingTurns({
    bool forceRefresh = false,
  }) async {
    // Check if we have valid cached data and don't need to refresh
    if (!forceRefresh && _localDatasource.hasValidCache()) {
      log('📦 Checking cached serving turns');
      final cached = _localDatasource.getCachedServingTurns();
      if (cached != null && cached.isNotEmpty) {
        log('📦 Using ${cached.length} cached serving turns');
        return cached.map((m) => m.toEntity()).toList();
      }
      log('📦 Cache is empty, will fetch from network');
    }

    // Check network connectivity
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        log('🌐 Fetching serving turns from network');
        final remoteServingTurns = await _remoteDatasource.fetchServingTurns();

        // Cache the results
        await _localDatasource.cacheServingTurns(remoteServingTurns);

        return remoteServingTurns.map((m) => m.toEntity()).toList();
      } on AppException catch (e) {
        log('❌ Remote fetch failed: ${e.message}');
        return _getFallbackFromCache();
      } catch (e) {
        log('❌ Unexpected error fetching serving turns: $e');
        return _getFallbackFromCache();
      }
    } else {
      log('📴 Offline mode - using cached serving turns');
      return _getFallbackFromCache();
    }
  }

  List<ServingTurnEntity> _getFallbackFromCache() {
    final cached = _localDatasource.getCachedServingTurnsIgnoreExpiry();
    if (cached != null) {
      log('📦 Using fallback cache (${cached.length} items)');
      return cached.map((m) => m.toEntity()).toList();
    }
    log('⚠️ No cached data available');
    return [];
  }

  @override
  Future<List<ServingTurnEntity>?> getCachedServingTurns() async {
    final cached = _localDatasource.getCachedServingTurns();
    return cached?.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> hasCachedServingTurns() async {
    return _localDatasource.hasValidCache();
  }

  @override
  Future<void> clearCache() async {
    await _localDatasource.clearCache();
  }

  @override
  DateTime? getLastUpdated() {
    return _localDatasource.getLastUpdated();
  }

  @override
  ServingTurnEntity? getCurrentServingTurn(List<ServingTurnEntity> servingTurns) {
    if (servingTurns.isEmpty) return null;

    final now = DateTime.now();

    // Find the serving turn for current week or closest future date
    for (final turn in servingTurns) {
      try {
        final turnDate = DateTime.parse(turn.date);
        // If turn date is within current week or in the future
        if (turnDate.isAfter(now.subtract(const Duration(days: 7)))) {
          return turn;
        }
      } catch (_) {
        continue;
      }
    }

    // Return the last one if no match found
    return servingTurns.last;
  }
}
