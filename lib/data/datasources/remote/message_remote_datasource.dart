import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching messages from API
class MessageRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);

  /// Fetch messages from remote API
  Future<List<MessageModel>> fetchMessages() async {
    try {
      final endpoint = ApiEndpoint.apiMap['MESSAGE'];
      if (endpoint == null) {
        throw const ServerException(message: 'Message endpoint not configured');
      }

      log('🔄 Fetching messages from: $endpoint');

      final response = await http
          .get(
            endpoint,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch messages',
            ),
          );

      if (response.statusCode == 200) {
        // Message API returns a direct JSON array, not an object with 'messages' key
        final jsonData = jsonDecode(response.body);

        if (jsonData is! List) {
          log('⚠️ Unexpected response format (not a list)');
          return [];
        }

        final messagesList = jsonData;

        if (messagesList.isEmpty) {
          log('⚠️ No messages found in response');
          return [];
        }

        final messages = messagesList
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>))
            .toList();

        log('✅ Fetched ${messages.length} messages');
        return messages;
      } else {
        throw ServerException(
          message: 'Failed to fetch messages',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching messages: $e');
      throw NetworkException(
        message: 'Failed to fetch messages',
        originalError: e,
      );
    }
  }
}
