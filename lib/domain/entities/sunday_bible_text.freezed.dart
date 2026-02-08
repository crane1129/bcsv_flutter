// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sunday_bible_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BibleReferenceEntity {
  String get textClass => throw _privateConstructorUsedError;
  String get bibleChapter => throw _privateConstructorUsedError;
  String get bibleText => throw _privateConstructorUsedError;

  /// Create a copy of BibleReferenceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BibleReferenceEntityCopyWith<BibleReferenceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleReferenceEntityCopyWith<$Res> {
  factory $BibleReferenceEntityCopyWith(BibleReferenceEntity value,
          $Res Function(BibleReferenceEntity) then) =
      _$BibleReferenceEntityCopyWithImpl<$Res, BibleReferenceEntity>;
  @useResult
  $Res call({String textClass, String bibleChapter, String bibleText});
}

/// @nodoc
class _$BibleReferenceEntityCopyWithImpl<$Res,
        $Val extends BibleReferenceEntity>
    implements $BibleReferenceEntityCopyWith<$Res> {
  _$BibleReferenceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BibleReferenceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_value.copyWith(
      textClass: null == textClass
          ? _value.textClass
          : textClass // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BibleReferenceEntityImplCopyWith<$Res>
    implements $BibleReferenceEntityCopyWith<$Res> {
  factory _$$BibleReferenceEntityImplCopyWith(_$BibleReferenceEntityImpl value,
          $Res Function(_$BibleReferenceEntityImpl) then) =
      __$$BibleReferenceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String textClass, String bibleChapter, String bibleText});
}

/// @nodoc
class __$$BibleReferenceEntityImplCopyWithImpl<$Res>
    extends _$BibleReferenceEntityCopyWithImpl<$Res, _$BibleReferenceEntityImpl>
    implements _$$BibleReferenceEntityImplCopyWith<$Res> {
  __$$BibleReferenceEntityImplCopyWithImpl(_$BibleReferenceEntityImpl _value,
      $Res Function(_$BibleReferenceEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of BibleReferenceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_$BibleReferenceEntityImpl(
      textClass: null == textClass
          ? _value.textClass
          : textClass // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BibleReferenceEntityImpl implements _BibleReferenceEntity {
  const _$BibleReferenceEntityImpl(
      {required this.textClass,
      required this.bibleChapter,
      required this.bibleText});

  @override
  final String textClass;
  @override
  final String bibleChapter;
  @override
  final String bibleText;

  @override
  String toString() {
    return 'BibleReferenceEntity(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleReferenceEntityImpl &&
            (identical(other.textClass, textClass) ||
                other.textClass == textClass) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.bibleText, bibleText) ||
                other.bibleText == bibleText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textClass, bibleChapter, bibleText);

  /// Create a copy of BibleReferenceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleReferenceEntityImplCopyWith<_$BibleReferenceEntityImpl>
      get copyWith =>
          __$$BibleReferenceEntityImplCopyWithImpl<_$BibleReferenceEntityImpl>(
              this, _$identity);
}

abstract class _BibleReferenceEntity implements BibleReferenceEntity {
  const factory _BibleReferenceEntity(
      {required final String textClass,
      required final String bibleChapter,
      required final String bibleText}) = _$BibleReferenceEntityImpl;

  @override
  String get textClass;
  @override
  String get bibleChapter;
  @override
  String get bibleText;

  /// Create a copy of BibleReferenceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BibleReferenceEntityImplCopyWith<_$BibleReferenceEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReviewQuestionEntity {
  String get textClass => throw _privateConstructorUsedError;
  String get bibleChapter => throw _privateConstructorUsedError;
  String get bibleText => throw _privateConstructorUsedError;

  /// Create a copy of ReviewQuestionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewQuestionEntityCopyWith<ReviewQuestionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewQuestionEntityCopyWith<$Res> {
  factory $ReviewQuestionEntityCopyWith(ReviewQuestionEntity value,
          $Res Function(ReviewQuestionEntity) then) =
      _$ReviewQuestionEntityCopyWithImpl<$Res, ReviewQuestionEntity>;
  @useResult
  $Res call({String textClass, String bibleChapter, String bibleText});
}

/// @nodoc
class _$ReviewQuestionEntityCopyWithImpl<$Res,
        $Val extends ReviewQuestionEntity>
    implements $ReviewQuestionEntityCopyWith<$Res> {
  _$ReviewQuestionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewQuestionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_value.copyWith(
      textClass: null == textClass
          ? _value.textClass
          : textClass // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewQuestionEntityImplCopyWith<$Res>
    implements $ReviewQuestionEntityCopyWith<$Res> {
  factory _$$ReviewQuestionEntityImplCopyWith(_$ReviewQuestionEntityImpl value,
          $Res Function(_$ReviewQuestionEntityImpl) then) =
      __$$ReviewQuestionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String textClass, String bibleChapter, String bibleText});
}

/// @nodoc
class __$$ReviewQuestionEntityImplCopyWithImpl<$Res>
    extends _$ReviewQuestionEntityCopyWithImpl<$Res, _$ReviewQuestionEntityImpl>
    implements _$$ReviewQuestionEntityImplCopyWith<$Res> {
  __$$ReviewQuestionEntityImplCopyWithImpl(_$ReviewQuestionEntityImpl _value,
      $Res Function(_$ReviewQuestionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewQuestionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_$ReviewQuestionEntityImpl(
      textClass: null == textClass
          ? _value.textClass
          : textClass // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReviewQuestionEntityImpl implements _ReviewQuestionEntity {
  const _$ReviewQuestionEntityImpl(
      {required this.textClass,
      required this.bibleChapter,
      required this.bibleText});

  @override
  final String textClass;
  @override
  final String bibleChapter;
  @override
  final String bibleText;

  @override
  String toString() {
    return 'ReviewQuestionEntity(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewQuestionEntityImpl &&
            (identical(other.textClass, textClass) ||
                other.textClass == textClass) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.bibleText, bibleText) ||
                other.bibleText == bibleText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textClass, bibleChapter, bibleText);

  /// Create a copy of ReviewQuestionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewQuestionEntityImplCopyWith<_$ReviewQuestionEntityImpl>
      get copyWith =>
          __$$ReviewQuestionEntityImplCopyWithImpl<_$ReviewQuestionEntityImpl>(
              this, _$identity);
}

abstract class _ReviewQuestionEntity implements ReviewQuestionEntity {
  const factory _ReviewQuestionEntity(
      {required final String textClass,
      required final String bibleChapter,
      required final String bibleText}) = _$ReviewQuestionEntityImpl;

  @override
  String get textClass;
  @override
  String get bibleChapter;
  @override
  String get bibleText;

  /// Create a copy of ReviewQuestionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewQuestionEntityImplCopyWith<_$ReviewQuestionEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SundayBibleTextEntity {
  String get date => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get bibleChapter => throw _privateConstructorUsedError;
  String get bibleText => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  List<BibleReferenceEntity> get references =>
      throw _privateConstructorUsedError;
  ReviewQuestionEntity? get reviewQuestion =>
      throw _privateConstructorUsedError;

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SundayBibleTextEntityCopyWith<SundayBibleTextEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SundayBibleTextEntityCopyWith<$Res> {
  factory $SundayBibleTextEntityCopyWith(SundayBibleTextEntity value,
          $Res Function(SundayBibleTextEntity) then) =
      _$SundayBibleTextEntityCopyWithImpl<$Res, SundayBibleTextEntity>;
  @useResult
  $Res call(
      {String date,
      String title,
      String bibleChapter,
      String bibleText,
      String fileUrl,
      List<BibleReferenceEntity> references,
      ReviewQuestionEntity? reviewQuestion});

  $ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion;
}

/// @nodoc
class _$SundayBibleTextEntityCopyWithImpl<$Res,
        $Val extends SundayBibleTextEntity>
    implements $SundayBibleTextEntityCopyWith<$Res> {
  _$SundayBibleTextEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
    Object? fileUrl = null,
    Object? references = null,
    Object? reviewQuestion = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as List<BibleReferenceEntity>,
      reviewQuestion: freezed == reviewQuestion
          ? _value.reviewQuestion
          : reviewQuestion // ignore: cast_nullable_to_non_nullable
              as ReviewQuestionEntity?,
    ) as $Val);
  }

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion {
    if (_value.reviewQuestion == null) {
      return null;
    }

    return $ReviewQuestionEntityCopyWith<$Res>(_value.reviewQuestion!, (value) {
      return _then(_value.copyWith(reviewQuestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SundayBibleTextEntityImplCopyWith<$Res>
    implements $SundayBibleTextEntityCopyWith<$Res> {
  factory _$$SundayBibleTextEntityImplCopyWith(
          _$SundayBibleTextEntityImpl value,
          $Res Function(_$SundayBibleTextEntityImpl) then) =
      __$$SundayBibleTextEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String title,
      String bibleChapter,
      String bibleText,
      String fileUrl,
      List<BibleReferenceEntity> references,
      ReviewQuestionEntity? reviewQuestion});

  @override
  $ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion;
}

/// @nodoc
class __$$SundayBibleTextEntityImplCopyWithImpl<$Res>
    extends _$SundayBibleTextEntityCopyWithImpl<$Res,
        _$SundayBibleTextEntityImpl>
    implements _$$SundayBibleTextEntityImplCopyWith<$Res> {
  __$$SundayBibleTextEntityImplCopyWithImpl(_$SundayBibleTextEntityImpl _value,
      $Res Function(_$SundayBibleTextEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? title = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
    Object? fileUrl = null,
    Object? references = null,
    Object? reviewQuestion = freezed,
  }) {
    return _then(_$SundayBibleTextEntityImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      bibleText: null == bibleText
          ? _value.bibleText
          : bibleText // ignore: cast_nullable_to_non_nullable
              as String,
      fileUrl: null == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String,
      references: null == references
          ? _value._references
          : references // ignore: cast_nullable_to_non_nullable
              as List<BibleReferenceEntity>,
      reviewQuestion: freezed == reviewQuestion
          ? _value.reviewQuestion
          : reviewQuestion // ignore: cast_nullable_to_non_nullable
              as ReviewQuestionEntity?,
    ));
  }
}

/// @nodoc

class _$SundayBibleTextEntityImpl extends _SundayBibleTextEntity {
  const _$SundayBibleTextEntityImpl(
      {required this.date,
      required this.title,
      required this.bibleChapter,
      required this.bibleText,
      this.fileUrl = '',
      final List<BibleReferenceEntity> references = const [],
      this.reviewQuestion})
      : _references = references,
        super._();

  @override
  final String date;
  @override
  final String title;
  @override
  final String bibleChapter;
  @override
  final String bibleText;
  @override
  @JsonKey()
  final String fileUrl;
  final List<BibleReferenceEntity> _references;
  @override
  @JsonKey()
  List<BibleReferenceEntity> get references {
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  @override
  final ReviewQuestionEntity? reviewQuestion;

  @override
  String toString() {
    return 'SundayBibleTextEntity(date: $date, title: $title, bibleChapter: $bibleChapter, bibleText: $bibleText, fileUrl: $fileUrl, references: $references, reviewQuestion: $reviewQuestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SundayBibleTextEntityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.bibleText, bibleText) ||
                other.bibleText == bibleText) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            const DeepCollectionEquality()
                .equals(other._references, _references) &&
            (identical(other.reviewQuestion, reviewQuestion) ||
                other.reviewQuestion == reviewQuestion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      title,
      bibleChapter,
      bibleText,
      fileUrl,
      const DeepCollectionEquality().hash(_references),
      reviewQuestion);

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SundayBibleTextEntityImplCopyWith<_$SundayBibleTextEntityImpl>
      get copyWith => __$$SundayBibleTextEntityImplCopyWithImpl<
          _$SundayBibleTextEntityImpl>(this, _$identity);
}

abstract class _SundayBibleTextEntity extends SundayBibleTextEntity {
  const factory _SundayBibleTextEntity(
          {required final String date,
          required final String title,
          required final String bibleChapter,
          required final String bibleText,
          final String fileUrl,
          final List<BibleReferenceEntity> references,
          final ReviewQuestionEntity? reviewQuestion}) =
      _$SundayBibleTextEntityImpl;
  const _SundayBibleTextEntity._() : super._();

  @override
  String get date;
  @override
  String get title;
  @override
  String get bibleChapter;
  @override
  String get bibleText;
  @override
  String get fileUrl;
  @override
  List<BibleReferenceEntity> get references;
  @override
  ReviewQuestionEntity? get reviewQuestion;

  /// Create a copy of SundayBibleTextEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SundayBibleTextEntityImplCopyWith<_$SundayBibleTextEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
