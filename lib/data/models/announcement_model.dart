import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

/// Data model for announcement with JSON serialization
@freezed
class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    required String date,
    required String announcement,
    required String preacher,
    required String prayer,
    @JsonKey(name: 'tuesday_pray_meeting') @Default('') String tuesdayPrayMeeting,
    @Default('') String babysitter,
    @Default('') String offering,
    @JsonKey(name: 'File_url') @Default('') String fileUrl,
  }) = _AnnouncementModel;

  const AnnouncementModel._();

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);

  /// Convert to domain entity
  AnnouncementEntity toEntity() {
    return AnnouncementEntity(
      date: date,
      announcement: announcement,
      preacher: preacher,
      prayer: prayer,
      tuesdayPrayMeeting: tuesdayPrayMeeting,
      babysitter: babysitter,
      offering: offering,
      fileUrl: fileUrl,
    );
  }

  /// Create from domain entity
  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      date: entity.date,
      announcement: entity.announcement,
      preacher: entity.preacher,
      prayer: entity.prayer,
      tuesdayPrayMeeting: entity.tuesdayPrayMeeting,
      babysitter: entity.babysitter,
      offering: entity.offering,
      fileUrl: entity.fileUrl,
    );
  }
}
