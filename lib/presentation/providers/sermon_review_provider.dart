import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/domain/entities/sermon_review.dart';
import 'package:bcsv_flutter_project/domain/repositories/sermon_review_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/sermon_review_repository_impl.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/sermon_review_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/sermon_review_local_datasource.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Status enum for sermon review state
enum SermonReviewStatus {
  initial,
  loading,
  success,
  error,
}

/// State class for sermon reviews
class SermonReviewState {
  final SermonReviewStatus status;
  final List<SermonReviewEntity> sermonReviews;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isOfflineData;

  const SermonReviewState({
    this.status = SermonReviewStatus.initial,
    this.sermonReviews = const [],
    this.errorMessage,
    this.lastUpdated,
    this.isOfflineData = false,
  });

  /// Convenience getters
  bool get isLoading => status == SermonReviewStatus.loading;
  bool get hasError => status == SermonReviewStatus.error;
  bool get isEmpty => sermonReviews.isEmpty && status == SermonReviewStatus.success;

  SermonReviewState copyWith({
    SermonReviewStatus? status,
    List<SermonReviewEntity>? sermonReviews,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isOfflineData,
  }) {
    return SermonReviewState(
      status: status ?? this.status,
      sermonReviews: sermonReviews ?? this.sermonReviews,
      errorMessage: errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOfflineData: isOfflineData ?? this.isOfflineData,
    );
  }
}

/// StateNotifier for sermon reviews
class SermonReviewNotifier extends StateNotifier<SermonReviewState> {
  final SermonReviewRepository repository;

  SermonReviewNotifier({required this.repository})
      : super(const SermonReviewState());

  /// Load sermon reviews.
  /// Shows a loading spinner only when no data is already displayed.
  Future<void> loadSermonReviews({bool forceRefresh = false}) async {
    log('🎯 [SermonReview] loadSermonReviews called (forceRefresh: $forceRefresh, currentState: ${state.status})');

    if (state.isLoading) return;

    if (state.sermonReviews.isEmpty) {
      state = state.copyWith(status: SermonReviewStatus.loading, errorMessage: null);
    }

    try {
      final reviews = await repository.getSermonReviews(forceRefresh: forceRefresh);

      log('📊 [SermonReview] Received ${reviews.length} items');

      state = state.copyWith(
        status: SermonReviewStatus.success,
        sermonReviews: reviews,
        lastUpdated: DateTime.now(),
        isOfflineData: false,
        errorMessage: null,
      );
    } on AppException catch (e) {
      log('❌ [SermonReview] AppException: ${e.message}');
      if (state.sermonReviews.isNotEmpty) {
        state = state.copyWith(
          status: SermonReviewStatus.success,
          isOfflineData: true,
        );
      } else {
        state = state.copyWith(
          status: SermonReviewStatus.error,
          errorMessage: e.message,
        );
      }
    } catch (e) {
      log('❌ [SermonReview] Unexpected error: $e');
      if (state.sermonReviews.isNotEmpty) {
        state = state.copyWith(
          status: SermonReviewStatus.success,
          isOfflineData: true,
        );
      } else {
        state = state.copyWith(
          status: SermonReviewStatus.error,
          errorMessage: 'Failed to load sermon reviews',
        );
      }
    }
  }

  /// Refresh sermon reviews (force network fetch)
  Future<void> refresh() async {
    log('🔄 [SermonReview] Refresh requested');
    await loadSermonReviews(forceRefresh: true);
  }

  /// Clear cache
  Future<void> clearCache() async {
    log('🗑️ [SermonReview] Clearing cache');
    await repository.clearCache();
    state = const SermonReviewState();
  }
}

/// Provider for SermonReviewRepository
final sermonReviewRepositoryProvider = Provider<SermonReviewRepository>((ref) {
  return SermonReviewRepositoryImpl(
    remoteDatasource: SermonReviewRemoteDatasource(),
    localDatasource: SermonReviewLocalDatasource(),
  );
});

/// Provider for SermonReviewNotifier
final sermonReviewNotifierProvider =
    StateNotifierProvider<SermonReviewNotifier, SermonReviewState>((ref) {
  final repository = ref.watch(sermonReviewRepositoryProvider);
  return SermonReviewNotifier(repository: repository);
});
