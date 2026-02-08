import 'package:freezed_annotation/freezed_annotation.dart';

part 'sunday_bible_text.freezed.dart';

/// Domain entity for Bible reference
@freezed
class BibleReferenceEntity with _$BibleReferenceEntity {
  const factory BibleReferenceEntity({
    required String textClass,
    required String bibleChapter,
    required String bibleText,
  }) = _BibleReferenceEntity;
}

/// Domain entity for review question
@freezed
class ReviewQuestionEntity with _$ReviewQuestionEntity {
  const factory ReviewQuestionEntity({
    required String textClass,
    required String bibleChapter,
    required String bibleText,
  }) = _ReviewQuestionEntity;
}

/// Domain entity for Sunday Bible text (sermon text)
@freezed
class SundayBibleTextEntity with _$SundayBibleTextEntity {
  const factory SundayBibleTextEntity({
    required String date,
    required String title,
    required String bibleChapter,
    required String bibleText,
    @Default('') String fileUrl,
    @Default([]) List<BibleReferenceEntity> references,
    ReviewQuestionEntity? reviewQuestion,
  }) = _SundayBibleTextEntity;

  const SundayBibleTextEntity._();

  /// Check if has content
  bool get hasContent => bibleText.isNotEmpty;

  /// Check if has PDF attachment
  bool get hasPdfAttachment => fileUrl.isNotEmpty;

  /// Check if has references
  bool get hasReferences => references.isNotEmpty;

  /// Check if has review question
  bool get hasReviewQuestion => reviewQuestion != null;

  /// Get reference count
  int get referenceCount => references.length;

  /// Parse date string to DateTime
  DateTime? get parsedDate {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  /// Get year from date
  int? get year => parsedDate?.year;

  /// Get month from date
  int? get month => parsedDate?.month;

  /// Get formatted date (for display)
  String get formattedDate {
    final parsed = parsedDate;
    if (parsed == null) return date;
    return '${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}';
  }

  /// Check if matches keyword (case-insensitive search in all text fields)
  bool matchesKeyword(String keyword) {
    if (keyword.isEmpty) return true;

    final lowercaseKeyword = keyword.toLowerCase();

    // Search in main fields
    if (title.toLowerCase().contains(lowercaseKeyword) ||
        bibleChapter.toLowerCase().contains(lowercaseKeyword) ||
        bibleText.toLowerCase().contains(lowercaseKeyword)) {
      return true;
    }

    // Search in references
    for (final ref in references) {
      if (ref.bibleChapter.toLowerCase().contains(lowercaseKeyword) ||
          ref.bibleText.toLowerCase().contains(lowercaseKeyword)) {
        return true;
      }
    }

    // Search in review question
    if (reviewQuestion != null) {
      if (reviewQuestion!.bibleChapter.toLowerCase().contains(lowercaseKeyword) ||
          reviewQuestion!.bibleText.toLowerCase().contains(lowercaseKeyword)) {
        return true;
      }
    }

    return false;
  }
}
