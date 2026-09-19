// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyverse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyVerseModel {

@JsonKey(name: 'year') int get year;@JsonKey(name: 'title') String get title;@JsonKey(name: 'book') String get book;@JsonKey(name: 'chapter') int get chapter;@JsonKey(name: 'verseFrom') int get verseFrom;@JsonKey(name: 'verseEnd') int get verseEnd;@JsonKey(name: 'verse') String get verse;
/// Create a copy of KeyVerseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeyVerseModelCopyWith<KeyVerseModel> get copyWith => _$KeyVerseModelCopyWithImpl<KeyVerseModel>(this as KeyVerseModel, _$identity);

  /// Serializes this KeyVerseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KeyVerseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeyVerseModel&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.book, _this.book) || other.book == _this.book)&&(identical(other.chapter, _this.chapter) || other.chapter == _this.chapter)&&(identical(other.verseFrom, _this.verseFrom) || other.verseFrom == _this.verseFrom)&&(identical(other.verseEnd, _this.verseEnd) || other.verseEnd == _this.verseEnd)&&(identical(other.verse, _this.verse) || other.verse == _this.verse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KeyVerseModel;
  return Object.hash(runtimeType,_this.year,_this.title,_this.book,_this.chapter,_this.verseFrom,_this.verseEnd,_this.verse);
}

@override
String toString() {
  final _this = this as KeyVerseModel;
  return 'KeyVerseModel(year: ${_this.year}, title: ${_this.title}, book: ${_this.book}, chapter: ${_this.chapter}, verseFrom: ${_this.verseFrom}, verseEnd: ${_this.verseEnd}, verse: ${_this.verse})';
}


}

/// @nodoc
abstract mixin class $KeyVerseModelCopyWith<$Res>  {
  factory $KeyVerseModelCopyWith(KeyVerseModel value, $Res Function(KeyVerseModel) _then) = _$KeyVerseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'year') int year,@JsonKey(name: 'title') String title,@JsonKey(name: 'book') String book,@JsonKey(name: 'chapter') int chapter,@JsonKey(name: 'verseFrom') int verseFrom,@JsonKey(name: 'verseEnd') int verseEnd,@JsonKey(name: 'verse') String verse
});




}
/// @nodoc
class _$KeyVerseModelCopyWithImpl<$Res>
    implements $KeyVerseModelCopyWith<$Res> {
  _$KeyVerseModelCopyWithImpl(this._self, this._then);

  final KeyVerseModel _self;
  final $Res Function(KeyVerseModel) _then;

/// Create a copy of KeyVerseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? title = null,Object? book = null,Object? chapter = null,Object? verseFrom = null,Object? verseEnd = null,Object? verse = null,}) {
  return _then(KeyVerseModel(
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


/// Adds pattern-matching-related methods to [KeyVerseModel].
extension KeyVerseModelPatterns on KeyVerseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeyVerseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeyVerseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeyVerseModel value)  $default,){
final _that = this;
switch (_that) {
case _KeyVerseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeyVerseModel value)?  $default,){
final _that = this;
switch (_that) {
case _KeyVerseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'year')  int year, @JsonKey(name: 'title')  String title, @JsonKey(name: 'book')  String book, @JsonKey(name: 'chapter')  int chapter, @JsonKey(name: 'verseFrom')  int verseFrom, @JsonKey(name: 'verseEnd')  int verseEnd, @JsonKey(name: 'verse')  String verse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeyVerseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'year')  int year, @JsonKey(name: 'title')  String title, @JsonKey(name: 'book')  String book, @JsonKey(name: 'chapter')  int chapter, @JsonKey(name: 'verseFrom')  int verseFrom, @JsonKey(name: 'verseEnd')  int verseEnd, @JsonKey(name: 'verse')  String verse)  $default,) {final _that = this;
switch (_that) {
case _KeyVerseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'year')  int year, @JsonKey(name: 'title')  String title, @JsonKey(name: 'book')  String book, @JsonKey(name: 'chapter')  int chapter, @JsonKey(name: 'verseFrom')  int verseFrom, @JsonKey(name: 'verseEnd')  int verseEnd, @JsonKey(name: 'verse')  String verse)?  $default,) {final _that = this;
switch (_that) {
case _KeyVerseModel() when $default != null:
return $default(_that.year,_that.title,_that.book,_that.chapter,_that.verseFrom,_that.verseEnd,_that.verse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KeyVerseModel extends KeyVerseModel {
  const _KeyVerseModel({@JsonKey(name: 'year') required this.year, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'book') required this.book, @JsonKey(name: 'chapter') required this.chapter, @JsonKey(name: 'verseFrom') required this.verseFrom, @JsonKey(name: 'verseEnd') required this.verseEnd, @JsonKey(name: 'verse') required this.verse}): super._();
  factory _KeyVerseModel.fromJson(Map<String, dynamic> json) => _$KeyVerseModelFromJson(json);

@override@JsonKey(name: 'year') final  int year;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'book') final  String book;
@override@JsonKey(name: 'chapter') final  int chapter;
@override@JsonKey(name: 'verseFrom') final  int verseFrom;
@override@JsonKey(name: 'verseEnd') final  int verseEnd;
@override@JsonKey(name: 'verse') final  String verse;

/// Create a copy of KeyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeyVerseModelCopyWith<_KeyVerseModel> get copyWith => __$KeyVerseModelCopyWithImpl<_KeyVerseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KeyVerseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeyVerseModel&&(identical(other.year, year) || other.year == year)&&(identical(other.title, title) || other.title == title)&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.verseFrom, verseFrom) || other.verseFrom == verseFrom)&&(identical(other.verseEnd, verseEnd) || other.verseEnd == verseEnd)&&(identical(other.verse, verse) || other.verse == verse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,title,book,chapter,verseFrom,verseEnd,verse);
}

@override
String toString() {
    return 'KeyVerseModel(year: $year, title: $title, book: $book, chapter: $chapter, verseFrom: $verseFrom, verseEnd: $verseEnd, verse: $verse)';
}


}

/// @nodoc
abstract mixin class _$KeyVerseModelCopyWith<$Res> implements $KeyVerseModelCopyWith<$Res> {
  factory _$KeyVerseModelCopyWith(_KeyVerseModel value, $Res Function(_KeyVerseModel) _then) = __$KeyVerseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'year') int year,@JsonKey(name: 'title') String title,@JsonKey(name: 'book') String book,@JsonKey(name: 'chapter') int chapter,@JsonKey(name: 'verseFrom') int verseFrom,@JsonKey(name: 'verseEnd') int verseEnd,@JsonKey(name: 'verse') String verse
});




}
/// @nodoc
class __$KeyVerseModelCopyWithImpl<$Res>
    implements _$KeyVerseModelCopyWith<$Res> {
  __$KeyVerseModelCopyWithImpl(this._self, this._then);

  final _KeyVerseModel _self;
  final $Res Function(_KeyVerseModel) _then;

/// Create a copy of KeyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? title = null,Object? book = null,Object? chapter = null,Object? verseFrom = null,Object? verseEnd = null,Object? verse = null,}) {
  return _then(_KeyVerseModel(
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
