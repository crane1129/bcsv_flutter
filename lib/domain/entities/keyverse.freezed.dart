// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyverse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KeyVerseEntity {
  int get year => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get book => throw _privateConstructorUsedError;
  int get chapter => throw _privateConstructorUsedError;
  int get verseFrom => throw _privateConstructorUsedError;
  int get verseEnd => throw _privateConstructorUsedError;
  String get verse => throw _privateConstructorUsedError;

  /// Create a copy of KeyVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyVerseEntityCopyWith<KeyVerseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyVerseEntityCopyWith<$Res> {
  factory $KeyVerseEntityCopyWith(
          KeyVerseEntity value, $Res Function(KeyVerseEntity) then) =
      _$KeyVerseEntityCopyWithImpl<$Res, KeyVerseEntity>;
  @useResult
  $Res call(
      {int year,
      String title,
      String book,
      int chapter,
      int verseFrom,
      int verseEnd,
      String verse});
}

/// @nodoc
class _$KeyVerseEntityCopyWithImpl<$Res, $Val extends KeyVerseEntity>
    implements $KeyVerseEntityCopyWith<$Res> {
  _$KeyVerseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? title = null,
    Object? book = null,
    Object? chapter = null,
    Object? verseFrom = null,
    Object? verseEnd = null,
    Object? verse = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as int,
      verseFrom: null == verseFrom
          ? _value.verseFrom
          : verseFrom // ignore: cast_nullable_to_non_nullable
              as int,
      verseEnd: null == verseEnd
          ? _value.verseEnd
          : verseEnd // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyVerseEntityImplCopyWith<$Res>
    implements $KeyVerseEntityCopyWith<$Res> {
  factory _$$KeyVerseEntityImplCopyWith(_$KeyVerseEntityImpl value,
          $Res Function(_$KeyVerseEntityImpl) then) =
      __$$KeyVerseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int year,
      String title,
      String book,
      int chapter,
      int verseFrom,
      int verseEnd,
      String verse});
}

/// @nodoc
class __$$KeyVerseEntityImplCopyWithImpl<$Res>
    extends _$KeyVerseEntityCopyWithImpl<$Res, _$KeyVerseEntityImpl>
    implements _$$KeyVerseEntityImplCopyWith<$Res> {
  __$$KeyVerseEntityImplCopyWithImpl(
      _$KeyVerseEntityImpl _value, $Res Function(_$KeyVerseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? title = null,
    Object? book = null,
    Object? chapter = null,
    Object? verseFrom = null,
    Object? verseEnd = null,
    Object? verse = null,
  }) {
    return _then(_$KeyVerseEntityImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      book: null == book
          ? _value.book
          : book // ignore: cast_nullable_to_non_nullable
              as String,
      chapter: null == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as int,
      verseFrom: null == verseFrom
          ? _value.verseFrom
          : verseFrom // ignore: cast_nullable_to_non_nullable
              as int,
      verseEnd: null == verseEnd
          ? _value.verseEnd
          : verseEnd // ignore: cast_nullable_to_non_nullable
              as int,
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$KeyVerseEntityImpl extends _KeyVerseEntity {
  const _$KeyVerseEntityImpl(
      {required this.year,
      required this.title,
      required this.book,
      required this.chapter,
      required this.verseFrom,
      required this.verseEnd,
      required this.verse})
      : super._();

  @override
  final int year;
  @override
  final String title;
  @override
  final String book;
  @override
  final int chapter;
  @override
  final int verseFrom;
  @override
  final int verseEnd;
  @override
  final String verse;

  @override
  String toString() {
    return 'KeyVerseEntity(year: $year, title: $title, book: $book, chapter: $chapter, verseFrom: $verseFrom, verseEnd: $verseEnd, verse: $verse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyVerseEntityImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.book, book) || other.book == book) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.verseFrom, verseFrom) ||
                other.verseFrom == verseFrom) &&
            (identical(other.verseEnd, verseEnd) ||
                other.verseEnd == verseEnd) &&
            (identical(other.verse, verse) || other.verse == verse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, year, title, book, chapter, verseFrom, verseEnd, verse);

  /// Create a copy of KeyVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyVerseEntityImplCopyWith<_$KeyVerseEntityImpl> get copyWith =>
      __$$KeyVerseEntityImplCopyWithImpl<_$KeyVerseEntityImpl>(
          this, _$identity);
}

abstract class _KeyVerseEntity extends KeyVerseEntity {
  const factory _KeyVerseEntity(
      {required final int year,
      required final String title,
      required final String book,
      required final int chapter,
      required final int verseFrom,
      required final int verseEnd,
      required final String verse}) = _$KeyVerseEntityImpl;
  const _KeyVerseEntity._() : super._();

  @override
  int get year;
  @override
  String get title;
  @override
  String get book;
  @override
  int get chapter;
  @override
  int get verseFrom;
  @override
  int get verseEnd;
  @override
  String get verse;

  /// Create a copy of KeyVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyVerseEntityImplCopyWith<_$KeyVerseEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
