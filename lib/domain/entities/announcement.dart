import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

/// Domain entity for church announcements
@freezed
class AnnouncementEntity with _$AnnouncementEntity {
  const factory AnnouncementEntity({
    required String date,
    required String announcement,
    required String preacher,
    required String prayer,
    @Default('') String tuesdayPrayMeeting,
    @Default('') String babysitter,
    @Default('') String offering,
    @Default('') String fileUrl,
  }) = _AnnouncementEntity;

  const AnnouncementEntity._();

  /// Check if announcement has content
  bool get hasContent => announcement.isNotEmpty;

  /// Check if announcement has a PDF attachment
  bool get hasPdfAttachment => fileUrl.isNotEmpty;

  /// Get formatted header text
  String get headerText => '$date  설교 $preacher';

  /// Get formatted prayer info
  String get prayerInfo => '기도 $prayer';

  /// Get formatted content text
  String get contentText =>
      '광고내용\n$announcement\n\n헌금: $offering';
}
