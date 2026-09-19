// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_bible.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyBibleVerseEntity {

 String get verse; String get content;
/// Create a copy of DailyBibleVerseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBibleVerseEntityCopyWith<DailyBibleVerseEntity> get copyWith => _$DailyBibleVerseEntityCopyWithImpl<DailyBibleVerseEntity>(this as DailyBibleVerseEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyBibleVerseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBibleVerseEntity&&(identical(other.verse, _this.verse) || other.verse == _this.verse)&&(identical(other.content, _this.content) || other.content == _this.content));
}


@override
int get hashCode {
  final _this = this as DailyBibleVerseEntity;
  return Object.hash(runtimeType,_this.verse,_this.content);
}

@override
String toString() {
  final _this = this as DailyBibleVerseEntity;
  return 'DailyBibleVerseEntity(verse: ${_this.verse}, content: ${_this.content})';
}


}

/// @nodoc
abstract mixin class $DailyBibleVerseEntityCopyWith<$Res>  {
  factory $DailyBibleVerseEntityCopyWith(DailyBibleVerseEntity value, $Res Function(DailyBibleVerseEntity) _then) = _$DailyBibleVerseEntityCopyWithImpl;
@useResult
$Res call({
 String verse, String content
});




}
/// @nodoc
class _$DailyBibleVerseEntityCopyWithImpl<$Res>
    implements $DailyBibleVerseEntityCopyWith<$Res> {
  _$DailyBibleVerseEntityCopyWithImpl(this._self, this._then);

  final DailyBibleVerseEntity _self;
  final $Res Function(DailyBibleVerseEntity) _then;

/// Create a copy of DailyBibleVerseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verse = null,Object? content = null,}) {
  return _then(DailyBibleVerseEntity(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBibleVerseEntity].
extension DailyBibleVerseEntityPatterns on DailyBibleVerseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBibleVerseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBibleVerseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBibleVerseEntity value)  $default,){
final _that = this;
switch (_that) {
case _DailyBibleVerseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBibleVerseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBibleVerseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String verse,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBibleVerseEntity() when $default != null:
return $default(_that.verse,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String verse,  String content)  $default,) {final _that = this;
switch (_that) {
case _DailyBibleVerseEntity():
return $default(_that.verse,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String verse,  String content)?  $default,) {final _that = this;
switch (_that) {
case _DailyBibleVerseEntity() when $default != null:
return $default(_that.verse,_that.content);case _:
  return null;

}
}

}

/// @nodoc


class _DailyBibleVerseEntity implements DailyBibleVerseEntity {
  const _DailyBibleVerseEntity({required this.verse, required this.content});
  

@override final  String verse;
@override final  String content;

/// Create a copy of DailyBibleVerseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBibleVerseEntityCopyWith<_DailyBibleVerseEntity> get copyWith => __$DailyBibleVerseEntityCopyWithImpl<_DailyBibleVerseEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBibleVerseEntity&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode {
    return Object.hash(runtimeType,verse,content);
}

@override
String toString() {
    return 'DailyBibleVerseEntity(verse: $verse, content: $content)';
}


}

/// @nodoc
abstract mixin class _$DailyBibleVerseEntityCopyWith<$Res> implements $DailyBibleVerseEntityCopyWith<$Res> {
  factory _$DailyBibleVerseEntityCopyWith(_DailyBibleVerseEntity value, $Res Function(_DailyBibleVerseEntity) _then) = __$DailyBibleVerseEntityCopyWithImpl;
@override @useResult
$Res call({
 String verse, String content
});




}
/// @nodoc
class __$DailyBibleVerseEntityCopyWithImpl<$Res>
    implements _$DailyBibleVerseEntityCopyWith<$Res> {
  __$DailyBibleVerseEntityCopyWithImpl(this._self, this._then);

  final _DailyBibleVerseEntity _self;
  final $Res Function(_DailyBibleVerseEntity) _then;

/// Create a copy of DailyBibleVerseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verse = null,Object? content = null,}) {
  return _then(_DailyBibleVerseEntity(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DailyBibleEntity {

 String get date; String get bibleName; String get bibleChapter; List<DailyBibleVerseEntity> get verses;
/// Create a copy of DailyBibleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBibleEntityCopyWith<DailyBibleEntity> get copyWith => _$DailyBibleEntityCopyWithImpl<DailyBibleEntity>(this as DailyBibleEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyBibleEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBibleEntity&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.bibleName, _this.bibleName) || other.bibleName == _this.bibleName)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&const DeepCollectionEquality().equals(other.verses, _this.verses));
}


@override
int get hashCode {
  final _this = this as DailyBibleEntity;
  return Object.hash(runtimeType,_this.date,_this.bibleName,_this.bibleChapter,const DeepCollectionEquality().hash(_this.verses));
}

@override
String toString() {
  final _this = this as DailyBibleEntity;
  return 'DailyBibleEntity(date: ${_this.date}, bibleName: ${_this.bibleName}, bibleChapter: ${_this.bibleChapter}, verses: ${_this.verses})';
}


}

/// @nodoc
abstract mixin class $DailyBibleEntityCopyWith<$Res>  {
  factory $DailyBibleEntityCopyWith(DailyBibleEntity value, $Res Function(DailyBibleEntity) _then) = _$DailyBibleEntityCopyWithImpl;
@useResult
$Res call({
 String date, String bibleName, String bibleChapter, List<DailyBibleVerseEntity> verses
});




}
/// @nodoc
class _$DailyBibleEntityCopyWithImpl<$Res>
    implements $DailyBibleEntityCopyWith<$Res> {
  _$DailyBibleEntityCopyWithImpl(this._self, this._then);

  final DailyBibleEntity _self;
  final $Res Function(DailyBibleEntity) _then;

/// Create a copy of DailyBibleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? bibleName = null,Object? bibleChapter = null,Object? verses = null,}) {
  return _then(DailyBibleEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,verses: null == verses ? _self.verses : verses // ignore: cast_nullable_to_non_nullable
as List<DailyBibleVerseEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBibleEntity].
extension DailyBibleEntityPatterns on DailyBibleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBibleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBibleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBibleEntity value)  $default,){
final _that = this;
switch (_that) {
case _DailyBibleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBibleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBibleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseEntity> verses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBibleEntity() when $default != null:
return $default(_that.date,_that.bibleName,_that.bibleChapter,_that.verses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseEntity> verses)  $default,) {final _that = this;
switch (_that) {
case _DailyBibleEntity():
return $default(_that.date,_that.bibleName,_that.bibleChapter,_that.verses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseEntity> verses)?  $default,) {final _that = this;
switch (_that) {
case _DailyBibleEntity() when $default != null:
return $default(_that.date,_that.bibleName,_that.bibleChapter,_that.verses);case _:
  return null;

}
}

}

/// @nodoc


class _DailyBibleEntity extends DailyBibleEntity {
  const _DailyBibleEntity({required this.date, required this.bibleName, required this.bibleChapter, required  List<DailyBibleVerseEntity> verses}): _verses = verses,super._();
  

@override final  String date;
@override final  String bibleName;
@override final  String bibleChapter;
 final  List<DailyBibleVerseEntity> _verses;
@override List<DailyBibleVerseEntity> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}


/// Create a copy of DailyBibleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBibleEntityCopyWith<_DailyBibleEntity> get copyWith => __$DailyBibleEntityCopyWithImpl<_DailyBibleEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBibleEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.bibleName, bibleName) || other.bibleName == bibleName)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&const DeepCollectionEquality().equals(other.verses, _verses));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,bibleName,bibleChapter,const DeepCollectionEquality().hash(_verses));
}

@override
String toString() {
    return 'DailyBibleEntity(date: $date, bibleName: $bibleName, bibleChapter: $bibleChapter, verses: $verses)';
}


}

/// @nodoc
abstract mixin class _$DailyBibleEntityCopyWith<$Res> implements $DailyBibleEntityCopyWith<$Res> {
  factory _$DailyBibleEntityCopyWith(_DailyBibleEntity value, $Res Function(_DailyBibleEntity) _then) = __$DailyBibleEntityCopyWithImpl;
@override @useResult
$Res call({
 String date, String bibleName, String bibleChapter, List<DailyBibleVerseEntity> verses
});




}
/// @nodoc
class __$DailyBibleEntityCopyWithImpl<$Res>
    implements _$DailyBibleEntityCopyWith<$Res> {
  __$DailyBibleEntityCopyWithImpl(this._self, this._then);

  final _DailyBibleEntity _self;
  final $Res Function(_DailyBibleEntity) _then;

/// Create a copy of DailyBibleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? bibleName = null,Object? bibleChapter = null,Object? verses = null,}) {
  return _then(_DailyBibleEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<DailyBibleVerseEntity>,
  ));
}


}

// dart format on
