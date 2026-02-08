import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/serving_turn_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching serving turns from API
class ServingTurnRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);

  /// Fetch serving turns from remote API
  Future<List<ServingTurnModel>> fetchServingTurns() async {
    try {
      // Check if API endpoints are initialized
      if (!ApiEndpoint().isInitialized) {
        log('⚠️ API endpoints not yet initialized, will use cache');
        throw const ServerException(
          message: 'Serving turn endpoint not yet initialized',
        );
      }

      final endpoint = ApiEndpoint.apiMap['SERVING_TURN'];
      if (endpoint == null) {
        log('⚠️ SERVING_TURN endpoint not found in API configuration');
        throw const ServerException(message: 'Serving turn endpoint not configured');
      }

      // Add year parameter
      final Uri updatedEndpoint = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'year': DateTime.now().year.toString(),
        },
      );

      log('🔄 Fetching serving turns from: $updatedEndpoint');

      final response = await http
          .get(
            updatedEndpoint,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch serving turns',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        log('🔍 [ServingTurn] Response keys: ${jsonData.keys.toList()}');
        log('🔍 [ServingTurn] Response body preview: ${response.body.length > 200 ? response.body.substring(0, 200) : response.body}');
        final servingTurnsList = jsonData['servingTurns'] as List?;

        if (servingTurnsList == null) {
          log('⚠️ No serving turns found in response (key "servingTurns" not found)');
          return [];
        }

        final servingTurns = servingTurnsList
            .map((json) => ServingTurnModel.fromJson(json as Map<String, dynamic>))
            .toList();

        log('✅ Fetched ${servingTurns.length} serving turns');
        return servingTurns;
      } else {
        throw ServerException(
          message: 'Failed to fetch serving turns',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching serving turns: $e');
      throw NetworkException(
        message: 'Failed to fetch serving turns',
        originalError: e,
      );
    }
  }
}
