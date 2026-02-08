import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';

part 'keyverse_model.freezed.dart';
part 'keyverse_model.g.dart';

/// Data model for key verse with JSON serialization
@freezed
class KeyVerseModel with _$KeyVerseModel {
  const factory KeyVerseModel({
    @JsonKey(name: 'year') required int year,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'book') required String book,
    @JsonKey(name: 'chapter') required int chapter,
    @JsonKey(name: 'verseFrom') required int verseFrom,
    @JsonKey(name: 'verseEnd') required int verseEnd,
    @JsonKey(name: 'verse') required String verse,
  }) = _KeyVerseModel;

  const KeyVerseModel._();

  factory KeyVerseModel.fromJson(Map<String, dynamic> json) =>
      _$KeyVerseModelFromJson(_normalizeJson(json));

  /// Normalize JSON to handle dynamic types
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return {
      'year': _asInt(json['year']),
      'title': json['title']?.toString() ?? '',
      'book': json['book']?.toString() ?? '',
      'chapter': _asInt(json['chapter']),
      'verseFrom': _asInt(json['verseFrom']),
      'verseEnd': _asInt(json['verseEnd']),
      'verse': json['verse']?.toString() ?? '',
    };
  }

  static int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }

  /// Convert to domain entity
  KeyVerseEntity toEntity() {
    return KeyVerseEntity(
      year: year,
      title: title,
      book: book,
      chapter: chapter,
      verseFrom: verseFrom,
      verseEnd: verseEnd,
      verse: verse,
    );
  }

  /// Create from domain entity
  factory KeyVerseModel.fromEntity(KeyVerseEntity entity) {
    return KeyVerseModel(
      year: entity.year,
      title: entity.title,
      book: entity.book,
      chapter: entity.chapter,
      verseFrom: entity.verseFrom,
      verseEnd: entity.verseEnd,
      verse: entity.verse,
    );
  }
}
