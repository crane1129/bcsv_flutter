// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_bible.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyBibleVerseEntity {
  String get verse => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Create a copy of DailyBibleVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBibleVerseEntityCopyWith<DailyBibleVerseEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBibleVerseEntityCopyWith<$Res> {
  factory $DailyBibleVerseEntityCopyWith(DailyBibleVerseEntity value,
          $Res Function(DailyBibleVerseEntity) then) =
      _$DailyBibleVerseEntityCopyWithImpl<$Res, DailyBibleVerseEntity>;
  @useResult
  $Res call({String verse, String content});
}

/// @nodoc
class _$DailyBibleVerseEntityCopyWithImpl<$Res,
        $Val extends DailyBibleVerseEntity>
    implements $DailyBibleVerseEntityCopyWith<$Res> {
  _$DailyBibleVerseEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBibleVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verse = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyBibleVerseEntityImplCopyWith<$Res>
    implements $DailyBibleVerseEntityCopyWith<$Res> {
  factory _$$DailyBibleVerseEntityImplCopyWith(
          _$DailyBibleVerseEntityImpl value,
          $Res Function(_$DailyBibleVerseEntityImpl) then) =
      __$$DailyBibleVerseEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String verse, String content});
}

/// @nodoc
class __$$DailyBibleVerseEntityImplCopyWithImpl<$Res>
    extends _$DailyBibleVerseEntityCopyWithImpl<$Res,
        _$DailyBibleVerseEntityImpl>
    implements _$$DailyBibleVerseEntityImplCopyWith<$Res> {
  __$$DailyBibleVerseEntityImplCopyWithImpl(_$DailyBibleVerseEntityImpl _value,
      $Res Function(_$DailyBibleVerseEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBibleVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verse = null,
    Object? content = null,
  }) {
    return _then(_$DailyBibleVerseEntityImpl(
      verse: null == verse
          ? _value.verse
          : verse // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DailyBibleVerseEntityImpl implements _DailyBibleVerseEntity {
  const _$DailyBibleVerseEntityImpl(
      {required this.verse, required this.content});

  @override
  final String verse;
  @override
  final String content;

  @override
  String toString() {
    return 'DailyBibleVerseEntity(verse: $verse, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBibleVerseEntityImpl &&
            (identical(other.verse, verse) || other.verse == verse) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verse, content);

  /// Create a copy of DailyBibleVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBibleVerseEntityImplCopyWith<_$DailyBibleVerseEntityImpl>
      get copyWith => __$$DailyBibleVerseEntityImplCopyWithImpl<
          _$DailyBibleVerseEntityImpl>(this, _$identity);
}

abstract class _DailyBibleVerseEntity implements DailyBibleVerseEntity {
  const factory _DailyBibleVerseEntity(
      {required final String verse,
      required final String content}) = _$DailyBibleVerseEntityImpl;

  @override
  String get verse;
  @override
  String get content;

  /// Create a copy of DailyBibleVerseEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBibleVerseEntityImplCopyWith<_$DailyBibleVerseEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DailyBibleEntity {
  String get date => throw _privateConstructorUsedError;
  String get bibleName => throw _privateConstructorUsedError;
  String get bibleChapter => throw _privateConstructorUsedError;
  List<DailyBibleVerseEntity> get verses => throw _privateConstructorUsedError;

  /// Create a copy of DailyBibleEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBibleEntityCopyWith<DailyBibleEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBibleEntityCopyWith<$Res> {
  factory $DailyBibleEntityCopyWith(
          DailyBibleEntity value, $Res Function(DailyBibleEntity) then) =
      _$DailyBibleEntityCopyWithImpl<$Res, DailyBibleEntity>;
  @useResult
  $Res call(
      {String date,
      String bibleName,
      String bibleChapter,
      List<DailyBibleVerseEntity> verses});
}

/// @nodoc
class _$DailyBibleEntityCopyWithImpl<$Res, $Val extends DailyBibleEntity>
    implements $DailyBibleEntityCopyWith<$Res> {
  _$DailyBibleEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBibleEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? bibleName = null,
    Object? bibleChapter = null,
    Object? verses = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bibleName: null == bibleName
          ? _value.bibleName
          : bibleName // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      verses: null == verses
          ? _value.verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<DailyBibleVerseEntity>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyBibleEntityImplCopyWith<$Res>
    implements $DailyBibleEntityCopyWith<$Res> {
  factory _$$DailyBibleEntityImplCopyWith(_$DailyBibleEntityImpl value,
          $Res Function(_$DailyBibleEntityImpl) then) =
      __$$DailyBibleEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String bibleName,
      String bibleChapter,
      List<DailyBibleVerseEntity> verses});
}

/// @nodoc
class __$$DailyBibleEntityImplCopyWithImpl<$Res>
    extends _$DailyBibleEntityCopyWithImpl<$Res, _$DailyBibleEntityImpl>
    implements _$$DailyBibleEntityImplCopyWith<$Res> {
  __$$DailyBibleEntityImplCopyWithImpl(_$DailyBibleEntityImpl _value,
      $Res Function(_$DailyBibleEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBibleEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? bibleName = null,
    Object? bibleChapter = null,
    Object? verses = null,
  }) {
    return _then(_$DailyBibleEntityImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      bibleName: null == bibleName
          ? _value.bibleName
          : bibleName // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      verses: null == verses
          ? _value._verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<DailyBibleVerseEntity>,
    ));
  }
}

/// @nodoc

class _$DailyBibleEntityImpl extends _DailyBibleEntity {
  const _$DailyBibleEntityImpl(
      {required this.date,
      required this.bibleName,
      required this.bibleChapter,
      required final List<DailyBibleVerseEntity> verses})
      : _verses = verses,
        super._();

  @override
  final String date;
  @override
  final String bibleName;
  @override
  final String bibleChapter;
  final List<DailyBibleVerseEntity> _verses;
  @override
  List<DailyBibleVerseEntity> get verses {
    if (_verses is EqualUnmodifiableListView) return _verses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verses);
  }

  @override
  String toString() {
    return 'DailyBibleEntity(date: $date, bibleName: $bibleName, bibleChapter: $bibleChapter, verses: $verses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBibleEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.bibleName, bibleName) ||
                other.bibleName == bibleName) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            const DeepCollectionEquality().equals(other._verses, _verses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, bibleName, bibleChapter,
      const DeepCollectionEquality().hash(_verses));

  /// Create a copy of DailyBibleEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBibleEntityImplCopyWith<_$DailyBibleEntityImpl> get copyWith =>
      __$$DailyBibleEntityImplCopyWithImpl<_$DailyBibleEntityImpl>(
          this, _$identity);
}

abstract class _DailyBibleEntity extends DailyBibleEntity {
  const factory _DailyBibleEntity(
          {required final String date,
          required final String bibleName,
          required final String bibleChapter,
          required final List<DailyBibleVerseEntity> verses}) =
      _$DailyBibleEntityImpl;
  const _DailyBibleEntity._() : super._();

  @override
  String get date;
  @override
  String get bibleName;
  @override
  String get bibleChapter;
  @override
  List<DailyBibleVerseEntity> get verses;

  /// Create a copy of DailyBibleEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBibleEntityImplCopyWith<_$DailyBibleEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
