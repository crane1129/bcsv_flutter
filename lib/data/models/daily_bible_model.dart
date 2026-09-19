import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/daily_bible.dart';

part 'daily_bible_model.freezed.dart';
part 'daily_bible_model.g.dart';

/// Data model for daily Bible verse
@freezed
abstract class DailyBibleVerseModel with _$DailyBibleVerseModel {
  const factory DailyBibleVerseModel({
    @JsonKey(name: 'Verse') required String verse,
    @JsonKey(name: 'Bible_Cn') required String content,
  }) = _DailyBibleVerseModel;

  const DailyBibleVerseModel._();

  factory DailyBibleVerseModel.fromJson(Map<String, dynamic> json) =>
      _$DailyBibleVerseModelFromJson(_normalizeVerseJson(json));

  /// Normalize JSON to handle dynamic types (API returns Verse as int)
  static Map<String, dynamic> _normalizeVerseJson(Map<String, dynamic> json) {
    return {
      'Verse': json['Verse']?.toString() ?? '',
      'Bible_Cn': json['Bible_Cn']?.toString() ?? '',
    };
  }

  /// Convert to domain entity
  DailyBibleVerseEntity toEntity() {
    return DailyBibleVerseEntity(
      verse: verse,
      content: content,
    );
  }
}

/// Data model for daily Bible header (from DAILY_BIBLE1 endpoint)
@freezed
abstract class DailyBibleHeaderModel with _$DailyBibleHeaderModel {
  const factory DailyBibleHeaderModel({
    @JsonKey(name: 'Bible_name') required String bibleName,
    @JsonKey(name: 'Bible_chapter') required String bibleChapter,
    @JsonKey(name: 'Base_de') required String date,
  }) = _DailyBibleHeaderModel;

  const DailyBibleHeaderModel._();

  factory DailyBibleHeaderModel.fromJson(Map<String, dynamic> json) =>
      _$DailyBibleHeaderModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return {
      'Bible_name': json['Bible_name']?.toString() ?? '',
      'Bible_chapter': json['Bible_chapter']?.toString() ?? '',
      'Base_de': json['Base_de']?.toString() ?? '',
    };
  }
}

/// Combined data model for daily Bible reading
@freezed
abstract class DailyBibleModel with _$DailyBibleModel {
  const factory DailyBibleModel({
    required String date,
    required String bibleName,
    required String bibleChapter,
    required List<DailyBibleVerseModel> verses,
  }) = _DailyBibleModel;

  const DailyBibleModel._();

  factory DailyBibleModel.fromJson(Map<String, dynamic> json) =>
      _$DailyBibleModelFromJson(json);

  /// Create from header and verses list
  factory DailyBibleModel.fromHeaderAndVerses({
    required DailyBibleHeaderModel header,
    required List<DailyBibleVerseModel> verses,
  }) {
    return DailyBibleModel(
      date: header.date,
      bibleName: header.bibleName,
      bibleChapter: header.bibleChapter,
      verses: verses,
    );
  }

  /// Convert to domain entity
  DailyBibleEntity toEntity() {
    return DailyBibleEntity(
      date: date,
      bibleName: bibleName,
      bibleChapter: bibleChapter,
      verses: verses.map((v) => v.toEntity()).toList(),
    );
  }

  /// Create from domain entity
  factory DailyBibleModel.fromEntity(DailyBibleEntity entity) {
    return DailyBibleModel(
      date: entity.date,
      bibleName: entity.bibleName,
      bibleChapter: entity.bibleChapter,
      verses: entity.verses
          .map((v) => DailyBibleVerseModel(
                verse: v.verse,
                content: v.content,
              ))
          .toList(),
    );
  }
}
