// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sunday_bible_text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BibleReferenceModel _$BibleReferenceModelFromJson(Map<String, dynamic> json) =>
    _BibleReferenceModel(
      textClass: json['Text_Class'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      bibleText: json['Bible_text'] as String,
    );

Map<String, dynamic> _$BibleReferenceModelToJson(
  _BibleReferenceModel instance,
) => <String, dynamic>{
  'Text_Class': instance.textClass,
  'Bible_chapter': instance.bibleChapter,
  'Bible_text': instance.bibleText,
};

_ReviewQuestionModel _$ReviewQuestionModelFromJson(Map<String, dynamic> json) =>
    _ReviewQuestionModel(
      textClass: json['Text_Class'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      bibleText: json['Bible_text'] as String,
    );

Map<String, dynamic> _$ReviewQuestionModelToJson(
  _ReviewQuestionModel instance,
) => <String, dynamic>{
  'Text_Class': instance.textClass,
  'Bible_chapter': instance.bibleChapter,
  'Bible_text': instance.bibleText,
};

_SundayBibleTextModel _$SundayBibleTextModelFromJson(
  Map<String, dynamic> json,
) => _SundayBibleTextModel(
  date: json['Date'] as String,
  title: json['Title'] as String,
  bibleChapter: json['Bible_chapter'] as String,
  bibleText: json['Bible_text'] as String,
  fileUrl: json['File_url'] as String? ?? '',
  references:
      (json['References'] as List<dynamic>?)
          ?.map((e) => BibleReferenceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  reviewQuestion: json['ReviewQuestion'] == null
      ? null
      : ReviewQuestionModel.fromJson(
          json['ReviewQuestion'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SundayBibleTextModelToJson(
  _SundayBibleTextModel instance,
) => <String, dynamic>{
  'Date': instance.date,
  'Title': instance.title,
  'Bible_chapter': instance.bibleChapter,
  'Bible_text': instance.bibleText,
  'File_url': instance.fileUrl,
  'References': instance.references,
  'ReviewQuestion': instance.reviewQuestion,
};
