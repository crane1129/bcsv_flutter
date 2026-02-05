import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

/// Domain entity for church messages/notifications
@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required int messageId,
    required String title,
    required String message,
    required String category,
    required String expireDate,
    @Default('') String imageLink,
    @Default('') String externalLink,
  }) = _MessageEntity;

  const MessageEntity._();

  /// Check if message has an image
  bool get hasImage => imageLink.isNotEmpty;

  /// Check if message has an external link
  bool get hasExternalLink => externalLink.isNotEmpty;

  /// Check if message is expired
  bool get isExpired {
    try {
      final expiry = DateTime.parse(expireDate);
      return DateTime.now().isAfter(expiry);
    } catch (_) {
      return false;
    }
  }
}
