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
class MessageModel with _$MessageModel {
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
  /// Maps Wix field names to internal field names expected by freezed
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    // Get titleImage from Wix - handle both string and object formats
    final rawTitleImage = json['titleImage'];
    String rawImageUrl = '';

    if (rawTitleImage is String) {
      // Direct string URL
      rawImageUrl = rawTitleImage;
    } else if (rawTitleImage is Map) {
      // Wix document/attachment object format: { src: "wix:image://...", ... }
      rawImageUrl = rawTitleImage['src']?.toString() ??
                    rawTitleImage['url']?.toString() ?? '';
    }

    final httpImageUrl = _convertWixImageUrl(rawImageUrl);

    return {
      // Wix document ID
      '_id': json['_id']?.toString() ?? '',
      // Wix uses '_createdDate', map to 'Created Date' for freezed
      'Created Date': _toIsoString(json['_createdDate']),
      // Wix uses lowercase 'title', map to 'Title' for freezed
      'Title': json['title']?.toString() ?? '',
      'message': json['message']?.toString() ?? '',
      'category': json['category']?.toString() ?? '',
      'startDate': _toIsoString(json['startDate']),
      'endDate': json['endDate'] != null ? _toIsoString(json['endDate']) : null,
      // Convert Wix image URL to HTTP URL
      'titleImage': httpImageUrl,
      'externalLink': json['externalLink']?.toString() ?? '',
    };
  }

  /// Convert Wix image URL format to HTTP URL
  ///
  /// Wix attachment format:
  /// wix:image://v1/{file_id}~mv2.{ext}/{filename}#originWidth={w}&originHeight={h}
  ///
  /// Converts to:
  /// https://static.wixstatic.com/media/{file_id}~mv2.{ext}
  static String _convertWixImageUrl(String wixUrl) {
    if (wixUrl.isEmpty) return '';

    // If it's already an HTTP URL, return as-is
    if (wixUrl.startsWith('http://') || wixUrl.startsWith('https://')) {
      return wixUrl;
    }

    // Check if it's a Wix image URL
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
