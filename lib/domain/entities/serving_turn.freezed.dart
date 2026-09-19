// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serving_turn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServingTurnEntity {

 String get date; String get prayer; String get joycorner; String get food; String get prayerDate; String get babysitter;
/// Create a copy of ServingTurnEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServingTurnEntityCopyWith<ServingTurnEntity> get copyWith => _$ServingTurnEntityCopyWithImpl<ServingTurnEntity>(this as ServingTurnEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServingTurnEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServingTurnEntity&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.prayer, _this.prayer) || other.prayer == _this.prayer)&&(identical(other.joycorner, _this.joycorner) || other.joycorner == _this.joycorner)&&(identical(other.food, _this.food) || other.food == _this.food)&&(identical(other.prayerDate, _this.prayerDate) || other.prayerDate == _this.prayerDate)&&(identical(other.babysitter, _this.babysitter) || other.babysitter == _this.babysitter));
}


@override
int get hashCode {
  final _this = this as ServingTurnEntity;
  return Object.hash(runtimeType,_this.date,_this.prayer,_this.joycorner,_this.food,_this.prayerDate,_this.babysitter);
}

@override
String toString() {
  final _this = this as ServingTurnEntity;
  return 'ServingTurnEntity(date: ${_this.date}, prayer: ${_this.prayer}, joycorner: ${_this.joycorner}, food: ${_this.food}, prayerDate: ${_this.prayerDate}, babysitter: ${_this.babysitter})';
}


}

/// @nodoc
abstract mixin class $ServingTurnEntityCopyWith<$Res>  {
  factory $ServingTurnEntityCopyWith(ServingTurnEntity value, $Res Function(ServingTurnEntity) _then) = _$ServingTurnEntityCopyWithImpl;
@useResult
$Res call({
 String date, String prayer, String joycorner, String food, String prayerDate, String babysitter
});




}
/// @nodoc
class _$ServingTurnEntityCopyWithImpl<$Res>
    implements $ServingTurnEntityCopyWith<$Res> {
  _$ServingTurnEntityCopyWithImpl(this._self, this._then);

  final ServingTurnEntity _self;
  final $Res Function(ServingTurnEntity) _then;

/// Create a copy of ServingTurnEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? prayer = null,Object? joycorner = null,Object? food = null,Object? prayerDate = null,Object? babysitter = null,}) {
  return _then(ServingTurnEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,prayer: null == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as String,joycorner: null == joycorner ? _self.joycorner : joycorner // ignore: cast_nullable_to_non_nullable
as String,food: null == food ? _self.food : food // ignore: cast_nullable_to_non_nullable
as String,prayerDate: null == prayerDate ? _self.prayerDate : prayerDate // ignore: cast_nullable_to_non_nullable
as String,babysitter: null == babysitter ? _self.babysitter : babysitter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServingTurnEntity].
extension ServingTurnEntityPatterns on ServingTurnEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServingTurnEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServingTurnEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServingTurnEntity value)  $default,){
final _that = this;
switch (_that) {
case _ServingTurnEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServingTurnEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ServingTurnEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String prayer,  String joycorner,  String food,  String prayerDate,  String babysitter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServingTurnEntity() when $default != null:
return $default(_that.date,_that.prayer,_that.joycorner,_that.food,_that.prayerDate,_that.babysitter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String prayer,  String joycorner,  String food,  String prayerDate,  String babysitter)  $default,) {final _that = this;
switch (_that) {
case _ServingTurnEntity():
return $default(_that.date,_that.prayer,_that.joycorner,_that.food,_that.prayerDate,_that.babysitter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String prayer,  String joycorner,  String food,  String prayerDate,  String babysitter)?  $default,) {final _that = this;
switch (_that) {
case _ServingTurnEntity() when $default != null:
return $default(_that.date,_that.prayer,_that.joycorner,_that.food,_that.prayerDate,_that.babysitter);case _:
  return null;

}
}

}

/// @nodoc


class _ServingTurnEntity extends ServingTurnEntity {
  const _ServingTurnEntity({required this.date, required this.prayer, this.joycorner = '', this.food = '', this.prayerDate = '', this.babysitter = ''}): super._();
  

@override final  String date;
@override final  String prayer;
@override@JsonKey() final  String joycorner;
@override@JsonKey() final  String food;
@override@JsonKey() final  String prayerDate;
@override@JsonKey() final  String babysitter;

/// Create a copy of ServingTurnEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServingTurnEntityCopyWith<_ServingTurnEntity> get copyWith => __$ServingTurnEntityCopyWithImpl<_ServingTurnEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServingTurnEntity&&(identical(other.date, date) || other.date == date)&&(identical(other.prayer, prayer) || other.prayer == prayer)&&(identical(other.joycorner, joycorner) || other.joycorner == joycorner)&&(identical(other.food, food) || other.food == food)&&(identical(other.prayerDate, prayerDate) || other.prayerDate == prayerDate)&&(identical(other.babysitter, babysitter) || other.babysitter == babysitter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,date,prayer,joycorner,food,prayerDate,babysitter);
}

@override
String toString() {
    return 'ServingTurnEntity(date: $date, prayer: $prayer, joycorner: $joycorner, food: $food, prayerDate: $prayerDate, babysitter: $babysitter)';
}


}

/// @nodoc
abstract mixin class _$ServingTurnEntityCopyWith<$Res> implements $ServingTurnEntityCopyWith<$Res> {
  factory _$ServingTurnEntityCopyWith(_ServingTurnEntity value, $Res Function(_ServingTurnEntity) _then) = __$ServingTurnEntityCopyWithImpl;
@override @useResult
$Res call({
 String date, String prayer, String joycorner, String food, String prayerDate, String babysitter
});




}
/// @nodoc
class __$ServingTurnEntityCopyWithImpl<$Res>
    implements _$ServingTurnEntityCopyWith<$Res> {
  __$ServingTurnEntityCopyWithImpl(this._self, this._then);

  final _ServingTurnEntity _self;
  final $Res Function(_ServingTurnEntity) _then;

/// Create a copy of ServingTurnEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? prayer = null,Object? joycorner = null,Object? food = null,Object? prayerDate = null,Object? babysitter = null,}) {
  return _then(_ServingTurnEntity(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,prayer: null == prayer ? _self.prayer : prayer // ignore: cast_nullable_to_non_nullable
as String,joycorner: null == joycorner ? _self.joycorner : joycorner // ignore: cast_nullable_to_non_nullable
as String,food: null == food ? _self.food : food // ignore: cast_nullable_to_non_nullable
as String,prayerDate: null == prayerDate ? _self.prayerDate : prayerDate // ignore: cast_nullable_to_non_nullable
as String,babysitter: null == babysitter ? _self.babysitter : babysitter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
