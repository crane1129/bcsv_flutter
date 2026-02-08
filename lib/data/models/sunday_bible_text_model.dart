import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';

part 'sunday_bible_text_model.freezed.dart';
part 'sunday_bible_text_model.g.dart';

/// Data model for Bible reference
@freezed
class BibleReferenceModel with _$BibleReferenceModel {
  const factory BibleReferenceModel({
    @JsonKey(name: 'Text_Class') required String textClass,
    @JsonKey(name: 'Bible_chapter') required String bibleChapter,
    @JsonKey(name: 'Bible_text') required String bibleText,
  }) = _BibleReferenceModel;

  const BibleReferenceModel._();

  factory BibleReferenceModel.fromJson(Map<String, dynamic> json) =>
      _$BibleReferenceModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return {
      'Text_Class': json['Text_Class']?.toString() ?? '',
      'Bible_chapter': json['Bible_chapter']?.toString() ?? '',
      'Bible_text': json['Bible_text']?.toString() ?? '',
    };
  }

  /// Convert to domain entity
  BibleReferenceEntity toEntity() {
    return BibleReferenceEntity(
      textClass: textClass,
      bibleChapter: bibleChapter,
      bibleText: bibleText,
    );
  }
}

/// Data model for review question
@freezed
class ReviewQuestionModel with _$ReviewQuestionModel {
  const factory ReviewQuestionModel({
    @JsonKey(name: 'Text_Class') required String textClass,
    @JsonKey(name: 'Bible_chapter') required String bibleChapter,
    @JsonKey(name: 'Bible_text') required String bibleText,
  }) = _ReviewQuestionModel;

  const ReviewQuestionModel._();

  factory ReviewQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewQuestionModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return {
      'Text_Class': json['Text_Class']?.toString() ?? '',
      'Bible_chapter': json['Bible_chapter']?.toString() ?? '',
      'Bible_text': json['Bible_text']?.toString() ?? '',
    };
  }

  /// Convert to domain entity
  ReviewQuestionEntity toEntity() {
    return ReviewQuestionEntity(
      textClass: textClass,
      bibleChapter: bibleChapter,
      bibleText: bibleText,
    );
  }
}

/// Data model for Sunday Bible text
@freezed
class SundayBibleTextModel with _$SundayBibleTextModel {
  const factory SundayBibleTextModel({
    @JsonKey(name: 'Date') required String date,
    @JsonKey(name: 'Title') required String title,
    @JsonKey(name: 'Bible_chapter') required String bibleChapter,
    @JsonKey(name: 'Bible_text') required String bibleText,
    @JsonKey(name: 'File_url') @Default('') String fileUrl,
    @JsonKey(name: 'References') @Default([]) List<BibleReferenceModel> references,
    @JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? reviewQuestion,
  }) = _SundayBibleTextModel;

  const SundayBibleTextModel._();

  factory SundayBibleTextModel.fromJson(Map<String, dynamic> json) =>
      _$SundayBibleTextModelFromJson(_normalizeJson(json));

  /// Normalize JSON to handle dynamic types and nested structures
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    // Parse references list
    List<Map<String, dynamic>> references = [];
    if (json['References'] is List) {
      references = (json['References'] as List)
          .where((item) => item is Map)
          .map((item) => item as Map<String, dynamic>)
          .toList();
    }

    // Parse review question
    Map<String, dynamic>? reviewQuestion;
    if (json['ReviewQuestion'] is Map) {
      reviewQuestion = json['ReviewQuestion'] as Map<String, dynamic>;
    }

    return {
      'Date': json['Date']?.toString() ?? '',
      'Title': json['Title']?.toString() ?? '',
      'Bible_chapter': json['Bible_chapter']?.toString() ?? '',
      'Bible_text': json['Bible_text']?.toString() ?? '',
      'File_url': json['File_url']?.toString() ?? '',
      'References': references,
      'ReviewQuestion': reviewQuestion,
    };
  }

  /// Convert to domain entity
  SundayBibleTextEntity toEntity() {
    return SundayBibleTextEntity(
      date: date,
      title: title,
      bibleChapter: bibleChapter,
      bibleText: bibleText,
      fileUrl: fileUrl,
      references: references.map((r) => r.toEntity()).toList(),
      reviewQuestion: reviewQuestion?.toEntity(),
    );
  }

  /// Create from domain entity
  factory SundayBibleTextModel.fromEntity(SundayBibleTextEntity entity) {
    return SundayBibleTextModel(
      date: entity.date,
      title: entity.title,
      bibleChapter: entity.bibleChapter,
      bibleText: entity.bibleText,
      fileUrl: entity.fileUrl,
      references: entity.references
          .map((r) => BibleReferenceModel(
                textClass: r.textClass,
                bibleChapter: r.bibleChapter,
                bibleText: r.bibleText,
              ))
          .toList(),
      reviewQuestion: entity.reviewQuestion != null
          ? ReviewQuestionModel(
              textClass: entity.reviewQuestion!.textClass,
              bibleChapter: entity.reviewQuestion!.bibleChapter,
              bibleText: entity.reviewQuestion!.bibleText,
            )
          : null,
    );
  }
}
