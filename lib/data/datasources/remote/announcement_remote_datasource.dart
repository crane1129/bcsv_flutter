import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/data/models/announcement_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Remote datasource for fetching announcements from Google Docs API
class AnnouncementRemoteDatasource {
  static const Duration _timeout = Duration(seconds: 15);

  /// Fetch announcements from remote API
  Future<List<AnnouncementModel>> fetchAnnouncements() async {
    try {
      final endpoint = ApiEndpoint.apiMap['ANNOUNCEMENT'];
      if (endpoint == null) {
        throw const ServerException(message: 'Announcement endpoint not configured');
      }

      // Add year parameter to endpoint
      final Uri updatedEndpoint = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'year': DateTime.now().year.toString(),
        },
      );

      log('🔄 Fetching announcements from: $updatedEndpoint');

      final response = await http
          .get(
            updatedEndpoint,
            headers: {"Content-Type": "application/json"},
          )
          .timeout(
            _timeout,
            onTimeout: () => throw const AppTimeoutException(
              operation: 'fetch announcements',
            ),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final announcementsList = jsonData['announcements'] as List?;

        if (announcementsList == null) {
          log('⚠️ No announcements found in response');
          return [];
        }

        final announcements = announcementsList
            .map((json) => AnnouncementModel.fromJson(json as Map<String, dynamic>))
            .toList();

        log('✅ Fetched ${announcements.length} announcements');
        return announcements;
      } else {
        throw ServerException(
          message: 'Failed to fetch announcements',
          statusCode: response.statusCode,
        );
      }
    } on AppException {
      rethrow;
    } catch (e) {
      log('❌ Error fetching announcements: $e');
      throw NetworkException(
        message: 'Failed to fetch announcements',
        originalError: e,
      );
    }
  }
}
