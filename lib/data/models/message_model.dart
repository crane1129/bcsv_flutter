import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// Data model for message with JSON serialization
///
/// Maps to Wix database schema:
/// - '_createdDate': Auto-generated timestamp (ISO8601)
/// - 'title': Message title
/// - 'message': Rich text content (HTML)
/// - 'category': Message category
/// - 'startDate': Visibility start date (YYYY-MM-DD)
/// - 'endDate': Visibility end date (YYYY-MM-DD, nullable)
/// - 'titleImage': Wix attachment URL (wix:image://v1/...)
/// - 'externalLink': External link URL
@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'Created Date') required DateTime createdAt,
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'message') required String message,
    @JsonKey(name: 'category') required String category,
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') DateTime? endDate,
    @JsonKey(name: 'titleImage') @Default('') String imageUrl,
    @JsonKey(name: 'externalLink') @Default('') String externalLink,
  }) = _MessageModel;

  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(_normalizeJson(json));

  /// Normalize JSON to handle dynamic types and Wix date formats
  /// Normalize JSON from Cloudflare D1 (snake_case) or legacy Wix format
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    // Image URL: D1 returns 'image_url', Wix returns 'titleImage'
    final rawTitleImage = json['titleImage'] ?? json['image_url'];
    String rawImageUrl = '';

    if (rawTitleImage is String) {
      rawImageUrl = rawTitleImage;
    } else if (rawTitleImage is Map) {
      rawImageUrl = rawTitleImage['src']?.toString() ??
                    rawTitleImage['url']?.toString() ?? '';
    }

    final httpImageUrl = _convertWixImageUrl(rawImageUrl);

    return {
      // D1 uses 'id', Wix uses '_id'
      '_id': json['_id']?.toString() ?? json['id']?.toString() ?? '',
      // D1 uses 'created_at', Wix uses '_createdDate'
      'Created Date': _toIsoString(json['_createdDate'] ?? json['Created Date'] ?? json['created_at']),
      'Title': json['title']?.toString() ?? '',
      'message': json['message']?.toString() ?? '',
      'category': json['category']?.toString() ?? '',
      // D1 uses 'start_date', Wix uses 'startDate'
      'startDate': _toIsoString(json['startDate'] ?? json['start_date']),
      'endDate': (json['endDate'] ?? json['end_date']) != null
          ? _toIsoString(json['endDate'] ?? json['end_date'])
          : null,
      'titleImage': httpImageUrl,
      // D1 uses 'external_link', Wix uses 'externalLink'
      'externalLink': json['externalLink']?.toString() ?? json['external_link']?.toString() ?? '',
    };
  }

  /// Convert Wix image URL format to HTTP URL
  ///
  /// Wix attachment format:
  /// wix:image://v1/{file_id}~mv2.{ext}/{filename}#originWidth={w}&originHeight={h}
  ///
  /// Converts to:
  /// https://static.wixstatic.com/media/{file_id}~mv2.{ext}
  static const String _apiBaseUrl = 'https://bcsv-api.crane1129.workers.dev';

  static String _convertWixImageUrl(String wixUrl) {
    if (wixUrl.isEmpty) return '';

    if (wixUrl.startsWith('http://') || wixUrl.startsWith('https://')) {
      return wixUrl;
    }

    // R2 relative path from Cloudflare Worker (e.g. /r2/images/...)
    if (wixUrl.startsWith('/r2/')) {
      return '$_apiBaseUrl$wixUrl';
    }

    if (!wixUrl.startsWith('wix:image://')) {
      return wixUrl;
    }

    try {
      // Extract the file ID from wix:image://v1/{file_id}~mv2.{ext}/{filename}#...
      // Remove the protocol prefix
      String path = wixUrl.replaceFirst('wix:image://v1/', '');

      // Remove the fragment (everything after #)
      if (path.contains('#')) {
        path = path.split('#').first;
      }

      // Extract just the file ID (before the first /)
      String fileId = path;
      if (path.contains('/')) {
        fileId = path.split('/').first;
      }

      // Construct the HTTP URL
      return 'https://static.wixstatic.com/media/$fileId';
    } catch (e) {
      // If parsing fails, return empty string
      return '';
    }
  }

  /// Convert various date formats to ISO8601 string for json_serializable
  /// Handles both full datetime and date-only strings (YYYY-MM-DD) from Wix
  static String _toIsoString(dynamic value) {
    if (value == null) return DateTime.now().toIso8601String();
    if (value is DateTime) return value.toIso8601String();
    if (value is String) {
      // Handle date-only format (YYYY-MM-DD) from Wix
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
        return '${value}T00:00:00.000';
      }
      // Validate it's a parseable date string
      final parsed = DateTime.tryParse(value);
      return parsed?.toIso8601String() ?? DateTime.now().toIso8601String();
    }
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value).toIso8601String();
    }
    return DateTime.now().toIso8601String();
  }

  /// Convert to domain entity
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      createdAt: createdAt,
      title: title,
      message: message,
      category: category,
      startDate: startDate,
      endDate: endDate,
      imageUrl: imageUrl,
      externalLink: externalLink,
    );
  }

  /// Create from domain entity
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      createdAt: entity.createdAt,
      title: entity.title,
      message: entity.message,
      category: entity.category,
      startDate: entity.startDate,
      endDate: entity.endDate,
      imageUrl: entity.imageUrl,
      externalLink: entity.externalLink,
    );
  }
}
