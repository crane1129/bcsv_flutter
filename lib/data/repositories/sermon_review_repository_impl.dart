import 'package:bcsv_flutter_project/domain/entities/sermon_review.dart';
import 'package:bcsv_flutter_project/domain/repositories/sermon_review_repository.dart';
import 'package:bcsv_flutter_project/data/datasources/remote/sermon_review_remote_datasource.dart';
import 'package:bcsv_flutter_project/data/datasources/local/sermon_review_local_datasource.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Implementation of SermonReviewRepository
class SermonReviewRepositoryImpl implements SermonReviewRepository {
  final SermonReviewRemoteDatasource remoteDatasource;
  final SermonReviewLocalDatasource localDatasource;

  SermonReviewRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<SermonReviewEntity>> getSermonReviews({
    bool forceRefresh = false,
  }) async {
    try {
      // If force refresh, skip cache
      if (!forceRefresh) {
        final cached = await localDatasource.getCachedSermonReviews();
        if (cached != null && cached.isNotEmpty) {
          log('✅ Using cached sermon reviews (${cached.length} items)');
          return cached.map((model) => model.toEntity()).toList();
        }
      }

      // Fetch from remote
      log('🌐 Fetching sermon reviews from network');
      final reviews = await remoteDatasource.fetchSermonReviews();

      // Cache the results
      if (reviews.isNotEmpty) {
        await localDatasource.cacheSermonReviews(reviews);
      }

      return reviews.map((model) => model.toEntity()).toList();
    } on AppException {
      // If network fails, try to use cache as fallback
      log('⚠️ Network fetch failed, attempting cache fallback');
      final cached = await localDatasource.getCachedSermonReviews();
      if (cached != null && cached.isNotEmpty) {
        log('✅ Using cached sermon reviews as fallback (${cached.length} items)');
        return cached.map((model) => model.toEntity()).toList();
      }
      rethrow;
    } catch (e) {
      log('❌ Unexpected error in getSermonReviews: $e');
      // Try cache as last resort
      final cached = await localDatasource.getCachedSermonReviews();
      if (cached != null && cached.isNotEmpty) {
        log('✅ Using cached sermon reviews after error (${cached.length} items)');
        return cached.map((model) => model.toEntity()).toList();
      }
      throw NetworkException(
        message: 'Failed to load sermon reviews',
        originalError: e,
      );
    }
  }

  @override
  Future<void> clearCache() async {
    await localDatasource.clearCache();
  }
}
