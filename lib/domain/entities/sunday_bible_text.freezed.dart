// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sunday_bible_text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BibleReferenceEntity {

 String get textClass; String get bibleChapter; String get bibleText;
/// Create a copy of BibleReferenceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleReferenceEntityCopyWith<BibleReferenceEntity> get copyWith => _$BibleReferenceEntityCopyWithImpl<BibleReferenceEntity>(this as BibleReferenceEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BibleReferenceEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleReferenceEntity&&(identical(other.textClass, _this.textClass) || other.textClass == _this.textClass)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText));
}


@override
int get hashCode {
  final _this = this as BibleReferenceEntity;
  return Object.hash(runtimeType,_this.textClass,_this.bibleChapter,_this.bibleText);
}

@override
String toString() {
  final _this = this as BibleReferenceEntity;
  return 'BibleReferenceEntity(textClass: ${_this.textClass}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText})';
}


}

/// @nodoc
abstract mixin class $BibleReferenceEntityCopyWith<$Res>  {
  factory $BibleReferenceEntityCopyWith(BibleReferenceEntity value, $Res Function(BibleReferenceEntity) _then) = _$BibleReferenceEntityCopyWithImpl;
@useResult
$Res call({
 String textClass, String bibleChapter, String bibleText
});




}
/// @nodoc
class _$BibleReferenceEntityCopyWithImpl<$Res>
    implements $BibleReferenceEntityCopyWith<$Res> {
  _$BibleReferenceEntityCopyWithImpl(this._self, this._then);

  final BibleReferenceEntity _self;
  final $Res Function(BibleReferenceEntity) _then;

/// Create a copy of BibleReferenceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(BibleReferenceEntity(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleReferenceEntity].
extension BibleReferenceEntityPatterns on BibleReferenceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleReferenceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleReferenceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleReferenceEntity value)  $default,){
final _that = this;
switch (_that) {
case _BibleReferenceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleReferenceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BibleReferenceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String textClass,  String bibleChapter,  String bibleText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleReferenceEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String textClass,  String bibleChapter,  String bibleText)  $default,) {final _that = this;
switch (_that) {
case _BibleReferenceEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String textClass,  String bibleChapter,  String bibleText)?  $default,) {final _that = this;
switch (_that) {
case _BibleReferenceEntity() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return null;

}
}

}

/// @nodoc


class _BibleReferenceEntity implements BibleReferenceEntity {
  const _BibleReferenceEntity({required this.textClass, required this.bibleChapter, required this.bibleText});
  

@override final  String textClass;
@override final  String bibleChapter;
@override final  String bibleText;

/// Create a copy of BibleReferenceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleReferenceEntityCopyWith<_BibleReferenceEntity> get copyWith => __$BibleReferenceEntityCopyWithImpl<_BibleReferenceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleReferenceEntity&&(identical(other.textClass, textClass) || other.textClass == textClass)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,textClass,bibleChapter,bibleText);
}

@override
String toString() {
    return 'BibleReferenceEntity(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
}


}

/// @nodoc
abstract mixin class _$BibleReferenceEntityCopyWith<$Res> implements $BibleReferenceEntityCopyWith<$Res> {
  factory _$BibleReferenceEntityCopyWith(_BibleReferenceEntity value, $Res Function(_BibleReferenceEntity) _then) = __$BibleReferenceEntityCopyWithImpl;
@override @useResult
$Res call({
 String textClass, String bibleChapter, String bibleText
});




}
/// @nodoc
class __$BibleReferenceEntityCopyWithImpl<$Res>
    implements _$BibleReferenceEntityCopyWith<$Res> {
  __$BibleReferenceEntityCopyWithImpl(this._self, this._then);

  final _BibleReferenceEntity _self;
  final $Res Function(_BibleReferenceEntity) _then;

/// Create a copy of BibleReferenceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(_BibleReferenceEntity(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ReviewQuestionEntity {

 String get textClass; String get bibleChapter; String get bibleText;
/// Create a copy of ReviewQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewQuestionEntityCopyWith<ReviewQuestionEntity> get copyWith => _$ReviewQuestionEntityCopyWithImpl<ReviewQuestionEntity>(this as ReviewQuestionEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewQuestionEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewQuestionEntity&&(identical(other.textClass, _this.textClass) || other.textClass == _this.textClass)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText));
}


@override
int get hashCode {
  final _this = this as ReviewQuestionEntity;
  return Object.hash(runtimeType,_this.textClass,_this.bibleChapter,_this.bibleText);
}

@override
String toString() {
  final _this = this as ReviewQuestionEntity;
  return 'ReviewQuestionEntity(textClass: ${_this.textClass}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText})';
}


}

/// @nodoc
abstract mixin class $ReviewQuestionEntityCopyWith<$Res>  {
  factory $ReviewQuestionEntityCopyWith(ReviewQuestionEntity value, $Res Function(ReviewQuestionEntity) _then) = _$ReviewQuestionEntityCopyWithImpl;
@useResult
$Res call({
 String textClass, String bibleChapter, String bibleText
});




}
/// @nodoc
class _$ReviewQuestionEntityCopyWithImpl<$Res>
    implements $ReviewQuestionEntityCopyWith<$Res> {
  _$ReviewQuestionEntityCopyWithImpl(this._self, this._then);

  final ReviewQuestionEntity _self;
  final $Res Function(ReviewQuestionEntity) _then;

/// Create a copy of ReviewQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(ReviewQuestionEntity(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewQuestionEntity].
extension ReviewQuestionEntityPatterns on ReviewQuestionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewQuestionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewQuestionEntity value)  $default,){
final _that = this;
switch (_that) {
case _ReviewQuestionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewQuestionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String textClass,  String bibleChapter,  String bibleText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewQuestionEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String textClass,  String bibleChapter,  String bibleText)  $default,) {final _that = this;
switch (_that) {
case _ReviewQuestionEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String textClass,  String bibleChapter,  String bibleText)?  $default,) {final _that = this;
switch (_that) {
case _ReviewQuestionEntity() when $default != null:
return $default(_that.textClass,_that.bibleChapter,_that.bibleText);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewQuestionEntity implements ReviewQuestionEntity {
  const _ReviewQuestionEntity({required this.textClass, required this.bibleChapter, required this.bibleText});
  

@override final  String textClass;
@override final  String bibleChapter;
@override final  String bibleText;

/// Create a copy of ReviewQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewQuestionEntityCopyWith<_ReviewQuestionEntity> get copyWith => __$ReviewQuestionEntityCopyWithImpl<_ReviewQuestionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewQuestionEntity&&(identical(other.textClass, textClass) || other.textClass == textClass)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText));
}


@override
int get hashCode {
    return Object.hash(runtimeType,textClass,bibleChapter,bibleText);
}

@override
String toString() {
    return 'ReviewQuestionEntity(textClass: $textClass, bibleChapter: $bibleChapter, bibleText: $bibleText)';
}


}

/// @nodoc
abstract mixin class _$ReviewQuestionEntityCopyWith<$Res> implements $ReviewQuestionEntityCopyWith<$Res> {
  factory _$ReviewQuestionEntityCopyWith(_ReviewQuestionEntity value, $Res Function(_ReviewQuestionEntity) _then) = __$ReviewQuestionEntityCopyWithImpl;
@override @useResult
$Res call({
 String textClass, String bibleChapter, String bibleText
});




}
/// @nodoc
class __$ReviewQuestionEntityCopyWithImpl<$Res>
    implements _$ReviewQuestionEntityCopyWith<$Res> {
  __$ReviewQuestionEntityCopyWithImpl(this._self, this._then);

  final _ReviewQuestionEntity _self;
  final $Res Function(_ReviewQuestionEntity) _then;

/// Create a copy of ReviewQuestionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textClass = null,Object? bibleChapter = null,Object? bibleText = null,}) {
  return _then(_ReviewQuestionEntity(
textClass: null == textClass ? _self.textClass : textClass // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SundayBibleTextEntity {

 String get date; String get title; String get bibleChapter; String get bibleText; String get fileUrl; List<BibleReferenceEntity> get references; ReviewQuestionEntity? get reviewQuestion;
/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SundayBibleTextEntityCopyWith<SundayBibleTextEntity> get copyWith => _$SundayBibleTextEntityCopyWithImpl<SundayBibleTextEntity>(this as SundayBibleTextEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SundayBibleTextEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SundayBibleTextEntity&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.bibleText, _this.bibleText) || other.bibleText == _this.bibleText)&&(identical(other.fileUrl, _this.fileUrl) || other.fileUrl == _this.fileUrl)&&const DeepCollectionEquality().equals(other.references, _this.references)&&(identical(other.reviewQuestion, _this.reviewQuestion) || other.reviewQuestion == _this.reviewQuestion));
}


@override
int get hashCode {
  final _this = this as SundayBibleTextEntity;
  return Object.hash(runtimeType,_this.date,_this.title,_this.bibleChapter,_this.bibleText,_this.fileUrl,const DeepCollectionEquality().hash(_this.references),_this.reviewQuestion);
}

@override
String toString() {
  final _this = this as SundayBibleTextEntity;
  return 'SundayBibleTextEntity(date: ${_this.date}, title: ${_this.title}, bibleChapter: ${_this.bibleChapter}, bibleText: ${_this.bibleText}, fileUrl: ${_this.fileUrl}, references: ${_this.references}, reviewQuestion: ${_this.reviewQuestion})';
}


}

/// @nodoc
abstract mixin class $SundayBibleTextEntityCopyWith<$Res>  {
  factory $SundayBibleTextEntityCopyWith(SundayBibleTextEntity value, $Res Function(SundayBibleTextEntity) _then) = _$SundayBibleTextEntityCopyWithImpl;
@useResult
$Res call({
 String date, String title, String bibleChapter, String bibleText, String fileUrl, List<BibleReferenceEntity> references, ReviewQuestionEntity? reviewQuestion
});


$ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion;

}
/// @nodoc
class _$SundayBibleTextEntityCopyWithImpl<$Res>
    implements $SundayBibleTextEntityCopyWith<$Res> {
  _$SundayBibleTextEntityCopyWithImpl(this._self, this._then);

  final SundayBibleTextEntity _self;
  final $Res Function(SundayBibleTextEntity) _then;

/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? title = null,Object? bibleChapter = null,Object? bibleText = null,Object? fileUrl = null,Object? references = null,Object? reviewQuestion = freezed,}) {
  return _then(SundayBibleTextEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<BibleReferenceEntity>,reviewQuestion: freezed == reviewQuestion ? _self.reviewQuestion : reviewQuestion // ignore: cast_nullable_to_non_nullable
as ReviewQuestionEntity?,
  ));
}
/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion {
    if (_self.reviewQuestion == null) {
    return null;
  }

  return $ReviewQuestionEntityCopyWith<$Res>(_self.reviewQuestion!, (value) {
    return _then(_self.copyWith(reviewQuestion: value));
  });
}
}


/// Adds pattern-matching-related methods to [SundayBibleTextEntity].
extension SundayBibleTextEntityPatterns on SundayBibleTextEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SundayBibleTextEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SundayBibleTextEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SundayBibleTextEntity value)  $default,){
final _that = this;
switch (_that) {
case _SundayBibleTextEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SundayBibleTextEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SundayBibleTextEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String title,  String bibleChapter,  String bibleText,  String fileUrl,  List<BibleReferenceEntity> references,  ReviewQuestionEntity? reviewQuestion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SundayBibleTextEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String title,  String bibleChapter,  String bibleText,  String fileUrl,  List<BibleReferenceEntity> references,  ReviewQuestionEntity? reviewQuestion)  $default,) {final _that = this;
switch (_that) {
case _SundayBibleTextEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String title,  String bibleChapter,  String bibleText,  String fileUrl,  List<BibleReferenceEntity> references,  ReviewQuestionEntity? reviewQuestion)?  $default,) {final _that = this;
switch (_that) {
case _SundayBibleTextEntity() when $default != null:
return $default(_that.date,_that.title,_that.bibleChapter,_that.bibleText,_that.fileUrl,_that.references,_that.reviewQuestion);case _:
  return null;

}
}

}

/// @nodoc


class _SundayBibleTextEntity extends SundayBibleTextEntity {
  const _SundayBibleTextEntity({required this.date, required this.title, required this.bibleChapter, required this.bibleText, this.fileUrl = '',  List<BibleReferenceEntity> references = const [], this.reviewQuestion}): _references = references,super._();
  

@override final  String date;
@override final  String title;
@override final  String bibleChapter;
@override final  String bibleText;
@override@JsonKey() final  String fileUrl;
 final  List<BibleReferenceEntity> _references;
@override@JsonKey() List<BibleReferenceEntity> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override final  ReviewQuestionEntity? reviewQuestion;

/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SundayBibleTextEntityCopyWith<_SundayBibleTextEntity> get copyWith => __$SundayBibleTextEntityCopyWithImpl<_SundayBibleTextEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SundayBibleTextEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.bibleText, bibleText) || other.bibleText == bibleText)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&const DeepCollectionEquality().equals(other.references, _references)&&(identical(other.reviewQuestion, reviewQuestion) || other.reviewQuestion == reviewQuestion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,title,bibleChapter,bibleText,fileUrl,const DeepCollectionEquality().hash(_references),reviewQuestion);
}

@override
String toString() {
    return 'SundayBibleTextEntity(date: $date, title: $title, bibleChapter: $bibleChapter, bibleText: $bibleText, fileUrl: $fileUrl, references: $references, reviewQuestion: $reviewQuestion)';
}


}

/// @nodoc
abstract mixin class _$SundayBibleTextEntityCopyWith<$Res> implements $SundayBibleTextEntityCopyWith<$Res> {
  factory _$SundayBibleTextEntityCopyWith(_SundayBibleTextEntity value, $Res Function(_SundayBibleTextEntity) _then) = __$SundayBibleTextEntityCopyWithImpl;
@override @useResult
$Res call({
 String date, String title, String bibleChapter, String bibleText, String fileUrl, List<BibleReferenceEntity> references, ReviewQuestionEntity? reviewQuestion
});


@override $ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion;

}
/// @nodoc
class __$SundayBibleTextEntityCopyWithImpl<$Res>
    implements _$SundayBibleTextEntityCopyWith<$Res> {
  __$SundayBibleTextEntityCopyWithImpl(this._self, this._then);

  final _SundayBibleTextEntity _self;
  final $Res Function(_SundayBibleTextEntity) _then;

/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? title = null,Object? bibleChapter = null,Object? bibleText = null,Object? fileUrl = null,Object? references = null,Object? reviewQuestion = freezed,}) {
  return _then(_SundayBibleTextEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,bibleText: null == bibleText ? _self.bibleText : bibleText // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<BibleReferenceEntity>,reviewQuestion: freezed == reviewQuestion ? _self.reviewQuestion : reviewQuestion // ignore: cast_nullable_to_non_nullable
as ReviewQuestionEntity?,
  ));
}

/// Create a copy of SundayBibleTextEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewQuestionEntityCopyWith<$Res>? get reviewQuestion {
    if (_self.reviewQuestion == null) {
    return null;
  }

  return $ReviewQuestionEntityCopyWith<$Res>(_self.reviewQuestion!, (value) {
    return _then(_self.copyWith(reviewQuestion: value));
  });
}
}

// dart format on
