// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      messageId: (json['MessageID'] as num).toInt(),
      title: json['Title'] as String,
      message: json['Message'] as String,
      category: json['Category'] as String,
      expireDate: json['ExpireDate'] as String,
      imageLink: json['ImageLink'] as String? ?? '',
      externalLink: json['ExternalLink'] as String? ?? '',
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'MessageID': instance.messageId,
      'Title': instance.title,
      'Message': instance.message,
      'Category': instance.category,
      'ExpireDate': instance.expireDate,
      'ImageLink': instance.imageLink,
      'ExternalLink': instance.externalLink,
    };
