import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/daily_bible.dart';
import 'package:bcsv_flutter_project/domain/repositories/daily_bible_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/daily_bible_repository_impl.dart';
import 'dart:developer';

/// State for daily Bible
enum DailyBibleStatus { initial, loading, loaded, error }

class DailyBibleState {
  final DailyBibleEntity? dailyBible;
  final DailyBibleStatus status;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;
  final String currentDate;
  final double fontSize;

  const DailyBibleState({
    this.dailyBible,
    this.status = DailyBibleStatus.initial,
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
    String? currentDate,
    this.fontSize = 16.0,
  }) : currentDate = currentDate ?? '';

  DailyBibleState copyWith({
    DailyBibleEntity? dailyBible,
    DailyBibleStatus? status,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
    String? currentDate,
    double? fontSize,
  }) {
    return DailyBibleState(
      dailyBible: dailyBible ?? this.dailyBible,
      status: status ?? this.status,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
      currentDate: currentDate ?? this.currentDate,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  bool get isLoading => status == DailyBibleStatus.loading;
  bool get hasError => status == DailyBibleStatus.error;
  bool get hasData => dailyBible != null;
  bool get isEmpty => dailyBible == null && status == DailyBibleStatus.loaded;

  /// Check if current date is today
  bool get isToday {
    final today = DateTime.now();
    final current = _parseDate(currentDate);
    if (current == null) return false;

    return today.year == current.year &&
        today.month == current.month &&
        today.day == current.day;
  }

  /// Check if current date is in the future
  bool get isFuture {
    final current = _parseDate(currentDate);
    if (current == null) return false;
    return current.isAfter(DateTime.now());
  }

  /// Parse date string
  DateTime? _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }
}

/// Notifier for daily Bible state
class DailyBibleNotifier extends StateNotifier<DailyBibleState> {
  final DailyBibleRepository _repository;

  DailyBibleNotifier(this._repository) : super(DailyBibleState());

  /// Load daily Bible for a specific date.
  /// Shows a loading spinner only when no data is already displayed.
  Future<void> loadDailyBible({
    required String date,
    bool forceRefresh = false,
  }) async {
    log('🎯 [DailyBible] loadDailyBible called (date: $date, forceRefresh: $forceRefresh, currentState: ${state.status})');

    if (state.isLoading) return;

    if (!state.hasData) {
      state = state.copyWith(status: DailyBibleStatus.loading, currentDate: date);
    } else {
      state = state.copyWith(currentDate: date);
    }

    try {
      final dailyBible = await _repository.getDailyBible(
        date: date,
        forceRefresh: forceRefresh,
      );

      final lastUpdated = _repository.getLastUpdated();
      final wasFromCache = _repository.wasLastFetchFromCache();

      log('📊 [DailyBible] Received: ${dailyBible != null ? "data" : "null"} (${wasFromCache ? "CACHE" : "NETWORK"})');

      state = state.copyWith(
        dailyBible: dailyBible,
        status: DailyBibleStatus.loaded,
        lastUpdated: lastUpdated,
        isOfflineData: wasFromCache,
        errorMessage: null,
      );
    } catch (e) {
      log('❌ [DailyBible] Error loading: $e');
      if (!state.hasData) {
        state = state.copyWith(
          status: DailyBibleStatus.error,
          errorMessage: e.toString(),
        );
      }
    }
  }

  /// Load today's daily Bible
  Future<void> loadToday({bool forceRefresh = false}) async {
    final today = _formatDate(DateTime.now());
    await loadDailyBible(date: today, forceRefresh: forceRefresh);
  }

  /// Navigate to previous day
  Future<void> goToPreviousDay() async {
    final currentDate = _parseDate(state.currentDate);
    if (currentDate == null) return;

    final previousDay = currentDate.subtract(const Duration(days: 1));
    await loadDailyBible(date: _formatDate(previousDay), forceRefresh: true);
  }

  /// Navigate to next day
  Future<void> goToNextDay() async {
    final currentDate = _parseDate(state.currentDate);
    if (currentDate == null) return;

    final nextDay = currentDate.add(const Duration(days: 1));

    // Don't allow navigation to future dates
    if (nextDay.isAfter(DateTime.now())) {
      log('⚠️ Cannot navigate to future date');
      return;
    }

    await loadDailyBible(date: _formatDate(nextDay), forceRefresh: true);
  }

  /// Refresh current date's daily Bible
  Future<void> refresh() async {
    if (state.currentDate.isEmpty) {
      await loadToday(forceRefresh: true);
    } else {
      await loadDailyBible(date: state.currentDate, forceRefresh: true);
    }
  }

  /// Set font size
  void setFontSize(double size) {
    state = state.copyWith(fontSize: size.clamp(10.0, 30.0));
  }

  /// Increase font size
  void increaseFontSize() {
    setFontSize(state.fontSize + 2);
  }

  /// Decrease font size
  void decreaseFontSize() {
    setFontSize(state.fontSize - 2);
  }

  /// Clear cache and reload
  Future<void> clearCacheAndReload() async {
    await _repository.clearCache();
    await loadToday(forceRefresh: true);
  }

  /// Format DateTime to date string (YYYY-MM-DD)
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Parse date string to DateTime
  DateTime? _parseDate(String date) {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }
}

/// Provider for daily Bible repository
final dailyBibleRepositoryProvider = Provider<DailyBibleRepository>((ref) {
  return DailyBibleRepositoryImpl();
});

/// Provider for daily Bible state
final dailyBibleNotifierProvider =
    StateNotifierProvider<DailyBibleNotifier, DailyBibleState>((ref) {
  final repository = ref.watch(dailyBibleRepositoryProvider);
  return DailyBibleNotifier(repository);
});

/// Convenience provider for just the daily Bible entity
final dailyBibleProvider = Provider<DailyBibleEntity?>((ref) {
  return ref.watch(dailyBibleNotifierProvider).dailyBible;
});

/// Provider for loading state
final dailyBibleLoadingProvider = Provider<bool>((ref) {
  return ref.watch(dailyBibleNotifierProvider).isLoading;
});

/// Provider for checking if using offline data
final dailyBibleOfflineProvider = Provider<bool>((ref) {
  return ref.watch(dailyBibleNotifierProvider).isOfflineData;
});

/// Provider for font size
final dailyBibleFontSizeProvider = Provider<double>((ref) {
  return ref.watch(dailyBibleNotifierProvider).fontSize;
});
