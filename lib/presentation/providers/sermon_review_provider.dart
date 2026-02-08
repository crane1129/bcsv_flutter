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

  /// Load sermon reviews
  Future<void> loadSermonReviews({bool forceRefresh = false}) async {
    log('🎯 [SermonReview] loadSermonReviews called (forceRefresh: $forceRefresh, currentState: ${state.status})');

    if (state.isLoading) {
      log('⚠️ [SermonReview] Already loading, skipping request');
      return;
    }

    log('🔵 [SermonReview] Setting state to loading');
    state = state.copyWith(
      status: SermonReviewStatus.loading,
      errorMessage: null,
    );

    try {
      log('🌐 [SermonReview] Fetching sermon reviews...');
      final reviews = await repository.getSermonReviews(
        forceRefresh: forceRefresh,
      );

      log('📊 [SermonReview] Received ${reviews.length} items');
      log('🔍 [SermonReview] IsOffline check: forceRefresh=$forceRefresh, reviews=${reviews.length}');

      state = state.copyWith(
        status: SermonReviewStatus.success,
        sermonReviews: reviews,
        lastUpdated: DateTime.now(),
        isOfflineData: false,
      );

      log('✅ [SermonReview] State updated successfully');
    } on AppException catch (e, stackTrace) {
      log('❌ [SermonReview] AppException occurred: ${e.message}', error: e, stackTrace: stackTrace);

      // Check if we have cached data to fall back to
      if (state.sermonReviews.isNotEmpty) {
        log('⚠️ [SermonReview] Keeping existing data despite error');
        state = state.copyWith(
          status: SermonReviewStatus.success,
          isOfflineData: true,
          errorMessage: e.message,
        );
      } else {
        state = state.copyWith(
          status: SermonReviewStatus.error,
          errorMessage: e.message,
        );
      }
    } catch (e, stackTrace) {
      log('❌ [SermonReview] Unexpected error: $e', error: e, stackTrace: stackTrace);

      if (state.sermonReviews.isNotEmpty) {
        log('⚠️ [SermonReview] Keeping existing data despite unexpected error');
        state = state.copyWith(
          status: SermonReviewStatus.success,
          isOfflineData: true,
          errorMessage: 'Failed to refresh sermon reviews',
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
