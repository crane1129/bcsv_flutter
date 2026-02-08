// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sunday_bible_text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BibleReferenceModelImpl _$$BibleReferenceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BibleReferenceModelImpl(
      textClass: json['Text_Class'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      bibleText: json['Bible_text'] as String,
    );

Map<String, dynamic> _$$BibleReferenceModelImplToJson(
        _$BibleReferenceModelImpl instance) =>
    <String, dynamic>{
      'Text_Class': instance.textClass,
      'Bible_chapter': instance.bibleChapter,
      'Bible_text': instance.bibleText,
    };

_$ReviewQuestionModelImpl _$$ReviewQuestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReviewQuestionModelImpl(
      textClass: json['Text_Class'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      bibleText: json['Bible_text'] as String,
    );

Map<String, dynamic> _$$ReviewQuestionModelImplToJson(
        _$ReviewQuestionModelImpl instance) =>
    <String, dynamic>{
      'Text_Class': instance.textClass,
      'Bible_chapter': instance.bibleChapter,
      'Bible_text': instance.bibleText,
    };

_$SundayBibleTextModelImpl _$$SundayBibleTextModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SundayBibleTextModelImpl(
      date: json['Date'] as String,
      title: json['Title'] as String,
      bibleChapter: json['Bible_chapter'] as String,
      bibleText: json['Bible_text'] as String,
      fileUrl: json['File_url'] as String? ?? '',
      references: (json['References'] as List<dynamic>?)
              ?.map((e) =>
                  BibleReferenceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviewQuestion: json['ReviewQuestion'] == null
          ? null
          : ReviewQuestionModel.fromJson(
              json['ReviewQuestion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SundayBibleTextModelImplToJson(
        _$SundayBibleTextModelImpl instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'Title': instance.title,
      'Bible_chapter': instance.bibleChapter,
      'Bible_text': instance.bibleText,
      'File_url': instance.fileUrl,
      'References': instance.references,
      'ReviewQuestion': instance.reviewQuestion,
    };
