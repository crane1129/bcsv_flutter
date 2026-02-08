import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/sunday_bible_text_model.dart';
import 'package:bcsv_flutter_project/domain/repositories/sunday_bible_text_repository.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching Sunday Bible texts from API
class SundayBibleTextRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);
  static const String _apiUrl =
      'https://script.google.com/macros/s/AKfycbwCn5iCa3MK1fPtz8y_Ut5PP-HlwWs-K8_YDrJW_UQpCOUEkQTf8xjpqOTt2ah6MnLX7A/exec';

  /// Fetch Sunday Bible texts with filters
  Future<List<SundayBibleTextModel>> fetchSundayBibleTexts(
    SundayBibleTextFilter filter,
  ) async {
    try {
      final queryParams = _buildQueryParams(filter);
      final uri = Uri.parse(_apiUrl).replace(queryParameters: queryParams);

      log('🔄 Fetching Sunday Bible texts with filter: ${filter.description}');
      log('🔄 URL: $uri');

      final response = await http
          .get(
            uri,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch Sunday Bible texts',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final bibleTextList = jsonData['bibleText'] as List?;

        if (bibleTextList == null || bibleTextList.isEmpty) {
          log('⚠️ No Sunday Bible texts found for filter: ${filter.description}');
          return [];
        }

        final texts = bibleTextList
            .map((json) => SundayBibleTextModel.fromJson(json as Map<String, dynamic>))
            .toList();

        // Sort by date (newest first)
        texts.sort((a, b) {
          try {
            final dateA = DateTime.parse(a.date);
            final dateB = DateTime.parse(b.date);
            return dateB.compareTo(dateA); // Descending order
          } catch (_) {
            return 0;
          }
        });

        log('✅ Fetched ${texts.length} Sunday Bible texts');
        return texts;
      } else {
        throw ServerException(
          message: 'Failed to fetch Sunday Bible texts',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching Sunday Bible texts: $e');
      throw NetworkException(
        message: 'Failed to fetch Sunday Bible texts',
        originalError: e,
      );
    }
  }

  /// Build query parameters based on filter
  Map<String, String> _buildQueryParams(SundayBibleTextFilter filter) {
    final params = <String, String>{
      'year': filter.year.toString(),
    };

    // Keyword search takes precedence
    if (filter.keyword?.isNotEmpty ?? false) {
      params['keyword'] = filter.keyword!;
    }
    // Exact month filter
    else if (filter.month != null) {
      params['month'] = filter.month.toString();
    }
    // Month range filter
    else if (filter.startMonth != null && filter.endMonth != null) {
      params['start'] = filter.startMonth.toString();
      params['end'] = filter.endMonth.toString();
    }

    return params;
  }
}
