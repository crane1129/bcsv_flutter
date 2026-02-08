// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sunday_bible_text_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BibleReferenceModel _$BibleReferenceModelFromJson(Map<String, dynamic> json) {
  return _BibleReferenceModel.fromJson(json);
}

/// @nodoc
mixin _$BibleReferenceModel {
  @JsonKey(name: 'Text_Class')
  String get textClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_text')
  String get bibleText => throw _privateConstructorUsedError;

  /// Serializes this BibleReferenceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BibleReferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BibleReferenceModelCopyWith<BibleReferenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BibleReferenceModelCopyWith<$Res> {
  factory $BibleReferenceModelCopyWith(
          BibleReferenceModel value, $Res Function(BibleReferenceModel) then) =
      _$BibleReferenceModelCopyWithImpl<$Res, BibleReferenceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Text_Class') String textClass,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText});
}

/// @nodoc
class _$BibleReferenceModelCopyWithImpl<$Res, $Val extends BibleReferenceModel>
    implements $BibleReferenceModelCopyWith<$Res> {
  _$BibleReferenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BibleReferenceModel
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
abstract class _$$BibleReferenceModelImplCopyWith<$Res>
    implements $BibleReferenceModelCopyWith<$Res> {
  factory _$$BibleReferenceModelImplCopyWith(_$BibleReferenceModelImpl value,
          $Res Function(_$BibleReferenceModelImpl) then) =
      __$$BibleReferenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Text_Class') String textClass,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText});
}

/// @nodoc
class __$$BibleReferenceModelImplCopyWithImpl<$Res>
    extends _$BibleReferenceModelCopyWithImpl<$Res, _$BibleReferenceModelImpl>
    implements _$$BibleReferenceModelImplCopyWith<$Res> {
  __$$BibleReferenceModelImplCopyWithImpl(_$BibleReferenceModelImpl _value,
      $Res Function(_$BibleReferenceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BibleReferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_$BibleReferenceModelImpl(
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
@JsonSerializable()
class _$BibleReferenceModelImpl extends _BibleReferenceModel {
  const _$BibleReferenceModelImpl(
      {@JsonKey(name: 'Text_Class') required this.textClass,
      @JsonKey(name: 'Bible_chapter') required this.bibleChapter,
      @JsonKey(name: 'Bible_text') required this.bibleText})
      : super._();

  factory _$BibleReferenceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BibleReferenceModelImplFromJson(json);

  @override
  @JsonKey(name: 'Text_Class')
  final String textClass;
  @override
  @JsonKey(name: 'Bible_chapter')
  final String bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  final String bibleText;

  @override
  String toString() {
    return 'BibleReferenceModel(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BibleReferenceModelImpl &&
            (identical(other.textClass, textClass) ||
                other.textClass == textClass) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.bibleText, bibleText) ||
                other.bibleText == bibleText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, textClass, bibleChapter, bibleText);

  /// Create a copy of BibleReferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BibleReferenceModelImplCopyWith<_$BibleReferenceModelImpl> get copyWith =>
      __$$BibleReferenceModelImplCopyWithImpl<_$BibleReferenceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BibleReferenceModelImplToJson(
      this,
    );
  }
}

abstract class _BibleReferenceModel extends BibleReferenceModel {
  const factory _BibleReferenceModel(
          {@JsonKey(name: 'Text_Class') required final String textClass,
          @JsonKey(name: 'Bible_chapter') required final String bibleChapter,
          @JsonKey(name: 'Bible_text') required final String bibleText}) =
      _$BibleReferenceModelImpl;
  const _BibleReferenceModel._() : super._();

  factory _BibleReferenceModel.fromJson(Map<String, dynamic> json) =
      _$BibleReferenceModelImpl.fromJson;

  @override
  @JsonKey(name: 'Text_Class')
  String get textClass;
  @override
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  String get bibleText;

  /// Create a copy of BibleReferenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BibleReferenceModelImplCopyWith<_$BibleReferenceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReviewQuestionModel _$ReviewQuestionModelFromJson(Map<String, dynamic> json) {
  return _ReviewQuestionModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewQuestionModel {
  @JsonKey(name: 'Text_Class')
  String get textClass => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_text')
  String get bibleText => throw _privateConstructorUsedError;

  /// Serializes this ReviewQuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewQuestionModelCopyWith<ReviewQuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewQuestionModelCopyWith<$Res> {
  factory $ReviewQuestionModelCopyWith(
          ReviewQuestionModel value, $Res Function(ReviewQuestionModel) then) =
      _$ReviewQuestionModelCopyWithImpl<$Res, ReviewQuestionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Text_Class') String textClass,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText});
}

/// @nodoc
class _$ReviewQuestionModelCopyWithImpl<$Res, $Val extends ReviewQuestionModel>
    implements $ReviewQuestionModelCopyWith<$Res> {
  _$ReviewQuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewQuestionModel
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
abstract class _$$ReviewQuestionModelImplCopyWith<$Res>
    implements $ReviewQuestionModelCopyWith<$Res> {
  factory _$$ReviewQuestionModelImplCopyWith(_$ReviewQuestionModelImpl value,
          $Res Function(_$ReviewQuestionModelImpl) then) =
      __$$ReviewQuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Text_Class') String textClass,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText});
}

/// @nodoc
class __$$ReviewQuestionModelImplCopyWithImpl<$Res>
    extends _$ReviewQuestionModelCopyWithImpl<$Res, _$ReviewQuestionModelImpl>
    implements _$$ReviewQuestionModelImplCopyWith<$Res> {
  __$$ReviewQuestionModelImplCopyWithImpl(_$ReviewQuestionModelImpl _value,
      $Res Function(_$ReviewQuestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textClass = null,
    Object? bibleChapter = null,
    Object? bibleText = null,
  }) {
    return _then(_$ReviewQuestionModelImpl(
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
@JsonSerializable()
class _$ReviewQuestionModelImpl extends _ReviewQuestionModel {
  const _$ReviewQuestionModelImpl(
      {@JsonKey(name: 'Text_Class') required this.textClass,
      @JsonKey(name: 'Bible_chapter') required this.bibleChapter,
      @JsonKey(name: 'Bible_text') required this.bibleText})
      : super._();

  factory _$ReviewQuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewQuestionModelImplFromJson(json);

  @override
  @JsonKey(name: 'Text_Class')
  final String textClass;
  @override
  @JsonKey(name: 'Bible_chapter')
  final String bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  final String bibleText;

  @override
  String toString() {
    return 'ReviewQuestionModel(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewQuestionModelImpl &&
            (identical(other.textClass, textClass) ||
                other.textClass == textClass) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.bibleText, bibleText) ||
                other.bibleText == bibleText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, textClass, bibleChapter, bibleText);

  /// Create a copy of ReviewQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewQuestionModelImplCopyWith<_$ReviewQuestionModelImpl> get copyWith =>
      __$$ReviewQuestionModelImplCopyWithImpl<_$ReviewQuestionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewQuestionModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewQuestionModel extends ReviewQuestionModel {
  const factory _ReviewQuestionModel(
          {@JsonKey(name: 'Text_Class') required final String textClass,
          @JsonKey(name: 'Bible_chapter') required final String bibleChapter,
          @JsonKey(name: 'Bible_text') required final String bibleText}) =
      _$ReviewQuestionModelImpl;
  const _ReviewQuestionModel._() : super._();

  factory _ReviewQuestionModel.fromJson(Map<String, dynamic> json) =
      _$ReviewQuestionModelImpl.fromJson;

  @override
  @JsonKey(name: 'Text_Class')
  String get textClass;
  @override
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  String get bibleText;

  /// Create a copy of ReviewQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewQuestionModelImplCopyWith<_$ReviewQuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SundayBibleTextModel _$SundayBibleTextModelFromJson(Map<String, dynamic> json) {
  return _SundayBibleTextModel.fromJson(json);
}

/// @nodoc
mixin _$SundayBibleTextModel {
  @JsonKey(name: 'Date')
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'Title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_text')
  String get bibleText => throw _privateConstructorUsedError;
  @JsonKey(name: 'File_url')
  String get fileUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'References')
  List<BibleReferenceModel> get references =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'ReviewQuestion')
  ReviewQuestionModel? get reviewQuestion => throw _privateConstructorUsedError;

  /// Serializes this SundayBibleTextModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SundayBibleTextModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SundayBibleTextModelCopyWith<SundayBibleTextModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SundayBibleTextModelCopyWith<$Res> {
  factory $SundayBibleTextModelCopyWith(SundayBibleTextModel value,
          $Res Function(SundayBibleTextModel) then) =
      _$SundayBibleTextModelCopyWithImpl<$Res, SundayBibleTextModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Date') String date,
      @JsonKey(name: 'Title') String title,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText,
      @JsonKey(name: 'File_url') String fileUrl,
      @JsonKey(name: 'References') List<BibleReferenceModel> references,
      @JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? reviewQuestion});

  $ReviewQuestionModelCopyWith<$Res>? get reviewQuestion;
}

/// @nodoc
class _$SundayBibleTextModelCopyWithImpl<$Res,
        $Val extends SundayBibleTextModel>
    implements $SundayBibleTextModelCopyWith<$Res> {
  _$SundayBibleTextModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SundayBibleTextModel
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
              as List<BibleReferenceModel>,
      reviewQuestion: freezed == reviewQuestion
          ? _value.reviewQuestion
          : reviewQuestion // ignore: cast_nullable_to_non_nullable
              as ReviewQuestionModel?,
    ) as $Val);
  }

  /// Create a copy of SundayBibleTextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewQuestionModelCopyWith<$Res>? get reviewQuestion {
    if (_value.reviewQuestion == null) {
      return null;
    }

    return $ReviewQuestionModelCopyWith<$Res>(_value.reviewQuestion!, (value) {
      return _then(_value.copyWith(reviewQuestion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SundayBibleTextModelImplCopyWith<$Res>
    implements $SundayBibleTextModelCopyWith<$Res> {
  factory _$$SundayBibleTextModelImplCopyWith(_$SundayBibleTextModelImpl value,
          $Res Function(_$SundayBibleTextModelImpl) then) =
      __$$SundayBibleTextModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Date') String date,
      @JsonKey(name: 'Title') String title,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Bible_text') String bibleText,
      @JsonKey(name: 'File_url') String fileUrl,
      @JsonKey(name: 'References') List<BibleReferenceModel> references,
      @JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? reviewQuestion});

  @override
  $ReviewQuestionModelCopyWith<$Res>? get reviewQuestion;
}

/// @nodoc
class __$$SundayBibleTextModelImplCopyWithImpl<$Res>
    extends _$SundayBibleTextModelCopyWithImpl<$Res, _$SundayBibleTextModelImpl>
    implements _$$SundayBibleTextModelImplCopyWith<$Res> {
  __$$SundayBibleTextModelImplCopyWithImpl(_$SundayBibleTextModelImpl _value,
      $Res Function(_$SundayBibleTextModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SundayBibleTextModel
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
    return _then(_$SundayBibleTextModelImpl(
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
              as List<BibleReferenceModel>,
      reviewQuestion: freezed == reviewQuestion
          ? _value.reviewQuestion
          : reviewQuestion // ignore: cast_nullable_to_non_nullable
              as ReviewQuestionModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SundayBibleTextModelImpl extends _SundayBibleTextModel {
  const _$SundayBibleTextModelImpl(
      {@JsonKey(name: 'Date') required this.date,
      @JsonKey(name: 'Title') required this.title,
      @JsonKey(name: 'Bible_chapter') required this.bibleChapter,
      @JsonKey(name: 'Bible_text') required this.bibleText,
      @JsonKey(name: 'File_url') this.fileUrl = '',
      @JsonKey(name: 'References')
      final List<BibleReferenceModel> references = const [],
      @JsonKey(name: 'ReviewQuestion') this.reviewQuestion})
      : _references = references,
        super._();

  factory _$SundayBibleTextModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SundayBibleTextModelImplFromJson(json);

  @override
  @JsonKey(name: 'Date')
  final String date;
  @override
  @JsonKey(name: 'Title')
  final String title;
  @override
  @JsonKey(name: 'Bible_chapter')
  final String bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  final String bibleText;
  @override
  @JsonKey(name: 'File_url')
  final String fileUrl;
  final List<BibleReferenceModel> _references;
  @override
  @JsonKey(name: 'References')
  List<BibleReferenceModel> get references {
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  @override
  @JsonKey(name: 'ReviewQuestion')
  final ReviewQuestionModel? reviewQuestion;

  @override
  String toString() {
    return 'SundayBibleTextModel(date: $date, title: $title, bibleChapter: $bibleChapter, bibleText: $bibleText, fileUrl: $fileUrl, references: $references, reviewQuestion: $reviewQuestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SundayBibleTextModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of SundayBibleTextModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SundayBibleTextModelImplCopyWith<_$SundayBibleTextModelImpl>
      get copyWith =>
          __$$SundayBibleTextModelImplCopyWithImpl<_$SundayBibleTextModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SundayBibleTextModelImplToJson(
      this,
    );
  }
}

abstract class _SundayBibleTextModel extends SundayBibleTextModel {
  const factory _SundayBibleTextModel(
      {@JsonKey(name: 'Date') required final String date,
      @JsonKey(name: 'Title') required final String title,
      @JsonKey(name: 'Bible_chapter') required final String bibleChapter,
      @JsonKey(name: 'Bible_text') required final String bibleText,
      @JsonKey(name: 'File_url') final String fileUrl,
      @JsonKey(name: 'References') final List<BibleReferenceModel> references,
      @JsonKey(name: 'ReviewQuestion')
      final ReviewQuestionModel? reviewQuestion}) = _$SundayBibleTextModelImpl;
  const _SundayBibleTextModel._() : super._();

  factory _SundayBibleTextModel.fromJson(Map<String, dynamic> json) =
      _$SundayBibleTextModelImpl.fromJson;

  @override
  @JsonKey(name: 'Date')
  String get date;
  @override
  @JsonKey(name: 'Title')
  String get title;
  @override
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter;
  @override
  @JsonKey(name: 'Bible_text')
  String get bibleText;
  @override
  @JsonKey(name: 'File_url')
  String get fileUrl;
  @override
  @JsonKey(name: 'References')
  List<BibleReferenceModel> get references;
  @override
  @JsonKey(name: 'ReviewQuestion')
  ReviewQuestionModel? get reviewQuestion;

  /// Create a copy of SundayBibleTextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SundayBibleTextModelImplCopyWith<_$SundayBibleTextModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
