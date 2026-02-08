// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_bible_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyBibleVerseModel _$DailyBibleVerseModelFromJson(Map<String, dynamic> json) {
  return _DailyBibleVerseModel.fromJson(json);
}

/// @nodoc
mixin _$DailyBibleVerseModel {
  @JsonKey(name: 'Verse')
  String get verse => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_Cn')
  String get content => throw _privateConstructorUsedError;

  /// Serializes this DailyBibleVerseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyBibleVerseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBibleVerseModelCopyWith<DailyBibleVerseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBibleVerseModelCopyWith<$Res> {
  factory $DailyBibleVerseModelCopyWith(DailyBibleVerseModel value,
          $Res Function(DailyBibleVerseModel) then) =
      _$DailyBibleVerseModelCopyWithImpl<$Res, DailyBibleVerseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Verse') String verse,
      @JsonKey(name: 'Bible_Cn') String content});
}

/// @nodoc
class _$DailyBibleVerseModelCopyWithImpl<$Res,
        $Val extends DailyBibleVerseModel>
    implements $DailyBibleVerseModelCopyWith<$Res> {
  _$DailyBibleVerseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBibleVerseModel
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
abstract class _$$DailyBibleVerseModelImplCopyWith<$Res>
    implements $DailyBibleVerseModelCopyWith<$Res> {
  factory _$$DailyBibleVerseModelImplCopyWith(_$DailyBibleVerseModelImpl value,
          $Res Function(_$DailyBibleVerseModelImpl) then) =
      __$$DailyBibleVerseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Verse') String verse,
      @JsonKey(name: 'Bible_Cn') String content});
}

/// @nodoc
class __$$DailyBibleVerseModelImplCopyWithImpl<$Res>
    extends _$DailyBibleVerseModelCopyWithImpl<$Res, _$DailyBibleVerseModelImpl>
    implements _$$DailyBibleVerseModelImplCopyWith<$Res> {
  __$$DailyBibleVerseModelImplCopyWithImpl(_$DailyBibleVerseModelImpl _value,
      $Res Function(_$DailyBibleVerseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBibleVerseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verse = null,
    Object? content = null,
  }) {
    return _then(_$DailyBibleVerseModelImpl(
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
@JsonSerializable()
class _$DailyBibleVerseModelImpl extends _DailyBibleVerseModel {
  const _$DailyBibleVerseModelImpl(
      {@JsonKey(name: 'Verse') required this.verse,
      @JsonKey(name: 'Bible_Cn') required this.content})
      : super._();

  factory _$DailyBibleVerseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyBibleVerseModelImplFromJson(json);

  @override
  @JsonKey(name: 'Verse')
  final String verse;
  @override
  @JsonKey(name: 'Bible_Cn')
  final String content;

  @override
  String toString() {
    return 'DailyBibleVerseModel(verse: $verse, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBibleVerseModelImpl &&
            (identical(other.verse, verse) || other.verse == verse) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, verse, content);

  /// Create a copy of DailyBibleVerseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBibleVerseModelImplCopyWith<_$DailyBibleVerseModelImpl>
      get copyWith =>
          __$$DailyBibleVerseModelImplCopyWithImpl<_$DailyBibleVerseModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyBibleVerseModelImplToJson(
      this,
    );
  }
}

abstract class _DailyBibleVerseModel extends DailyBibleVerseModel {
  const factory _DailyBibleVerseModel(
          {@JsonKey(name: 'Verse') required final String verse,
          @JsonKey(name: 'Bible_Cn') required final String content}) =
      _$DailyBibleVerseModelImpl;
  const _DailyBibleVerseModel._() : super._();

  factory _DailyBibleVerseModel.fromJson(Map<String, dynamic> json) =
      _$DailyBibleVerseModelImpl.fromJson;

  @override
  @JsonKey(name: 'Verse')
  String get verse;
  @override
  @JsonKey(name: 'Bible_Cn')
  String get content;

  /// Create a copy of DailyBibleVerseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBibleVerseModelImplCopyWith<_$DailyBibleVerseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DailyBibleHeaderModel _$DailyBibleHeaderModelFromJson(
    Map<String, dynamic> json) {
  return _DailyBibleHeaderModel.fromJson(json);
}

/// @nodoc
mixin _$DailyBibleHeaderModel {
  @JsonKey(name: 'Bible_name')
  String get bibleName => throw _privateConstructorUsedError;
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter => throw _privateConstructorUsedError;
  @JsonKey(name: 'Base_de')
  String get date => throw _privateConstructorUsedError;

  /// Serializes this DailyBibleHeaderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyBibleHeaderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBibleHeaderModelCopyWith<DailyBibleHeaderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBibleHeaderModelCopyWith<$Res> {
  factory $DailyBibleHeaderModelCopyWith(DailyBibleHeaderModel value,
          $Res Function(DailyBibleHeaderModel) then) =
      _$DailyBibleHeaderModelCopyWithImpl<$Res, DailyBibleHeaderModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Bible_name') String bibleName,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Base_de') String date});
}

/// @nodoc
class _$DailyBibleHeaderModelCopyWithImpl<$Res,
        $Val extends DailyBibleHeaderModel>
    implements $DailyBibleHeaderModelCopyWith<$Res> {
  _$DailyBibleHeaderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBibleHeaderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bibleName = null,
    Object? bibleChapter = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      bibleName: null == bibleName
          ? _value.bibleName
          : bibleName // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyBibleHeaderModelImplCopyWith<$Res>
    implements $DailyBibleHeaderModelCopyWith<$Res> {
  factory _$$DailyBibleHeaderModelImplCopyWith(
          _$DailyBibleHeaderModelImpl value,
          $Res Function(_$DailyBibleHeaderModelImpl) then) =
      __$$DailyBibleHeaderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Bible_name') String bibleName,
      @JsonKey(name: 'Bible_chapter') String bibleChapter,
      @JsonKey(name: 'Base_de') String date});
}

/// @nodoc
class __$$DailyBibleHeaderModelImplCopyWithImpl<$Res>
    extends _$DailyBibleHeaderModelCopyWithImpl<$Res,
        _$DailyBibleHeaderModelImpl>
    implements _$$DailyBibleHeaderModelImplCopyWith<$Res> {
  __$$DailyBibleHeaderModelImplCopyWithImpl(_$DailyBibleHeaderModelImpl _value,
      $Res Function(_$DailyBibleHeaderModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBibleHeaderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bibleName = null,
    Object? bibleChapter = null,
    Object? date = null,
  }) {
    return _then(_$DailyBibleHeaderModelImpl(
      bibleName: null == bibleName
          ? _value.bibleName
          : bibleName // ignore: cast_nullable_to_non_nullable
              as String,
      bibleChapter: null == bibleChapter
          ? _value.bibleChapter
          : bibleChapter // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyBibleHeaderModelImpl extends _DailyBibleHeaderModel {
  const _$DailyBibleHeaderModelImpl(
      {@JsonKey(name: 'Bible_name') required this.bibleName,
      @JsonKey(name: 'Bible_chapter') required this.bibleChapter,
      @JsonKey(name: 'Base_de') required this.date})
      : super._();

  factory _$DailyBibleHeaderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyBibleHeaderModelImplFromJson(json);

  @override
  @JsonKey(name: 'Bible_name')
  final String bibleName;
  @override
  @JsonKey(name: 'Bible_chapter')
  final String bibleChapter;
  @override
  @JsonKey(name: 'Base_de')
  final String date;

  @override
  String toString() {
    return 'DailyBibleHeaderModel(bibleName: $bibleName, bibleChapter: $bibleChapter, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBibleHeaderModelImpl &&
            (identical(other.bibleName, bibleName) ||
                other.bibleName == bibleName) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bibleName, bibleChapter, date);

  /// Create a copy of DailyBibleHeaderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBibleHeaderModelImplCopyWith<_$DailyBibleHeaderModelImpl>
      get copyWith => __$$DailyBibleHeaderModelImplCopyWithImpl<
          _$DailyBibleHeaderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyBibleHeaderModelImplToJson(
      this,
    );
  }
}

abstract class _DailyBibleHeaderModel extends DailyBibleHeaderModel {
  const factory _DailyBibleHeaderModel(
          {@JsonKey(name: 'Bible_name') required final String bibleName,
          @JsonKey(name: 'Bible_chapter') required final String bibleChapter,
          @JsonKey(name: 'Base_de') required final String date}) =
      _$DailyBibleHeaderModelImpl;
  const _DailyBibleHeaderModel._() : super._();

  factory _DailyBibleHeaderModel.fromJson(Map<String, dynamic> json) =
      _$DailyBibleHeaderModelImpl.fromJson;

  @override
  @JsonKey(name: 'Bible_name')
  String get bibleName;
  @override
  @JsonKey(name: 'Bible_chapter')
  String get bibleChapter;
  @override
  @JsonKey(name: 'Base_de')
  String get date;

  /// Create a copy of DailyBibleHeaderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBibleHeaderModelImplCopyWith<_$DailyBibleHeaderModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DailyBibleModel _$DailyBibleModelFromJson(Map<String, dynamic> json) {
  return _DailyBibleModel.fromJson(json);
}

/// @nodoc
mixin _$DailyBibleModel {
  String get date => throw _privateConstructorUsedError;
  String get bibleName => throw _privateConstructorUsedError;
  String get bibleChapter => throw _privateConstructorUsedError;
  List<DailyBibleVerseModel> get verses => throw _privateConstructorUsedError;

  /// Serializes this DailyBibleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyBibleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyBibleModelCopyWith<DailyBibleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyBibleModelCopyWith<$Res> {
  factory $DailyBibleModelCopyWith(
          DailyBibleModel value, $Res Function(DailyBibleModel) then) =
      _$DailyBibleModelCopyWithImpl<$Res, DailyBibleModel>;
  @useResult
  $Res call(
      {String date,
      String bibleName,
      String bibleChapter,
      List<DailyBibleVerseModel> verses});
}

/// @nodoc
class _$DailyBibleModelCopyWithImpl<$Res, $Val extends DailyBibleModel>
    implements $DailyBibleModelCopyWith<$Res> {
  _$DailyBibleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyBibleModel
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
              as List<DailyBibleVerseModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyBibleModelImplCopyWith<$Res>
    implements $DailyBibleModelCopyWith<$Res> {
  factory _$$DailyBibleModelImplCopyWith(_$DailyBibleModelImpl value,
          $Res Function(_$DailyBibleModelImpl) then) =
      __$$DailyBibleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String bibleName,
      String bibleChapter,
      List<DailyBibleVerseModel> verses});
}

/// @nodoc
class __$$DailyBibleModelImplCopyWithImpl<$Res>
    extends _$DailyBibleModelCopyWithImpl<$Res, _$DailyBibleModelImpl>
    implements _$$DailyBibleModelImplCopyWith<$Res> {
  __$$DailyBibleModelImplCopyWithImpl(
      _$DailyBibleModelImpl _value, $Res Function(_$DailyBibleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyBibleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? bibleName = null,
    Object? bibleChapter = null,
    Object? verses = null,
  }) {
    return _then(_$DailyBibleModelImpl(
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
              as List<DailyBibleVerseModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyBibleModelImpl extends _DailyBibleModel {
  const _$DailyBibleModelImpl(
      {required this.date,
      required this.bibleName,
      required this.bibleChapter,
      required final List<DailyBibleVerseModel> verses})
      : _verses = verses,
        super._();

  factory _$DailyBibleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyBibleModelImplFromJson(json);

  @override
  final String date;
  @override
  final String bibleName;
  @override
  final String bibleChapter;
  final List<DailyBibleVerseModel> _verses;
  @override
  List<DailyBibleVerseModel> get verses {
    if (_verses is EqualUnmodifiableListView) return _verses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verses);
  }

  @override
  String toString() {
    return 'DailyBibleModel(date: $date, bibleName: $bibleName, bibleChapter: $bibleChapter, verses: $verses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyBibleModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.bibleName, bibleName) ||
                other.bibleName == bibleName) &&
            (identical(other.bibleChapter, bibleChapter) ||
                other.bibleChapter == bibleChapter) &&
            const DeepCollectionEquality().equals(other._verses, _verses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, bibleName, bibleChapter,
      const DeepCollectionEquality().hash(_verses));

  /// Create a copy of DailyBibleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyBibleModelImplCopyWith<_$DailyBibleModelImpl> get copyWith =>
      __$$DailyBibleModelImplCopyWithImpl<_$DailyBibleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyBibleModelImplToJson(
      this,
    );
  }
}

abstract class _DailyBibleModel extends DailyBibleModel {
  const factory _DailyBibleModel(
          {required final String date,
          required final String bibleName,
          required final String bibleChapter,
          required final List<DailyBibleVerseModel> verses}) =
      _$DailyBibleModelImpl;
  const _DailyBibleModel._() : super._();

  factory _DailyBibleModel.fromJson(Map<String, dynamic> json) =
      _$DailyBibleModelImpl.fromJson;

  @override
  String get date;
  @override
  String get bibleName;
  @override
  String get bibleChapter;
  @override
  List<DailyBibleVerseModel> get verses;

  /// Create a copy of DailyBibleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyBibleModelImplCopyWith<_$DailyBibleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
