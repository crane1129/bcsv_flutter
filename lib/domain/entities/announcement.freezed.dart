// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnnouncementEntity {

 String get date; String get announcement; String get preacher; String get prayer; String get tuesdayPrayMeeting; String get babysitter; String get offering; String get fileUrl;
/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnnouncementEntityCopyWith<AnnouncementEntity> get copyWith => _$AnnouncementEntityCopyWithImpl<AnnouncementEntity>(this as AnnouncementEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AnnouncementEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnnouncementEntity&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.announcement, _this.announcement) || other.announcement == _this.announcement)&&(identical(other.preacher, _this.preacher) || other.preacher == _this.preacher)&&(identical(other.prayer, _this.prayer) || other.prayer == _this.prayer)&&(identical(other.tuesdayPrayMeeting, _this.tuesdayPrayMeeting) || other.tuesdayPrayMeeting == _this.tuesdayPrayMeeting)&&(identical(other.babysitter, _this.babysitter) || other.babysitter == _this.babysitter)&&(identical(other.offering, _this.offering) || other.offering == _this.offering)&&(identical(other.fileUrl, _this.fileUrl) || other.fileUrl == _this.fileUrl));
}


@override
int get hashCode {
  final _this = this as AnnouncementEntity;
  return Object.hash(runtimeType,_this.date,_this.announcement,_this.preacher,_this.prayer,_this.tuesdayPrayMeeting,_this.babysitter,_this.offering,_this.fileUrl);
}

@override
String toString() {
  final _this = this as AnnouncementEntity;
  return 'AnnouncementEntity(date: ${_this.date}, announcement: ${_this.announcement}, preacher: ${_this.preacher}, prayer: ${_this.prayer}, tuesdayPrayMeeting: ${_this.tuesdayPrayMeeting}, babysitter: ${_this.babysitter}, offering: ${_this.offering}, fileUrl: ${_this.fileUrl})';
}


}

/// @nodoc
abstract mixin class $AnnouncementEntityCopyWith<$Res>  {
  factory $AnnouncementEntityCopyWith(AnnouncementEntity value, $Res Function(AnnouncementEntity) _then) = _$AnnouncementEntityCopyWithImpl;
@useResult
$Res call({
 String date, String announcement, String preacher, String prayer, String tuesdayPrayMeeting, String babysitter, String offering, String fileUrl
});




}
/// @nodoc
class _$AnnouncementEntityCopyWithImpl<$Res>
    implements $AnnouncementEntityCopyWith<$Res> {
  _$AnnouncementEntityCopyWithImpl(this._self, this._then);

  final AnnouncementEntity _self;
  final $Res Function(AnnouncementEntity) _then;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? announcement = null,Object? preacher = null,Object? prayer = null,Object? tuesdayPrayMeeting = null,Object? babysitter = null,Object? offering = null,Object? fileUrl = null,}) {
  return _then(AnnouncementEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,announcement: null == announcement ? _self.announcement : announcement // ignore: cast_nullable_to_non_nullable
as String,preacher: null == preacher ? _self.preacher : preacher // ignore: cast_nullable_to_non_nullable
as String,prayer: null == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as String,tuesdayPrayMeeting: null == tuesdayPrayMeeting ? _self.tuesdayPrayMeeting : tuesdayPrayMeeting // ignore: cast_nullable_to_non_nullable
as String,babysitter: null == babysitter ? _self.babysitter : babysitter // ignore: cast_nullable_to_non_nullable
as String,offering: null == offering ? _self.offering : offering // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnnouncementEntity].
extension AnnouncementEntityPatterns on AnnouncementEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnnouncementEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnnouncementEntity value)  $default,){
final _that = this;
switch (_that) {
case _AnnouncementEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnnouncementEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String announcement,  String preacher,  String prayer,  String tuesdayPrayMeeting,  String babysitter,  String offering,  String fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
return $default(_that.date,_that.announcement,_that.preacher,_that.prayer,_that.tuesdayPrayMeeting,_that.babysitter,_that.offering,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String announcement,  String preacher,  String prayer,  String tuesdayPrayMeeting,  String babysitter,  String offering,  String fileUrl)  $default,) {final _that = this;
switch (_that) {
case _AnnouncementEntity():
return $default(_that.date,_that.announcement,_that.preacher,_that.prayer,_that.tuesdayPrayMeeting,_that.babysitter,_that.offering,_that.fileUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String announcement,  String preacher,  String prayer,  String tuesdayPrayMeeting,  String babysitter,  String offering,  String fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _AnnouncementEntity() when $default != null:
return $default(_that.date,_that.announcement,_that.preacher,_that.prayer,_that.tuesdayPrayMeeting,_that.babysitter,_that.offering,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AnnouncementEntity extends AnnouncementEntity {
  const _AnnouncementEntity({required this.date, required this.announcement, required this.preacher, required this.prayer, this.tuesdayPrayMeeting = '', this.babysitter = '', this.offering = '', this.fileUrl = ''}): super._();
  

@override final  String date;
@override final  String announcement;
@override final  String preacher;
@override final  String prayer;
@override@JsonKey() final  String tuesdayPrayMeeting;
@override@JsonKey() final  String babysitter;
@override@JsonKey() final  String offering;
@override@JsonKey() final  String fileUrl;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnnouncementEntityCopyWith<_AnnouncementEntity> get copyWith => __$AnnouncementEntityCopyWithImpl<_AnnouncementEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnnouncementEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.announcement, announcement) || other.announcement == announcement)&&(identical(other.preacher, preacher) || other.preacher == preacher)&&(identical(other.prayer, prayer) || other.prayer == prayer)&&(identical(other.tuesdayPrayMeeting, tuesdayPrayMeeting) || other.tuesdayPrayMeeting == tuesdayPrayMeeting)&&(identical(other.babysitter, babysitter) || other.babysitter == babysitter)&&(identical(other.offering, offering) || other.offering == offering)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,announcement,preacher,prayer,tuesdayPrayMeeting,babysitter,offering,fileUrl);
}

@override
String toString() {
    return 'AnnouncementEntity(date: $date, announcement: $announcement, preacher: $preacher, prayer: $prayer, tuesdayPrayMeeting: $tuesdayPrayMeeting, babysitter: $babysitter, offering: $offering, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$AnnouncementEntityCopyWith<$Res> implements $AnnouncementEntityCopyWith<$Res> {
  factory _$AnnouncementEntityCopyWith(_AnnouncementEntity value, $Res Function(_AnnouncementEntity) _then) = __$AnnouncementEntityCopyWithImpl;
@override @useResult
$Res call({
 String date, String announcement, String preacher, String prayer, String tuesdayPrayMeeting, String babysitter, String offering, String fileUrl
});




}
/// @nodoc
class __$AnnouncementEntityCopyWithImpl<$Res>
    implements _$AnnouncementEntityCopyWith<$Res> {
  __$AnnouncementEntityCopyWithImpl(this._self, this._then);

  final _AnnouncementEntity _self;
  final $Res Function(_AnnouncementEntity) _then;

/// Create a copy of AnnouncementEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? announcement = null,Object? preacher = null,Object? prayer = null,Object? tuesdayPrayMeeting = null,Object? babysitter = null,Object? offering = null,Object? fileUrl = null,}) {
  return _then(_AnnouncementEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,announcement: null == announcement ? _self.announcement : announcement // ignore: cast_nullable_to_non_nullable
as String,preacher: null == preacher ? _self.preacher : preacher // ignore: cast_nullable_to_non_nullable
as String,prayer: null == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as String,tuesdayPrayMeeting: null == tuesdayPrayMeeting ? _self.tuesdayPrayMeeting : tuesdayPrayMeeting // ignore: cast_nullable_to_non_nullable
as String,babysitter: null == babysitter ? _self.babysitter : babysitter // ignore: cast_nullable_to_non_nullable
as String,offering: null == offering ? _self.offering : offering // ignore: cast_nullable_to_non_nullable
as String,fileUrl: null == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
