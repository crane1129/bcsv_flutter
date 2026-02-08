import 'package:bcsv_flutter_project/domain/entities/sermon_review.dart';

/// Repository interface for sermon reviews
abstract class SermonReviewRepository {
  /// Fetch sermon reviews
  ///
  /// [forceRefresh] - if true, bypass cache and fetch from network
  /// Returns list of sermon review entities
  Future<List<SermonReviewEntity>> getSermonReviews({
    bool forceRefresh = false,
  });

  /// Clear cached sermon reviews
  Future<void> clearCache();
}
