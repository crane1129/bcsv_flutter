import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_bible.freezed.dart';

/// Domain entity for daily Bible verse
@freezed
class DailyBibleVerseEntity with _$DailyBibleVerseEntity {
  const factory DailyBibleVerseEntity({
    required String verse,
    required String content,
  }) = _DailyBibleVerseEntity;
}

/// Domain entity for daily Bible reading (QT)
@freezed
class DailyBibleEntity with _$DailyBibleEntity {
  const factory DailyBibleEntity({
    required String date,
    required String bibleName,
    required String bibleChapter,
    required List<DailyBibleVerseEntity> verses,
  }) = _DailyBibleEntity;

  const DailyBibleEntity._();

  /// Get formatted title (e.g., "창세기 1:1-5")
  String get title => '$bibleName $bibleChapter';

  /// Check if has content
  bool get hasContent => verses.isNotEmpty;

  /// Get total verse count
  int get verseCount => verses.length;

  /// Get full text (all verses combined)
  String get fullText => verses.map((v) => v.content).join(' ');

  /// Parse date string to DateTime
  DateTime? get parsedDate {
    try {
      return DateTime.parse(date);
    } catch (_) {
      return null;
    }
  }

  /// Check if this is today's reading
  bool get isToday {
    final today = DateTime.now();
    final readingDate = parsedDate;
    if (readingDate == null) return false;

    return today.year == readingDate.year &&
        today.month == readingDate.month &&
        today.day == readingDate.day;
  }

  /// Check if this is a future date
  bool get isFuture {
    final readingDate = parsedDate;
    if (readingDate == null) return false;
    return readingDate.isAfter(DateTime.now());
  }
}
