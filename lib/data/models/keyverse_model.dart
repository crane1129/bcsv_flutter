import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';

part 'keyverse_model.freezed.dart';
part 'keyverse_model.g.dart';

/// Data model for key verse with JSON serialization
@freezed
abstract class KeyVerseModel with _$KeyVerseModel {
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

  /// Normalize JSON to handle dynamic types.
  /// When the API returns a `description` field (e.g. "히브리서 11:13")
  /// instead of separate book/chapter/verse fields, parse it.
  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    String book = json['book']?.toString() ?? '';
    int chapter = _asInt(json['chapter']);
    int verseFrom = _asInt(json['verseFrom']);
    int verseEnd = _asInt(json['verseEnd']);

    if (book.isEmpty && json['description'] != null) {
      final parsed = _parseDescription(json['description'].toString());
      book = parsed['book'] as String;
      chapter = parsed['chapter'] as int;
      verseFrom = parsed['verseFrom'] as int;
      verseEnd = parsed['verseEnd'] as int;
    }

    return {
      'year': _asInt(json['year']),
      'title': json['title']?.toString() ?? '',
      'book': book,
      'chapter': chapter,
      'verseFrom': verseFrom,
      'verseEnd': verseEnd,
      'verse': json['verse']?.toString() ?? '',
    };
  }

  /// Parse "히브리서 11:13" or "요한복음 3:16-17" into components.
  static Map<String, dynamic> _parseDescription(String description) {
    final match = RegExp(r'^(.+)\s+(\d+):(\d+)(?:-(\d+))?$').firstMatch(description);
    if (match == null) {
      return {'book': description, 'chapter': 0, 'verseFrom': 0, 'verseEnd': 0};
    }
    final verseFrom = int.parse(match.group(3)!);
    return {
      'book': match.group(1)!.trim(),
      'chapter': int.parse(match.group(2)!),
      'verseFrom': verseFrom,
      'verseEnd': match.group(4) != null ? int.parse(match.group(4)!) : verseFrom,
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
