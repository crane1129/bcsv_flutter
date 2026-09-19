import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';
import 'package:bcsv_flutter_project/domain/repositories/serving_turn_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/serving_turn_repository_impl.dart';
import 'dart:developer';

/// State for serving turn list
enum ServingTurnStatus { initial, loading, loaded, error }

class ServingTurnState {
  final List<ServingTurnEntity> servingTurns;
  final ServingTurnEntity? currentTurn;
  final ServingTurnStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;

  const ServingTurnState({
    this.servingTurns = const [],
    this.currentTurn,
    this.status = ServingTurnStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
  });

  ServingTurnState copyWith({
    List<ServingTurnEntity>? servingTurns,
    ServingTurnEntity? currentTurn,
    ServingTurnStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
  }) {
    return ServingTurnState(
      servingTurns: servingTurns ?? this.servingTurns,
      currentTurn: currentTurn ?? this.currentTurn,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
    );
  }

  bool get isLoading => status == ServingTurnStatus.loading;
  bool get hasError => status == ServingTurnStatus.error;
  bool get hasData => servingTurns.isNotEmpty;
  bool get isEmpty => servingTurns.isEmpty && status == ServingTurnStatus.loaded;
}

/// Notifier for serving turn state
class ServingTurnNotifier extends StateNotifier<ServingTurnState> {
  final ServingTurnRepository _repository;

  ServingTurnNotifier(this._repository) : super(const ServingTurnState());

  /// Load serving turns (with caching).
  /// Shows a loading spinner only when no data is already displayed.
  Future<void> loadServingTurns({bool forceRefresh = false}) async {
    log('🎯 [ServingTurn] loadServingTurns called (forceRefresh: $forceRefresh, currentState: ${state.status})');

    if (state.isLoading) return;

    if (!state.hasData) {
      state = state.copyWith(status: ServingTurnStatus.loading);
    }

    try {
      final servingTurns = await _repository.getServingTurns(forceRefresh: forceRefresh);
      final lastUpdated = _repository.getLastUpdated();
      final hasCached = await _repository.hasCachedServingTurns();
      final currentTurn = _repository.getCurrentServingTurn(servingTurns);

      log('📊 [ServingTurn] Received ${servingTurns.length} items (${!forceRefresh && hasCached ? "CACHE" : "NETWORK"})');

      state = state.copyWith(
        servingTurns: servingTurns,
        currentTurn: currentTurn,
        status: ServingTurnStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: !forceRefresh && hasCached,
        errorMessage: null,
      );
    } catch (e) {
      log('❌ [ServingTurn] Error loading: $e');
      if (!state.hasData) {
        state = state.copyWith(
          status: ServingTurnStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  /// Refresh serving turns from network
  Future<void> refresh() async {
    await loadServingTurns(forceRefresh: true);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload() async {
    await _repository.clearCache();
    await loadServingTurns(forceRefresh: true);
  }
}

/// Provider for serving turn repository
final servingTurnRepositoryProvider = Provider<ServingTurnRepository>((ref) {
  return ServingTurnRepositoryImpl();
});

/// Provider for serving turn state
final servingTurnNotifierProvider =
    StateNotifierProvider<ServingTurnNotifier, ServingTurnState>((ref) {
  final repository = ref.watch(servingTurnRepositoryProvider);
  return ServingTurnNotifier(repository);
});

/// Convenience provider for just the serving turns list
final servingTurnsProvider = Provider<List<ServingTurnEntity>>((ref) {
  return ref.watch(servingTurnNotifierProvider).servingTurns;
});

/// Provider for current serving turn
final currentServingTurnProvider = Provider<ServingTurnEntity?>((ref) {
  return ref.watch(servingTurnNotifierProvider).currentTurn;
});

/// Provider for loading state
final servingTurnsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(servingTurnNotifierProvider).isLoading;
});
