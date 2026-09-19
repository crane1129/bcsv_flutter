// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_bible_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyBibleVerseModel _$DailyBibleVerseModelFromJson(
  Map<String, dynamic> json,
) => _DailyBibleVerseModel(
  verse: json['Verse'] as String,
  content: json['Bible_Cn'] as String,
);

Map<String, dynamic> _$DailyBibleVerseModelToJson(
  _DailyBibleVerseModel instance,
) => <String, dynamic>{'Verse': instance.verse, 'Bible_Cn': instance.content};

_DailyBibleHeaderModel _$DailyBibleHeaderModelFromJson(
  Map<String, dynamic> json,
) => _DailyBibleHeaderModel(
  bibleName: json['Bible_name'] as String,
  bibleChapter: json['Bible_chapter'] as String,
  date: json['Base_de'] as String,
);

Map<String, dynamic> _$DailyBibleHeaderModelToJson(
  _DailyBibleHeaderModel instance,
) => <String, dynamic>{
  'Bible_name': instance.bibleName,
  'Bible_chapter': instance.bibleChapter,
  'Base_de': instance.date,
};

_DailyBibleModel _$DailyBibleModelFromJson(Map<String, dynamic> json) =>
    _DailyBibleModel(
      date: json['date'] as String,
      bibleName: json['bibleName'] as String,
      bibleChapter: json['bibleChapter'] as String,
      verses: (json['verses'] as List<dynamic>)
          .map((e) => DailyBibleVerseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyBibleModelToJson(_DailyBibleModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'bibleName': instance.bibleName,
      'bibleChapter': instance.bibleChapter,
      'verses': instance.verses,
    };
