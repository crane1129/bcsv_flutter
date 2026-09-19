import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching messages from Wix API
class MessageRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);
  static const String _wixEndpoint =
      'https://bcsv-api.crane1129.workers.dev/api/activeMessages';

  /// Fetch messages from Wix API
  Future<List<MessageModel>> fetchMessages() async {
    try {
      final uri = Uri.parse(_wixEndpoint);
      log('🔄 Fetching messages from: $uri');

      final response = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      ).timeout(
        _timeout,
        onTimeout: () => throw const AppTimeoutException(
          operation: 'fetch messages',
        ),
      );

      if (response.statusCode == 200) {
        // Wix API returns: { now, count, items: [...] }
        final jsonData = jsonDecode(response.body);

        if (jsonData is! Map<String, dynamic>) {
          log('⚠️ Unexpected response format (not an object)');
          return [];
        }

        final messagesList = jsonData['items'] as List<dynamic>?;

        if (messagesList == null || messagesList.isEmpty) {
          log('⚠️ No messages found in response');
          return [];
        }

        final messages = messagesList.map((json) {
          final jsonMap = json as Map<String, dynamic>;
          // Debug: log all field names and image-related fields
          log('📦 Message fields: ${jsonMap.keys.toList()}');
          log('📷 titleImage: ${jsonMap['titleImage']} (type: ${jsonMap['titleImage']?.runtimeType})');
          log('📷 image: ${jsonMap['image']} (type: ${jsonMap['image']?.runtimeType})');
          return MessageModel.fromJson(jsonMap);
        }).toList();

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
