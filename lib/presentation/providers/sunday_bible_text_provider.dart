import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';
import 'package:bcsv_flutter_project/domain/repositories/sunday_bible_text_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/sunday_bible_text_repository_impl.dart';
import 'dart:developer';

/// State for Sunday Bible text
enum SundayBibleTextStatus { initial, loading, loaded, error }

class SundayBibleTextState {
  final List<SundayBibleTextEntity> texts;
  final SundayBibleTextStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;
  final SundayBibleTextFilter filter;

  const SundayBibleTextState({
    this.texts = const [],
    this.status = SundayBibleTextStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
    SundayBibleTextFilter? filter,
  }) : filter = filter ?? const SundayBibleTextFilter(year: 0);

  SundayBibleTextState copyWith({
    List<SundayBibleTextEntity>? texts,
    SundayBibleTextStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
    SundayBibleTextFilter? filter,
  }) {
    return SundayBibleTextState(
      texts: texts ?? this.texts,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
      filter: filter ?? this.filter,
    );
  }

  bool get isLoading => status == SundayBibleTextStatus.loading;
  bool get hasError => status == SundayBibleTextStatus.error;
  bool get hasData => texts.isNotEmpty;
  bool get isEmpty => texts.isEmpty && status == SundayBibleTextStatus.loaded;
  bool get hasActiveFilters => filter.hasActiveFilters;
}

/// Notifier for Sunday Bible text state
class SundayBibleTextNotifier extends StateNotifier<SundayBibleTextState> {
  final SundayBibleTextRepository _repository;

  SundayBibleTextNotifier(this._repository)
      : super(SundayBibleTextState(
          filter: SundayBibleTextFilter(year: DateTime.now().year),
        ));

  /// Load Sunday Bible texts with current filter
  Future<void> loadSundayBibleTexts({bool forceRefresh = false}) async {
    if (state.isLoading) return;

    state = state.copyWith(status: SundayBibleTextStatus.loading);
    log('🔄 Loading Sunday Bible texts with filter: ${state.filter.description}');

    try {
      final texts = await _repository.getSundayBibleTexts(
        filter: state.filter,
        forceRefresh: forceRefresh,
      );

      final lastUpdated = _repository.getLastUpdated();
      final wasFromCache = _repository.wasLastFetchFromCache();

      state = state.copyWith(
        texts: texts,
        status: SundayBibleTextStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: wasFromCache,
        errorMessage: null,
      );

      log('✅ Loaded ${texts.length} Sunday Bible texts');
    } catch (e) {
      log('❌ Error loading Sunday Bible texts: $e');
      state = state.copyWith(
        status: SundayBibleTextStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Set year filter
  Future<void> setYear(int year) async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(year: year),
    );
    // Year change may need fresh data, but still try cache first
    await loadSundayBibleTexts(forceRefresh: false);
  }

  /// Set month filter
  Future<void> setMonth(int? month) async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(
        year: state.filter.year,
        month: month,
      ),
    );
    // Filter changes should use cached data
    await loadSundayBibleTexts(forceRefresh: false);
  }

  /// Set month range filter
  Future<void> setMonthRange(int? startMonth, int? endMonth) async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(
        year: state.filter.year,
        startMonth: startMonth,
        endMonth: endMonth,
      ),
    );
    // Filter changes should use cached data
    await loadSundayBibleTexts(forceRefresh: false);
  }

  /// Set keyword filter
  Future<void> setKeyword(String? keyword) async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(
        year: state.filter.year,
        keyword: keyword,
      ),
    );
    // Filter changes should use cached data
    await loadSundayBibleTexts(forceRefresh: false);
  }

  /// Clear all filters (keep year)
  Future<void> clearFilters() async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(year: state.filter.year),
    );
    // Filter changes should use cached data
    await loadSundayBibleTexts(forceRefresh: false);
  }

  /// Refresh with current filter
  Future<void> refresh() async {
    await loadSundayBibleTexts(forceRefresh: true);
  }

  /// Load current year texts
  Future<void> loadCurrentYear({bool forceRefresh = false}) async {
    state = state.copyWith(
      filter: SundayBibleTextFilter(year: DateTime.now().year),
    );
    await loadSundayBibleTexts(forceRefresh: forceRefresh);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload() async {
    await _repository.clearCache();
    await loadSundayBibleTexts(forceRefresh: true);
  }
}

/// Provider for Sunday Bible text repository
final sundayBibleTextRepositoryProvider = Provider<SundayBibleTextRepository>((ref) {
  return SundayBibleTextRepositoryImpl();
});

/// Provider for Sunday Bible text state
final sundayBibleTextNotifierProvider =
    StateNotifierProvider<SundayBibleTextNotifier, SundayBibleTextState>((ref) {
  final repository = ref.watch(sundayBibleTextRepositoryProvider);
  return SundayBibleTextNotifier(repository);
});

/// Convenience provider for just the texts list
final sundayBibleTextsProvider = Provider<List<SundayBibleTextEntity>>((ref) {
  return ref.watch(sundayBibleTextNotifierProvider).texts;
});

/// Provider for loading state
final sundayBibleTextsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(sundayBibleTextNotifierProvider).isLoading;
});

/// Provider for checking if using offline data
final sundayBibleTextsOfflineProvider = Provider<bool>((ref) {
  return ref.watch(sundayBibleTextNotifierProvider).isOfflineData;
});

/// Provider for current filter
final sundayBibleTextFilterProvider = Provider<SundayBibleTextFilter>((ref) {
  return ref.watch(sundayBibleTextNotifierProvider).filter;
});

/// Provider for checking if filters are active
final sundayBibleTextHasFiltersProvider = Provider<bool>((ref) {
  return ref.watch(sundayBibleTextNotifierProvider).hasActiveFilters;
});
