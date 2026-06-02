import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/daily_bible_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching daily Bible from API
class DailyBibleRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);
  static const String _qtType = 'QT1';

  /// Fetch daily Bible for a specific date from remote API
  /// Requires both DAILY_BIBLE1 and DAILY_BIBLE2 endpoints
  Future<DailyBibleModel?> fetchDailyBible(String date) async {
    try {
      // Check if API endpoints are initialized
      if (!ApiEndpoint().isInitialized) {
        log('⚠️ API endpoints not yet initialized, will use cache');
        throw const ServerException(
          message: 'Daily Bible endpoints not yet initialized',
        );
      }

      final endpoint1 = ApiEndpoint.apiMap['DAILY_BIBLE1'];
      final endpoint2 = ApiEndpoint.apiMap['DAILY_BIBLE2'];

      if (endpoint1 == null || endpoint2 == null) {
        log('⚠️ DAILY_BIBLE1 or DAILY_BIBLE2 endpoints not found in API configuration');
        throw const ServerException(
          message: 'Daily Bible endpoints not configured',
        );
      }

      log('🔄 Fetching daily Bible for date: $date');

      // Prepare request body
      final body = {
        'qt_ty': _qtType,
        'Base_de': date,
      };

      // Fetch header and verses in parallel
      final results = await Future.wait([
        _fetchHeader(endpoint1, body),
        _fetchVerses(endpoint2, body),
      ]);

      final header = results[0] as DailyBibleHeaderModel?;
      final verses = results[1] as List<DailyBibleVerseModel>;

      if (header == null) {
        log('⚠️ No daily Bible header found for date $date');
        return null;
      }

      final dailyBible = DailyBibleModel.fromHeaderAndVerses(
        header: header,
        verses: verses,
      );

      log('✅ Fetched daily Bible for $date: ${dailyBible.bibleName} ${dailyBible.bibleChapter} (${verses.length} verses)');
      return dailyBible;
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching daily Bible: $e');
      throw NetworkException(
        message: 'Failed to fetch daily Bible',
        originalError: e,
      );
    }
  }

  /// Fetch header information (DAILY_BIBLE1)
  Future<DailyBibleHeaderModel?> _fetchHeader(
    Uri endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      log('🔄 Fetching daily Bible header from: $endpoint');

      final response = await http
          .post(
            endpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch daily Bible header',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic>) {
          return DailyBibleHeaderModel.fromJson(jsonData);
        } else {
          log('⚠️ Unexpected response format for header');
          return null;
        }
      } else {
        throw ServerException(
          message: 'Failed to fetch daily Bible header',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      log('❌ Error fetching header: $e');
      rethrow;
    }
  }

  /// Fetch verse content (DAILY_BIBLE2)
  Future<List<DailyBibleVerseModel>> _fetchVerses(
    Uri endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      log('🔄 Fetching daily Bible verses from: $endpoint');

      final response = await http
          .post(
            endpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch daily Bible verses',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is! List) {
          log('⚠️ Unexpected response format for verses (not a list)');
          return [];
        }

        final verses = (jsonData)
            .map((json) => DailyBibleVerseModel.fromJson(json as Map<String, dynamic>))
            .toList();

        log('✅ Fetched ${verses.length} verses');
        return verses;
      } else {
        throw ServerException(
          message: 'Failed to fetch daily Bible verses',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      log('❌ Error fetching verses: $e');
      // Return empty list on error (header is more important)
      return [];
    }
  }
}
