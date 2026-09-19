// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyverse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeyVerseEntity {

 int get year; String get title; String get book; int get chapter; int get verseFrom; int get verseEnd; String get verse;
/// Create a copy of KeyVerseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyVerseEntityCopyWith<KeyVerseEntity> get copyWith => _$KeyVerseEntityCopyWithImpl<KeyVerseEntity>(this as KeyVerseEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KeyVerseEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyVerseEntity&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.book, _this.book) || other.book == _this.book)&&(identical(other.chapter, _this.chapter) || other.chapter == _this.chapter)&&(identical(other.verseFrom, _this.verseFrom) || other.verseFrom == _this.verseFrom)&&(identical(other.verseEnd, _this.verseEnd) || other.verseEnd == _this.verseEnd)&&(identical(other.verse, _this.verse) || other.verse == _this.verse));
}


@override
int get hashCode {
  final _this = this as KeyVerseEntity;
  return Object.hash(runtimeType,_this.year,_this.title,_this.book,_this.chapter,_this.verseFrom,_this.verseEnd,_this.verse);
}

@override
String toString() {
  final _this = this as KeyVerseEntity;
  return 'KeyVerseEntity(year: ${_this.year}, title: ${_this.title}, book: ${_this.book}, chapter: ${_this.chapter}, verseFrom: ${_this.verseFrom}, verseEnd: ${_this.verseEnd}, verse: ${_this.verse})';
}


}

/// @nodoc
abstract mixin class $KeyVerseEntityCopyWith<$Res>  {
  factory $KeyVerseEntityCopyWith(KeyVerseEntity value, $Res Function(KeyVerseEntity) _then) = _$KeyVerseEntityCopyWithImpl;
@useResult
$Res call({
 int year, String title, String book, int chapter, int verseFrom, int verseEnd, String verse
});




}
/// @nodoc
class _$KeyVerseEntityCopyWithImpl<$Res>
    implements $KeyVerseEntityCopyWith<$Res> {
  _$KeyVerseEntityCopyWithImpl(this._self, this._then);

  final KeyVerseEntity _self;
  final $Res Function(KeyVerseEntity) _then;

/// Create a copy of KeyVerseEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? title = null,Object? book = null,Object? chapter = null,Object? verseFrom = null,Object? verseEnd = null,Object? verse = null,}) {
  return _then(KeyVerseEntity(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verseFrom: null == verseFrom ? _self.verseFrom : verseFrom // ignore: cast_nullable_to_non_nullable
as int,verseEnd: null == verseEnd ? _self.verseEnd : verseEnd // ignore: cast_nullable_to_non_nullable
as int,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [KeyVerseEntity].
extension KeyVerseEntityPatterns on KeyVerseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyVerseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyVerseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyVerseEntity value)  $default,){
final _that = this;
switch (_that) {
case _KeyVerseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyVerseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _KeyVerseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int year,  String title,  String book,  int chapter,  int verseFrom,  int verseEnd,  String verse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyVerseEntity() when $default != null:
return $default(_that.year,_that.title,_that.book,_that.chapter,_that.verseFrom,_that.verseEnd,_that.verse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int year,  String title,  String book,  int chapter,  int verseFrom,  int verseEnd,  String verse)  $default,) {final _that = this;
switch (_that) {
case _KeyVerseEntity():
return $default(_that.year,_that.title,_that.book,_that.chapter,_that.verseFrom,_that.verseEnd,_that.verse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int year,  String title,  String book,  int chapter,  int verseFrom,  int verseEnd,  String verse)?  $default,) {final _that = this;
switch (_that) {
case _KeyVerseEntity() when $default != null:
return $default(_that.year,_that.title,_that.book,_that.chapter,_that.verseFrom,_that.verseEnd,_that.verse);case _:
  return null;

}
}

}

/// @nodoc


class _KeyVerseEntity extends KeyVerseEntity {
  const _KeyVerseEntity({required this.year, required this.title, required this.book, required this.chapter, required this.verseFrom, required this.verseEnd, required this.verse}): super._();
  

@override final  int year;
@override final  String title;
@override final  String book;
@override final  int chapter;
@override final  int verseFrom;
@override final  int verseEnd;
@override final  String verse;

/// Create a copy of KeyVerseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyVerseEntityCopyWith<_KeyVerseEntity> get copyWith => __$KeyVerseEntityCopyWithImpl<_KeyVerseEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyVerseEntity&&(identical(other.year, year) || other.year == year)&&(identical(other.title, title) || other.title == title)&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.verseFrom, verseFrom) || other.verseFrom == verseFrom)&&(identical(other.verseEnd, verseEnd) || other.verseEnd == verseEnd)&&(identical(other.verse, verse) || other.verse == verse));
}


@override
int get hashCode {
    return Object.hash(runtimeType,year,title,book,chapter,verseFrom,verseEnd,verse);
}

@override
String toString() {
    return 'KeyVerseEntity(year: $year, title: $title, book: $book, chapter: $chapter, verseFrom: $verseFrom, verseEnd: $verseEnd, verse: $verse)';
}


}

/// @nodoc
abstract mixin class _$KeyVerseEntityCopyWith<$Res> implements $KeyVerseEntityCopyWith<$Res> {
  factory _$KeyVerseEntityCopyWith(_KeyVerseEntity value, $Res Function(_KeyVerseEntity) _then) = __$KeyVerseEntityCopyWithImpl;
@override @useResult
$Res call({
 int year, String title, String book, int chapter, int verseFrom, int verseEnd, String verse
});




}
/// @nodoc
class __$KeyVerseEntityCopyWithImpl<$Res>
    implements _$KeyVerseEntityCopyWith<$Res> {
  __$KeyVerseEntityCopyWithImpl(this._self, this._then);

  final _KeyVerseEntity _self;
  final $Res Function(_KeyVerseEntity) _then;

/// Create a copy of KeyVerseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? title = null,Object? book = null,Object? chapter = null,Object? verseFrom = null,Object? verseEnd = null,Object? verse = null,}) {
  return _then(_KeyVerseEntity(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verseFrom: null == verseFrom ? _self.verseFrom : verseFrom // ignore: cast_nullable_to_non_nullable
as int,verseEnd: null == verseEnd ? _self.verseEnd : verseEnd // ignore: cast_nullable_to_non_nullable
as int,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
