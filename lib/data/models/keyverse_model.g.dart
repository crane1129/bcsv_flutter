// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyverse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeyVerseModelImpl _$$KeyVerseModelImplFromJson(Map<String, dynamic> json) =>
    _$KeyVerseModelImpl(
      year: (json['year'] as num).toInt(),
      title: json['title'] as String,
      book: json['book'] as String,
      chapter: (json['chapter'] as num).toInt(),
      verseFrom: (json['verseFrom'] as num).toInt(),
      verseEnd: (json['verseEnd'] as num).toInt(),
      verse: json['verse'] as String,
    );

Map<String, dynamic> _$$KeyVerseModelImplToJson(_$KeyVerseModelImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'title': instance.title,
      'book': instance.book,
      'chapter': instance.chapter,
      'verseFrom': instance.verseFrom,
      'verseEnd': instance.verseEnd,
      'verse': instance.verse,
    };
