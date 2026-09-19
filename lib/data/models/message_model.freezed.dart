// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageModel {

@JsonKey(name: '_id') String get id;@JsonKey(name: 'Created Date') DateTime get createdAt;@JsonKey(name: 'Title') String get title;@JsonKey(name: 'message') String get message;@JsonKey(name: 'category') String get category;@JsonKey(name: 'startDate') DateTime get startDate;@JsonKey(name: 'endDate') DateTime? get endDate;@JsonKey(name: 'titleImage') String get imageUrl;@JsonKey(name: 'externalLink') String get externalLink;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MessageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.externalLink, _this.externalLink) || other.externalLink == _this.externalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MessageModel;
  return Object.hash(runtimeType,_this.id,_this.createdAt,_this.title,_this.message,_this.category,_this.startDate,_this.endDate,_this.imageUrl,_this.externalLink);
}

@override
String toString() {
  final _this = this as MessageModel;
  return 'MessageModel(id: ${_this.id}, createdAt: ${_this.createdAt}, title: ${_this.title}, message: ${_this.message}, category: ${_this.category}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, imageUrl: ${_this.imageUrl}, externalLink: ${_this.externalLink})';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id,@JsonKey(name: 'Created Date') DateTime createdAt,@JsonKey(name: 'Title') String title,@JsonKey(name: 'message') String message,@JsonKey(name: 'category') String category,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime? endDate,@JsonKey(name: 'titleImage') String imageUrl,@JsonKey(name: 'externalLink') String externalLink
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? title = null,Object? message = null,Object? category = null,Object? startDate = null,Object? endDate = freezed,Object? imageUrl = null,Object? externalLink = null,}) {
  return _then(MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,externalLink: null == externalLink ? _self.externalLink : externalLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id, @JsonKey(name: 'Created Date')  DateTime createdAt, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'message')  String message, @JsonKey(name: 'category')  String category, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime? endDate, @JsonKey(name: 'titleImage')  String imageUrl, @JsonKey(name: 'externalLink')  String externalLink)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.createdAt,_that.title,_that.message,_that.category,_that.startDate,_that.endDate,_that.imageUrl,_that.externalLink);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id, @JsonKey(name: 'Created Date')  DateTime createdAt, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'message')  String message, @JsonKey(name: 'category')  String category, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime? endDate, @JsonKey(name: 'titleImage')  String imageUrl, @JsonKey(name: 'externalLink')  String externalLink)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.createdAt,_that.title,_that.message,_that.category,_that.startDate,_that.endDate,_that.imageUrl,_that.externalLink);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id, @JsonKey(name: 'Created Date')  DateTime createdAt, @JsonKey(name: 'Title')  String title, @JsonKey(name: 'message')  String message, @JsonKey(name: 'category')  String category, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime? endDate, @JsonKey(name: 'titleImage')  String imageUrl, @JsonKey(name: 'externalLink')  String externalLink)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.createdAt,_that.title,_that.message,_that.category,_that.startDate,_that.endDate,_that.imageUrl,_that.externalLink);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageModel extends MessageModel {
  const _MessageModel({@JsonKey(name: '_id') required this.id, @JsonKey(name: 'Created Date') required this.createdAt, @JsonKey(name: 'Title') required this.title, @JsonKey(name: 'message') required this.message, @JsonKey(name: 'category') required this.category, @JsonKey(name: 'startDate') required this.startDate, @JsonKey(name: 'endDate') this.endDate, @JsonKey(name: 'titleImage') this.imageUrl = '', @JsonKey(name: 'externalLink') this.externalLink = ''}): super._();
  factory _MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override@JsonKey(name: 'Created Date') final  DateTime createdAt;
@override@JsonKey(name: 'Title') final  String title;
@override@JsonKey(name: 'message') final  String message;
@override@JsonKey(name: 'category') final  String category;
@override@JsonKey(name: 'startDate') final  DateTime startDate;
@override@JsonKey(name: 'endDate') final  DateTime? endDate;
@override@JsonKey(name: 'titleImage') final  String imageUrl;
@override@JsonKey(name: 'externalLink') final  String externalLink;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.category, category) || other.category == category)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.externalLink, externalLink) || other.externalLink == externalLink));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,createdAt,title,message,category,startDate,endDate,imageUrl,externalLink);
}

@override
String toString() {
    return 'MessageModel(id: $id, createdAt: $createdAt, title: $title, message: $message, category: $category, startDate: $startDate, endDate: $endDate, imageUrl: $imageUrl, externalLink: $externalLink)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id,@JsonKey(name: 'Created Date') DateTime createdAt,@JsonKey(name: 'Title') String title,@JsonKey(name: 'message') String message,@JsonKey(name: 'category') String category,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime? endDate,@JsonKey(name: 'titleImage') String imageUrl,@JsonKey(name: 'externalLink') String externalLink
});




}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? createdAt = null,Object? title = null,Object? message = null,Object? category = null,Object? startDate = null,Object? endDate = freezed,Object? imageUrl = null,Object? externalLink = null,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,externalLink: null == externalLink ? _self.externalLink : externalLink // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
