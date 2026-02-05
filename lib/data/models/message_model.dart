import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// Data model for message with JSON serialization
@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @JsonKey(name: 'MessageID') required int messageId,
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Message') required String message,
    @JsonKey(name: 'Category') required String category,
    @JsonKey(name: 'ExpireDate') required String expireDate,
    @JsonKey(name: 'ImageLink') @Default('') String imageLink,
    @JsonKey(name: 'ExternalLink') @Default('') String externalLink,
  }) = _MessageModel;

  const MessageModel._();

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(_normalizeJson(json));

  /// Normalize JSON to handle dynamic types
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return {
      'MessageID': _asInt(json['MessageID']),
      'Title': json['Title']?.toString() ?? '',
      'Message': json['Message']?.toString() ?? '',
      'Category': json['Category']?.toString() ?? '',
      'ExpireDate': json['ExpireDate']?.toString() ?? '',
      'ImageLink': json['ImageLink']?.toString() ?? '',
      'ExternalLink': json['ExternalLink']?.toString() ?? '',
    };
  }

  static int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  /// Convert to domain entity
  MessageEntity toEntity() {
    return MessageEntity(
      messageId: messageId,
      title: title,
      message: message,
      category: category,
      expireDate: expireDate,
      imageLink: imageLink,
      externalLink: externalLink,
    );
  }

  /// Create from domain entity
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      messageId: entity.messageId,
      title: entity.title,
      message: entity.message,
      category: entity.category,
      expireDate: entity.expireDate,
      imageLink: entity.imageLink,
      externalLink: entity.externalLink,
    );
  }
}
