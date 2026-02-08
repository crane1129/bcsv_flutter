import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/keyverse_model.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching key verse from API
class KeyVerseRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 10);
  static const String _baseUrl = 'https://www.bridgeway.online/_functions/keyVerse';

  /// Fetch key verse for a specific year from remote API
  Future<KeyVerseModel?> fetchKeyVerse(int year) async {
    try {
      final uri = Uri.parse(_baseUrl).replace(
        queryParameters: {'year': year.toString()},
      );

      log('🔄 Fetching key verse for year $year from: $uri');

      final response = await http
          .get(
            uri,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch key verse',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final results = jsonData['results'] as List?;

        if (results == null || results.isEmpty) {
          log('⚠️ No key verse found for year $year');
          return null;
        }

        final keyVerse = KeyVerseModel.fromJson(results.first as Map<String, dynamic>);
        log('✅ Fetched key verse for year $year: ${keyVerse.title}');
        return keyVerse;
      } else {
        throw ServerException(
          message: 'Failed to fetch key verse',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching key verse: $e');
      throw NetworkException(
        message: 'Failed to fetch key verse',
        originalError: e,
      );
    }
  }
}
