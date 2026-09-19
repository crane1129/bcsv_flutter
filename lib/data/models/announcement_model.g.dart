// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    _AnnouncementModel(
      date: json['date'] as String,
      announcement: json['announcement'] as String,
      preacher: json['preacher'] as String,
      prayer: json['prayer'] as String,
      tuesdayPrayMeeting: json['tuesday_pray_meeting'] as String? ?? '',
      babysitter: json['babysitter'] as String? ?? '',
      offering: json['offering'] as String? ?? '',
      fileUrl: json['File_url'] as String? ?? '',
    );

Map<String, dynamic> _$AnnouncementModelToJson(_AnnouncementModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'announcement': instance.announcement,
      'preacher': instance.preacher,
      'prayer': instance.prayer,
      'tuesday_pray_meeting': instance.tuesdayPrayMeeting,
      'babysitter': instance.babysitter,
      'offering': instance.offering,
      'File_url': instance.fileUrl,
    };
