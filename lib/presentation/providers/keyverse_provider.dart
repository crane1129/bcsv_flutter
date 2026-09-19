import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';
import 'package:bcsv_flutter_project/domain/repositories/keyverse_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/keyverse_repository_impl.dart';
import 'dart:developer';

/// State for key verse
enum KeyVerseStatus { initial, loading, loaded, error }

class KeyVerseState {
  final KeyVerseEntity? keyVerse;
  final KeyVerseStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;

  const KeyVerseState({
    this.keyVerse,
    this.status = KeyVerseStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
  });

  KeyVerseState copyWith({
    KeyVerseEntity? keyVerse,
    KeyVerseStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
  }) {
    return KeyVerseState(
      keyVerse: keyVerse ?? this.keyVerse,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
    );
  }

  bool get isLoading => status == KeyVerseStatus.loading;
  bool get hasError => status == KeyVerseStatus.error;
  bool get hasData => keyVerse != null;
  bool get isEmpty => keyVerse == null && status == KeyVerseStatus.loaded;
}

/// Notifier for key verse state
class KeyVerseNotifier extends StateNotifier<KeyVerseState> {
  final KeyVerseRepository _repository;

  KeyVerseNotifier(this._repository) : super(const KeyVerseState());

  /// Load key verse for a specific year
  Future<void> loadKeyVerse({int? year, bool forceRefresh = false}) async {
    final targetYear = year ?? DateTime.now().year;

    if (state.isLoading) return;

    if (!state.hasData) {
      state = state.copyWith(status: KeyVerseStatus.loading);
    }

    try {
      final keyVerse = await _repository.getKeyVerse(
        year: targetYear,
        forceRefresh: forceRefresh,
      );

      final lastUpdated = _repository.getLastUpdated();
      final wasFromCache = _repository.wasLastFetchFromCache();

      log('📊 [KeyVerse] ${keyVerse != null ? keyVerse.shortReference : "null"} (${wasFromCache ? "CACHE" : "NETWORK"})');

      state = state.copyWith(
        keyVerse: keyVerse,
        status: KeyVerseStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: wasFromCache,
        errorMessage: null,
      );
    } catch (e) {
      log('❌ [KeyVerse] Error loading: $e');
      if (!state.hasData) {
        state = state.copyWith(
          status: KeyVerseStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  /// Load current year key verse
  Future<void> loadCurrentYearKeyVerse({bool forceRefresh = false}) async {
    await loadKeyVerse(year: DateTime.now().year, forceRefresh: forceRefresh);
  }

  /// Refresh key verse from network
  Future<void> refresh({int? year}) async {
    await loadKeyVerse(year: year, forceRefresh: true);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload({int? year}) async {
    await _repository.clearCache();
    await loadKeyVerse(year: year, forceRefresh: true);
  }
}

/// Provider for key verse repository
final keyVerseRepositoryProvider = Provider<KeyVerseRepository>((ref) {
  return KeyVerseRepositoryImpl();
});

/// Provider for key verse state
final keyVerseNotifierProvider =
    StateNotifierProvider<KeyVerseNotifier, KeyVerseState>((ref) {
  final repository = ref.watch(keyVerseRepositoryProvider);
  return KeyVerseNotifier(repository);
});

/// Convenience provider for just the key verse entity
final keyVerseProvider = Provider<KeyVerseEntity?>((ref) {
  return ref.watch(keyVerseNotifierProvider).keyVerse;
});

/// Provider for current year key verse (auto-loads on first access)
final currentYearKeyVerseProvider = FutureProvider<KeyVerseEntity?>((ref) async {
  final notifier = ref.read(keyVerseNotifierProvider.notifier);
  await notifier.loadCurrentYearKeyVerse();
  return ref.watch(keyVerseNotifierProvider).keyVerse;
});

/// Provider for loading state
final keyVerseLoadingProvider = Provider<bool>((ref) {
  return ref.watch(keyVerseNotifierProvider).isLoading;
});

/// Provider for checking if using offline data
final keyVerseOfflineProvider = Provider<bool>((ref) {
  return ref.watch(keyVerseNotifierProvider).isOfflineData;
});
