import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

/// Domain entity for church messages/notifications
///
/// Uses Wix database fields:
/// - createdAt: Auto-generated timestamp for "new" detection
/// - startDate: When the message becomes visible
/// - endDate: When the message stops being visible (null = forever)
@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String id,  // Wix _id for updates
    required DateTime createdAt,
    required String title,
    required String message,  // Can contain HTML
    required String category,
    required DateTime startDate,
    DateTime? endDate,  // null = visible forever
    @Default('') String imageUrl,
    @Default('') String externalLink,
  }) = _MessageEntity;

  const MessageEntity._();

  /// Check if message has an image
  bool get hasImage => imageUrl.isNotEmpty;

  /// Check if message has an external link
  bool get hasExternalLink => externalLink.isNotEmpty;

  /// Check if message is currently visible based on startDate and endDate
  /// Compares dates only (ignoring time)
  /// Note: startDate/endDate from Wix are stored as UTC midnight, but represent
  /// the user's intended local date, so we extract year/month/day directly
  bool get isVisible {
    final now = DateTime.now();
    final todayLocal = DateTime(now.year, now.month, now.day);

    // Extract date components from startDate (UTC values represent the intended date)
    final startDateOnly = DateTime(startDate.year, startDate.month, startDate.day);

    // Message is not visible if startDate is in the future
    if (startDateOnly.isAfter(todayLocal)) return false;

    // Message is not visible if endDate has passed
    if (endDate != null) {
      final endDateOnly = DateTime(endDate!.year, endDate!.month, endDate!.day);
      if (endDateOnly.isBefore(todayLocal)) return false;
    }

    return true;
  }
}
