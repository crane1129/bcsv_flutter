// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sunday_bible_text_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BibleReferenceModel {

@JsonKey(name: 'Text_Class') String get textClass;@JsonKey(name: 'Bible_chapter') String get bibleChapter;@JsonKey(name: 'Bible_text') String get bibleText;
/// Create a copy of BibleReferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleReferenceModelCopyWith<BibleReferenceModel> get copyWith => _$BibleReferenceModelCopyWithImpl<BibleReferenceModel>(this as BibleReferenceModel, _$identity);

  /// Serializes this BibleReferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BibleReferenceModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleReferenceModel&&(identical(other.textClass, _this.textClass) || other.textClass == _this.textClass)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BibleReferenceModel;
  return Object.hash(runtimeType,_this.textClass,_this.bibleChapter,_this.bibleText);
}

@override
String toString() {
  final _this = this as BibleReferenceModel;
  return 'BibleReferenceModel(textClass: ${_this.textClass}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText})';
}


}

/// @nodoc
abstract mixin class $BibleReferenceModelCopyWith<$Res>  {
  factory $BibleReferenceModelCopyWith(BibleReferenceModel value, $Res Function(BibleReferenceModel) _then) = _$BibleReferenceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Text_Class') String textClass,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText
});




}
/// @nodoc
class _$BibleReferenceModelCopyWithImpl<$Res>
    implements $BibleReferenceModelCopyWith<$Res> {
  _$BibleReferenceModelCopyWithImpl(this._self, this._then);

  final BibleReferenceModel _self;
  final $Res Function(BibleReferenceModel) _then;

/// Create a copy of BibleReferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(BibleReferenceModel(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleReferenceModel].
extension BibleReferenceModelPatterns on BibleReferenceModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleReferenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleReferenceModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleReferenceModel value)  $default,){
final _that = this;
switch (_that) {
case _BibleReferenceModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleReferenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _BibleReferenceModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleReferenceModel() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)  $default,) {final _that = this;
switch (_that) {
case _BibleReferenceModel():
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)?  $default,) {final _that = this;
switch (_that) {
case _BibleReferenceModel() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleReferenceModel extends BibleReferenceModel {
  const _BibleReferenceModel({@JsonKey(name: 'Text_Class') required this.textClass, @JsonKey(name: 'Bible_chapter') required this.bibleChapter, @JsonKey(name: 'Bible_text') required this.bibleText}): super._();
  factory _BibleReferenceModel.fromJson(Map<String, dynamic> json) => _$BibleReferenceModelFromJson(json);

@override@JsonKey(name: 'Text_Class') final  String textClass;
@override@JsonKey(name: 'Bible_chapter') final  String bibleChapter;
@override@JsonKey(name: 'Bible_text') final  String bibleText;

/// Create a copy of BibleReferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleReferenceModelCopyWith<_BibleReferenceModel> get copyWith => __$BibleReferenceModelCopyWithImpl<_BibleReferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleReferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleReferenceModel&&(identical(other.textClass, textClass) || other.textClass == textClass)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,textClass,bibleChapter,bibleText);
}

@override
String toString() {
    return 'BibleReferenceModel(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
}


}

/// @nodoc
abstract mixin class _$BibleReferenceModelCopyWith<$Res> implements $BibleReferenceModelCopyWith<$Res> {
  factory _$BibleReferenceModelCopyWith(_BibleReferenceModel value, $Res Function(_BibleReferenceModel) _then) = __$BibleReferenceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Text_Class') String textClass,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText
});




}
/// @nodoc
class __$BibleReferenceModelCopyWithImpl<$Res>
    implements _$BibleReferenceModelCopyWith<$Res> {
  __$BibleReferenceModelCopyWithImpl(this._self, this._then);

  final _BibleReferenceModel _self;
  final $Res Function(_BibleReferenceModel) _then;

/// Create a copy of BibleReferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(_BibleReferenceModel(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReviewQuestionModel {

@JsonKey(name: 'Text_Class') String get textClass;@JsonKey(name: 'Bible_chapter') String get bibleChapter;@JsonKey(name: 'Bible_text') String get bibleText;
/// Create a copy of ReviewQuestionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewQuestionModelCopyWith<ReviewQuestionModel> get copyWith => _$ReviewQuestionModelCopyWithImpl<ReviewQuestionModel>(this as ReviewQuestionModel, _$identity);

  /// Serializes this ReviewQuestionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReviewQuestionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewQuestionModel&&(identical(other.textClass, _this.textClass) || other.textClass == _this.textClass)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReviewQuestionModel;
  return Object.hash(runtimeType,_this.textClass,_this.bibleChapter,_this.bibleText);
}

@override
String toString() {
  final _this = this as ReviewQuestionModel;
  return 'ReviewQuestionModel(textClass: ${_this.textClass}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText})';
}


}

/// @nodoc
abstract mixin class $ReviewQuestionModelCopyWith<$Res>  {
  factory $ReviewQuestionModelCopyWith(ReviewQuestionModel value, $Res Function(ReviewQuestionModel) _then) = _$ReviewQuestionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Text_Class') String textClass,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText
});




}
/// @nodoc
class _$ReviewQuestionModelCopyWithImpl<$Res>
    implements $ReviewQuestionModelCopyWith<$Res> {
  _$ReviewQuestionModelCopyWithImpl(this._self, this._then);

  final ReviewQuestionModel _self;
  final $Res Function(ReviewQuestionModel) _then;

/// Create a copy of ReviewQuestionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(ReviewQuestionModel(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewQuestionModel].
extension ReviewQuestionModelPatterns on ReviewQuestionModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewQuestionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewQuestionModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewQuestionModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewQuestionModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewQuestionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewQuestionModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewQuestionModel() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)  $default,) {final _that = this;
switch (_that) {
case _ReviewQuestionModel():
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Text_Class')  String textClass, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText)?  $default,) {final _that = this;
switch (_that) {
case _ReviewQuestionModel() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewQuestionModel extends ReviewQuestionModel {
  const _ReviewQuestionModel({@JsonKey(name: 'Text_Class') required this.textClass, @JsonKey(name: 'Bible_chapter') required this.bibleChapter, @JsonKey(name: 'Bible_text') required this.bibleText}): super._();
  factory _ReviewQuestionModel.fromJson(Map<String, dynamic> json) => _$ReviewQuestionModelFromJson(json);

@override@JsonKey(name: 'Text_Class') final  String textClass;
@override@JsonKey(name: 'Bible_chapter') final  String bibleChapter;
@override@JsonKey(name: 'Bible_text') final  String bibleText;

/// Create a copy of ReviewQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewQuestionModelCopyWith<_ReviewQuestionModel> get copyWith => __$ReviewQuestionModelCopyWithImpl<_ReviewQuestionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewQuestionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewQuestionModel&&(identical(other.textClass, textClass) || other.textClass == textClass)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,textClass,bibleChapter,bibleText);
}

@override
String toString() {
    return 'ReviewQuestionModel(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
}


}

/// @nodoc
abstract mixin class _$ReviewQuestionModelCopyWith<$Res> implements $ReviewQuestionModelCopyWith<$Res> {
  factory _$ReviewQuestionModelCopyWith(_ReviewQuestionModel value, $Res Function(_ReviewQuestionModel) _then) = __$ReviewQuestionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Text_Class') String textClass,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText
});




}
/// @nodoc
class __$ReviewQuestionModelCopyWithImpl<$Res>
    implements _$ReviewQuestionModelCopyWith<$Res> {
  __$ReviewQuestionModelCopyWithImpl(this._self, this._then);

  final _ReviewQuestionModel _self;
  final $Res Function(_ReviewQuestionModel) _then;

/// Create a copy of ReviewQuestionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(_ReviewQuestionModel(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SundayBibleTextModel {

@JsonKey(name: 'Date') String get date;@JsonKey(name: 'Title') String get title;@JsonKey(name: 'Bible_chapter') String get bibleChapter;@JsonKey(name: 'Bible_text') String get bibleText;@JsonKey(name: 'File_url') String get fileUrl;@JsonKey(name: 'References') List<BibleReferenceModel> get references;@JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? get reviewQuestion;
/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SundayBibleTextModelCopyWith<SundayBibleTextModel> get copyWith => _$SundayBibleTextModelCopyWithImpl<SundayBibleTextModel>(this as SundayBibleTextModel, _$identity);

  /// Serializes this SundayBibleTextModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SundayBibleTextModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SundayBibleTextModel&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText)&&(identical(other.fileUrl, _this.fileUrl) || other.fileUrl == _this.fileUrl)&&const DeepCollectionEquality().equals(other.references, _this.references)&&(identical(other.reviewQuestion, _this.reviewQuestion) || other.reviewQuestion == _this.reviewQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SundayBibleTextModel;
  return Object.hash(runtimeType,_this.date,_this.title,_this.bibleChapter,_this.bibleText,_this.fileUrl,const DeepCollectionEquality().hash(_this.references),_this.reviewQuestion);
}

@override
String toString() {
  final _this = this as SundayBibleTextModel;
  return 'SundayBibleTextModel(date: ${_this.date}, title: ${_this.title}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText}, fileUrl: ${_this.fileUrl}, references: ${_this.references}, reviewQuestion: ${_this.reviewQuestion})';
}


}

/// @nodoc
abstract mixin class $SundayBibleTextModelCopyWith<$Res>  {
  factory $SundayBibleTextModelCopyWith(SundayBibleTextModel value, $Res Function(SundayBibleTextModel) _then) = _$SundayBibleTextModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Date') String date,@JsonKey(name: 'Title') String title,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText,@JsonKey(name: 'File_url') String fileUrl,@JsonKey(name: 'References') List<BibleReferenceModel> references,@JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? reviewQuestion
});


$ReviewQuestionModelCopyWith<$Res>? get reviewQuestion;

}
/// @nodoc
class _$SundayBibleTextModelCopyWithImpl<$Res>
    implements $SundayBibleTextModelCopyWith<$Res> {
  _$SundayBibleTextModelCopyWithImpl(this._self, this._then);

  final SundayBibleTextModel _self;
  final $Res Function(SundayBibleTextModel) _then;

/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? title = null,Object? bibleChapter = null,Object? bibleText = null,Object? fileUrl = null,Object? references = null,Object? reviewQuestion = freezed,}) {
  return _then(SundayBibleTextModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<BibleReferenceModel>,reviewQuestion: freezed == reviewQuestion ? _self.reviewQuestion : reviewQuestion // ignore: cast_nullable_to_non_nullable
as ReviewQuestionModel?,
  ));
}
/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewQuestionModelCopyWith<$Res>? get reviewQuestion {
    if (_self.reviewQuestion == null) {
    return null;
  }

  return $ReviewQuestionModelCopyWith<$Res>(_self.reviewQuestion!, (value) {
    return _then(_self.copyWith(reviewQuestion: value));
  });
}
}


/// Adds pattern-matching-related methods to [SundayBibleTextModel].
extension SundayBibleTextModelPatterns on SundayBibleTextModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SundayBibleTextModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SundayBibleTextModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SundayBibleTextModel value)  $default,){
final _that = this;
switch (_that) {
case _SundayBibleTextModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SundayBibleTextModel value)?  $default,){
final _that = this;
switch (_that) {
case _SundayBibleTextModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Date')  String date, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText, @JsonKey(name: 'File_url')  String fileUrl, @JsonKey(name: 'References')  List<BibleReferenceModel> references, @JsonKey(name: 'ReviewQuestion')  ReviewQuestionModel? reviewQuestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SundayBibleTextModel() when $default != null:
return $default(_that.date,_that.title,_that.bibleChapter,_that.bibleText,_that.fileUrl,_that.references,_that.reviewQuestion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Date')  String date, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText, @JsonKey(name: 'File_url')  String fileUrl, @JsonKey(name: 'References')  List<BibleReferenceModel> references, @JsonKey(name: 'ReviewQuestion')  ReviewQuestionModel? reviewQuestion)  $default,) {final _that = this;
switch (_that) {
case _SundayBibleTextModel():
return $default(_that.date,_that.title,_that.bibleChapter,_that.bibleText,_that.fileUrl,_that.references,_that.reviewQuestion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Date')  String date, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Bible_text')  String bibleText, @JsonKey(name: 'File_url')  String fileUrl, @JsonKey(name: 'References')  List<BibleReferenceModel> references, @JsonKey(name: 'ReviewQuestion')  ReviewQuestionModel? reviewQuestion)?  $default,) {final _that = this;
switch (_that) {
case _SundayBibleTextModel() when $default != null:
return $default(_that.date,_that.title,_that.bibleChapter,_that.bibleText,_that.fileUrl,_that.references,_that.reviewQuestion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SundayBibleTextModel extends SundayBibleTextModel {
  const _SundayBibleTextModel({@JsonKey(name: 'Date') required this.date, @JsonKey(name: 'Title') required this.title, @JsonKey(name: 'Bible_chapter') required this.bibleChapter, @JsonKey(name: 'Bible_text') required this.bibleText, @JsonKey(name: 'File_url') this.fileUrl = '', @JsonKey(name: 'References')  List<BibleReferenceModel> references = const [], @JsonKey(name: 'ReviewQuestion') this.reviewQuestion}): _references = references,super._();
  factory _SundayBibleTextModel.fromJson(Map<String, dynamic> json) => _$SundayBibleTextModelFromJson(json);

@override@JsonKey(name: 'Date') final  String date;
@override@JsonKey(name: 'Title') final  String title;
@override@JsonKey(name: 'Bible_chapter') final  String bibleChapter;
@override@JsonKey(name: 'Bible_text') final  String bibleText;
@override@JsonKey(name: 'File_url') final  String fileUrl;
 final  List<BibleReferenceModel> _references;
@override@JsonKey(name: 'References') List<BibleReferenceModel> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override@JsonKey(name: 'ReviewQuestion') final  ReviewQuestionModel? reviewQuestion;

/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SundayBibleTextModelCopyWith<_SundayBibleTextModel> get copyWith => __$SundayBibleTextModelCopyWithImpl<_SundayBibleTextModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SundayBibleTextModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SundayBibleTextModel&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&const DeepCollectionEquality().equals(other.references, _references)&&(identical(other.reviewQuestion, reviewQuestion) || other.reviewQuestion == reviewQuestion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,title,bibleChapter,bibleText,fileUrl,const DeepCollectionEquality().hash(_references),reviewQuestion);
}

@override
String toString() {
    return 'SundayBibleTextModel(date: $date, title: $title, bibleChapter: $bibleChapter, bibleText: $bibleText, fileUrl: $fileUrl, references: $references, reviewQuestion: $reviewQuestion)';
}


}

/// @nodoc
abstract mixin class _$SundayBibleTextModelCopyWith<$Res> implements $SundayBibleTextModelCopyWith<$Res> {
  factory _$SundayBibleTextModelCopyWith(_SundayBibleTextModel value, $Res Function(_SundayBibleTextModel) _then) = __$SundayBibleTextModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Date') String date,@JsonKey(name: 'Title') String title,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Bible_text') String bibleText,@JsonKey(name: 'File_url') String fileUrl,@JsonKey(name: 'References') List<BibleReferenceModel> references,@JsonKey(name: 'ReviewQuestion') ReviewQuestionModel? reviewQuestion
});


@override $ReviewQuestionModelCopyWith<$Res>? get reviewQuestion;

}
/// @nodoc
class __$SundayBibleTextModelCopyWithImpl<$Res>
    implements _$SundayBibleTextModelCopyWith<$Res> {
  __$SundayBibleTextModelCopyWithImpl(this._self, this._then);

  final _SundayBibleTextModel _self;
  final $Res Function(_SundayBibleTextModel) _then;

/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? title = null,Object? bibleChapter = null,Object? bibleText = null,Object? fileUrl = null,Object? references = null,Object? reviewQuestion = freezed,}) {
  return _then(_SundayBibleTextModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<BibleReferenceModel>,reviewQuestion: freezed == reviewQuestion ? _self.reviewQuestion : reviewQuestion // ignore: cast_nullable_to_non_nullable
as ReviewQuestionModel?,
  ));
}

/// Create a copy of SundayBibleTextModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewQuestionModelCopyWith<$Res>? get reviewQuestion {
    if (_self.reviewQuestion == null) {
    return null;
  }

  return $ReviewQuestionModelCopyWith<$Res>(_self.reviewQuestion!, (value) {
    return _then(_self.copyWith(reviewQuestion: value));
  });
}
}

// dart format on
