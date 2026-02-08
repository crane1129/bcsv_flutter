// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_bible_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyBibleVerseModelImpl _$$DailyBibleVerseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyBibleVerseModelImpl(
      verse: json['Verse'] as String,
      content: json['Bible_Cn'] as String,
    );

Map<String, dynamic> _$$DailyBibleVerseModelImplToJson(
        _$DailyBibleVerseModelImpl instance) =>
    <String, dynamic>{
      'Verse': instance.verse,
      'Bible_Cn': instance.content,
    };

_$DailyBibleHeaderModelImpl _$$DailyBibleHeaderModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyBibleHeaderModelImpl(
      bibleName: json['Bible_name'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      date: json['Base_de'] as String,
    );

Map<String, dynamic> _$$DailyBibleHeaderModelImplToJson(
        _$DailyBibleHeaderModelImpl instance) =>
    <String, dynamic>{
      'Bible_name': instance.bibleName,
      'Bible_chapter': instance.bibleChapter,
      'Base_de': instance.date,
    };

_$DailyBibleModelImpl _$$DailyBibleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyBibleModelImpl(
      date: json['date'] as String,
      bibleName: json['bibleName'] as String,
      bibleChapter: json['bibleChapter'] as String,
      verses: (json['verses'] as List<dynamic>)
          .map((e) => DailyBibleVerseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DailyBibleModelImplToJson(
        _$DailyBibleModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'bibleName': instance.bibleName,
      'bibleChapter': instance.bibleChapter,
      'verses': instance.verses,
    };
