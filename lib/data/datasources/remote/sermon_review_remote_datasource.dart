import 'dart:convert';
import 'package:bcsv_flutter_project/data/models/sermon_review_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching sermon reviews from Google Docs
class SermonReviewRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 30);

  /// Fetch sermon reviews from remote Google Docs API
  Future<List<SermonReviewModel>> fetchSermonReviews() async {
    try {
      // Check if API endpoints are initialized
      if (!ApiEndpoint().isInitialized) {
        log('⚠️ API endpoints not yet initialized, will use cache');
        throw const ServerException(
          message: 'Sermon review endpoint not yet initialized',
        );
      }

      final endpoint = ApiEndpoint.apiMap['BIBLE_REVIEW'];
      if (endpoint == null) {
        log('⚠️ BIBLE_REVIEW endpoint not found in API configuration');
        throw const ServerException(message: 'Sermon review endpoint not configured');
      }

      log('🔄 Fetching sermon reviews from: $endpoint');

      // Create model param for API call
      final modelParam = ModelParam(
        apiEndpoint: endpoint,
        tag: 'sundayReview',
        cacheFileName: kBibleReviewData,
        getSharedReference: UserSharedPreferences.getBibleReviewCache,
        setSharedReference: UserSharedPreferences.setBibleReviewCache,
      );

      // Use ApiGoogleDocContent to fetch data
      final apiContent = ApiGoogleDocContent(
        modelParam: modelParam,
        body: {},
        isBodyRequired: false,
      );

      // Fetch content with timeout
      final responseText = await apiContent.getContent().timeout(
        _timeout,
        onTimeout: () => throw const AppTimeoutException(
          operation: 'fetch sermon reviews',
        ),
      );

      if (responseText.isEmpty) {
        log('⚠️ Empty response from sermon review API');
        return [];
      }

      // Parse JSON response
      final jsonData = jsonDecode(responseText);
      final reviewsList = jsonData[modelParam.tag] as List?;

      if (reviewsList == null || reviewsList.isEmpty) {
        log('⚠️ No sermon reviews found in response');
        return [];
      }

      // Convert to models
      final reviews = reviewsList
          .map((json) => SermonReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();

      log('✅ Fetched ${reviews.length} sermon reviews');
      return reviews;
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching sermon reviews: $e');
      throw NetworkException(
        message: 'Failed to fetch sermon reviews',
        originalError: e,
      );
    }
  }
}
