// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_bible_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyBibleVerseModel {

@JsonKey(name: 'Verse') String get verse;@JsonKey(name: 'Bible_Cn') String get content;
/// Create a copy of DailyBibleVerseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBibleVerseModelCopyWith<DailyBibleVerseModel> get copyWith => _$DailyBibleVerseModelCopyWithImpl<DailyBibleVerseModel>(this as DailyBibleVerseModel, _$identity);

  /// Serializes this DailyBibleVerseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DailyBibleVerseModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBibleVerseModel&&(identical(other.verse, _this.verse) || other.verse == _this.verse)&&(identical(other.content, _this.content) || other.content == _this.content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DailyBibleVerseModel;
  return Object.hash(runtimeType,_this.verse,_this.content);
}

@override
String toString() {
  final _this = this as DailyBibleVerseModel;
  return 'DailyBibleVerseModel(verse: ${_this.verse}, content: ${_this.content})';
}


}

/// @nodoc
abstract mixin class $DailyBibleVerseModelCopyWith<$Res>  {
  factory $DailyBibleVerseModelCopyWith(DailyBibleVerseModel value, $Res Function(DailyBibleVerseModel) _then) = _$DailyBibleVerseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Verse') String verse,@JsonKey(name: 'Bible_Cn') String content
});




}
/// @nodoc
class _$DailyBibleVerseModelCopyWithImpl<$Res>
    implements $DailyBibleVerseModelCopyWith<$Res> {
  _$DailyBibleVerseModelCopyWithImpl(this._self, this._then);

  final DailyBibleVerseModel _self;
  final $Res Function(DailyBibleVerseModel) _then;

/// Create a copy of DailyBibleVerseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verse = null,Object? content = null,}) {
  return _then(DailyBibleVerseModel(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBibleVerseModel].
extension DailyBibleVerseModelPatterns on DailyBibleVerseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBibleVerseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBibleVerseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBibleVerseModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyBibleVerseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBibleVerseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBibleVerseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Verse')  String verse, @JsonKey(name: 'Bible_Cn')  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBibleVerseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Verse')  String verse, @JsonKey(name: 'Bible_Cn')  String content)  $default,) {final _that = this;
switch (_that) {
case _DailyBibleVerseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Verse')  String verse, @JsonKey(name: 'Bible_Cn')  String content)?  $default,) {final _that = this;
switch (_that) {
case _DailyBibleVerseModel() when $default != null:
return $default(_that.verse,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBibleVerseModel extends DailyBibleVerseModel {
  const _DailyBibleVerseModel({@JsonKey(name: 'Verse') required this.verse, @JsonKey(name: 'Bible_Cn') required this.content}): super._();
  factory _DailyBibleVerseModel.fromJson(Map<String, dynamic> json) => _$DailyBibleVerseModelFromJson(json);

@override@JsonKey(name: 'Verse') final  String verse;
@override@JsonKey(name: 'Bible_Cn') final  String content;

/// Create a copy of DailyBibleVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBibleVerseModelCopyWith<_DailyBibleVerseModel> get copyWith => __$DailyBibleVerseModelCopyWithImpl<_DailyBibleVerseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBibleVerseModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBibleVerseModel&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,verse,content);
}

@override
String toString() {
    return 'DailyBibleVerseModel(verse: $verse, content: $content)';
}


}

/// @nodoc
abstract mixin class _$DailyBibleVerseModelCopyWith<$Res> implements $DailyBibleVerseModelCopyWith<$Res> {
  factory _$DailyBibleVerseModelCopyWith(_DailyBibleVerseModel value, $Res Function(_DailyBibleVerseModel) _then) = __$DailyBibleVerseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Verse') String verse,@JsonKey(name: 'Bible_Cn') String content
});




}
/// @nodoc
class __$DailyBibleVerseModelCopyWithImpl<$Res>
    implements _$DailyBibleVerseModelCopyWith<$Res> {
  __$DailyBibleVerseModelCopyWithImpl(this._self, this._then);

  final _DailyBibleVerseModel _self;
  final $Res Function(_DailyBibleVerseModel) _then;

/// Create a copy of DailyBibleVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verse = null,Object? content = null,}) {
  return _then(_DailyBibleVerseModel(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DailyBibleHeaderModel {

@JsonKey(name: 'Bible_name') String get bibleName;@JsonKey(name: 'Bible_chapter') String get bibleChapter;@JsonKey(name: 'Base_de') String get date;
/// Create a copy of DailyBibleHeaderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBibleHeaderModelCopyWith<DailyBibleHeaderModel> get copyWith => _$DailyBibleHeaderModelCopyWithImpl<DailyBibleHeaderModel>(this as DailyBibleHeaderModel, _$identity);

  /// Serializes this DailyBibleHeaderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DailyBibleHeaderModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBibleHeaderModel&&(identical(other.bibleName, _this.bibleName) || other.bibleName == _this.bibleName)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&(identical(other.date, _this.date) || other.date == _this.date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DailyBibleHeaderModel;
  return Object.hash(runtimeType,_this.bibleName,_this.bibleChapter,_this.date);
}

@override
String toString() {
  final _this = this as DailyBibleHeaderModel;
  return 'DailyBibleHeaderModel(bibleName: ${_this.bibleName}, bibleChapter: ${_this.bibleChapter}, date: ${_this.date})';
}


}

/// @nodoc
abstract mixin class $DailyBibleHeaderModelCopyWith<$Res>  {
  factory $DailyBibleHeaderModelCopyWith(DailyBibleHeaderModel value, $Res Function(DailyBibleHeaderModel) _then) = _$DailyBibleHeaderModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Bible_name') String bibleName,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Base_de') String date
});




}
/// @nodoc
class _$DailyBibleHeaderModelCopyWithImpl<$Res>
    implements $DailyBibleHeaderModelCopyWith<$Res> {
  _$DailyBibleHeaderModelCopyWithImpl(this._self, this._then);

  final DailyBibleHeaderModel _self;
  final $Res Function(DailyBibleHeaderModel) _then;

/// Create a copy of DailyBibleHeaderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bibleName = null,Object? bibleChapter = null,Object? date = null,}) {
  return _then(DailyBibleHeaderModel(
bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBibleHeaderModel].
extension DailyBibleHeaderModelPatterns on DailyBibleHeaderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBibleHeaderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBibleHeaderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBibleHeaderModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyBibleHeaderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBibleHeaderModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBibleHeaderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Bible_name')  String bibleName, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Base_de')  String date)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBibleHeaderModel() when $default != null:
return $default(_that.bibleName,_that.bibleChapter,_that.date);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Bible_name')  String bibleName, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Base_de')  String date)  $default,) {final _that = this;
switch (_that) {
case _DailyBibleHeaderModel():
return $default(_that.bibleName,_that.bibleChapter,_that.date);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Bible_name')  String bibleName, @JsonKey(name: 'Bible_chapter')  String bibleChapter, @JsonKey(name: 'Base_de')  String date)?  $default,) {final _that = this;
switch (_that) {
case _DailyBibleHeaderModel() when $default != null:
return $default(_that.bibleName,_that.bibleChapter,_that.date);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBibleHeaderModel extends DailyBibleHeaderModel {
  const _DailyBibleHeaderModel({@JsonKey(name: 'Bible_name') required this.bibleName, @JsonKey(name: 'Bible_chapter') required this.bibleChapter, @JsonKey(name: 'Base_de') required this.date}): super._();
  factory _DailyBibleHeaderModel.fromJson(Map<String, dynamic> json) => _$DailyBibleHeaderModelFromJson(json);

@override@JsonKey(name: 'Bible_name') final  String bibleName;
@override@JsonKey(name: 'Bible_chapter') final  String bibleChapter;
@override@JsonKey(name: 'Base_de') final  String date;

/// Create a copy of DailyBibleHeaderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBibleHeaderModelCopyWith<_DailyBibleHeaderModel> get copyWith => __$DailyBibleHeaderModelCopyWithImpl<_DailyBibleHeaderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBibleHeaderModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBibleHeaderModel&&(identical(other.bibleName, bibleName) || other.bibleName == bibleName)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&(identical(other.date, date) || other.date == date));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,bibleName,bibleChapter,date);
}

@override
String toString() {
    return 'DailyBibleHeaderModel(bibleName: $bibleName, bibleChapter: $bibleChapter, date: $date)';
}


}

/// @nodoc
abstract mixin class _$DailyBibleHeaderModelCopyWith<$Res> implements $DailyBibleHeaderModelCopyWith<$Res> {
  factory _$DailyBibleHeaderModelCopyWith(_DailyBibleHeaderModel value, $Res Function(_DailyBibleHeaderModel) _then) = __$DailyBibleHeaderModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Bible_name') String bibleName,@JsonKey(name: 'Bible_chapter') String bibleChapter,@JsonKey(name: 'Base_de') String date
});




}
/// @nodoc
class __$DailyBibleHeaderModelCopyWithImpl<$Res>
    implements _$DailyBibleHeaderModelCopyWith<$Res> {
  __$DailyBibleHeaderModelCopyWithImpl(this._self, this._then);

  final _DailyBibleHeaderModel _self;
  final $Res Function(_DailyBibleHeaderModel) _then;

/// Create a copy of DailyBibleHeaderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bibleName = null,Object? bibleChapter = null,Object? date = null,}) {
  return _then(_DailyBibleHeaderModel(
bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DailyBibleModel {

 String get date; String get bibleName; String get bibleChapter; List<DailyBibleVerseModel> get verses;
/// Create a copy of DailyBibleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyBibleModelCopyWith<DailyBibleModel> get copyWith => _$DailyBibleModelCopyWithImpl<DailyBibleModel>(this as DailyBibleModel, _$identity);

  /// Serializes this DailyBibleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DailyBibleModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyBibleModel&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.bibleName, _this.bibleName) || other.bibleName == _this.bibleName)&&(identical(other.bibleChapter, _this.bibleChapter) || other.bibleChapter == _this.bibleChapter)&&const DeepCollectionEquality().equals(other.verses, _this.verses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DailyBibleModel;
  return Object.hash(runtimeType,_this.date,_this.bibleName,_this.bibleChapter,const DeepCollectionEquality().hash(_this.verses));
}

@override
String toString() {
  final _this = this as DailyBibleModel;
  return 'DailyBibleModel(date: ${_this.date}, bibleName: ${_this.bibleName}, bibleChapter: ${_this.bibleChapter}, verses: ${_this.verses})';
}


}

/// @nodoc
abstract mixin class $DailyBibleModelCopyWith<$Res>  {
  factory $DailyBibleModelCopyWith(DailyBibleModel value, $Res Function(DailyBibleModel) _then) = _$DailyBibleModelCopyWithImpl;
@useResult
$Res call({
 String date, String bibleName, String bibleChapter, List<DailyBibleVerseModel> verses
});




}
/// @nodoc
class _$DailyBibleModelCopyWithImpl<$Res>
    implements $DailyBibleModelCopyWith<$Res> {
  _$DailyBibleModelCopyWithImpl(this._self, this._then);

  final DailyBibleModel _self;
  final $Res Function(DailyBibleModel) _then;

/// Create a copy of DailyBibleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? bibleName = null,Object? bibleChapter = null,Object? verses = null,}) {
  return _then(DailyBibleModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,verses: null == verses ? _self.verses : verses // ignore: cast_nullable_to_non_nullable
as List<DailyBibleVerseModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyBibleModel].
extension DailyBibleModelPatterns on DailyBibleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyBibleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyBibleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyBibleModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyBibleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyBibleModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyBibleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseModel> verses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyBibleModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseModel> verses)  $default,) {final _that = this;
switch (_that) {
case _DailyBibleModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String bibleName,  String bibleChapter,  List<DailyBibleVerseModel> verses)?  $default,) {final _that = this;
switch (_that) {
case _DailyBibleModel() when $default != null:
return $default(_that.date,_that.bibleName,_that.bibleChapter,_that.verses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyBibleModel extends DailyBibleModel {
  const _DailyBibleModel({required this.date, required this.bibleName, required this.bibleChapter, required  List<DailyBibleVerseModel> verses}): _verses = verses,super._();
  factory _DailyBibleModel.fromJson(Map<String, dynamic> json) => _$DailyBibleModelFromJson(json);

@override final  String date;
@override final  String bibleName;
@override final  String bibleChapter;
 final  List<DailyBibleVerseModel> _verses;
@override List<DailyBibleVerseModel> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}


/// Create a copy of DailyBibleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyBibleModelCopyWith<_DailyBibleModel> get copyWith => __$DailyBibleModelCopyWithImpl<_DailyBibleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyBibleModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyBibleModel&&(identical(other.date, date) || other.date == date)&&(identical(other.bibleName, bibleName) || other.bibleName == bibleName)&&(identical(other.bibleChapter, bibleChapter) || other.bibleChapter == bibleChapter)&&const DeepCollectionEquality().equals(other.verses, _verses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,bibleName,bibleChapter,const DeepCollectionEquality().hash(_verses));
}

@override
String toString() {
    return 'DailyBibleModel(date: $date, bibleName: $bibleName, bibleChapter: $bibleChapter, verses: $verses)';
}


}

/// @nodoc
abstract mixin class _$DailyBibleModelCopyWith<$Res> implements $DailyBibleModelCopyWith<$Res> {
  factory _$DailyBibleModelCopyWith(_DailyBibleModel value, $Res Function(_DailyBibleModel) _then) = __$DailyBibleModelCopyWithImpl;
@override @useResult
$Res call({
 String date, String bibleName, String bibleChapter, List<DailyBibleVerseModel> verses
});




}
/// @nodoc
class __$DailyBibleModelCopyWithImpl<$Res>
    implements _$DailyBibleModelCopyWith<$Res> {
  __$DailyBibleModelCopyWithImpl(this._self, this._then);

  final _DailyBibleModel _self;
  final $Res Function(_DailyBibleModel) _then;

/// Create a copy of DailyBibleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? bibleName = null,Object? bibleChapter = null,Object? verses = null,}) {
  return _then(_DailyBibleModel(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,bibleName: null == bibleName ? _self.bibleName : bibleName // ignore: cast_nullable_to_non_nullable
as String,bibleChapter: null == bibleChapter ? _self.bibleChapter : bibleChapter // ignore: cast_nullable_to_non_nullable
as String,verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<DailyBibleVerseModel>,
  ));
}


}

// dart format on
