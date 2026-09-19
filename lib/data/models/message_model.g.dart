// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['Created Date'] as String),
      title: json['Title'] as String,
      message: json['message'] as String,
      category: json['category'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      imageUrl: json['titleImage'] as String? ?? '',
      externalLink: json['externalLink'] as String? ?? '',
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'Created Date': instance.createdAt.toIso8601String(),
      'Title': instance.title,
      'message': instance.message,
      'category': instance.category,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'titleImage': instance.imageUrl,
      'externalLink': instance.externalLink,
    };
