// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serving_turn_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServingTurnModel {

 String get date; String get prayer; String get joycorner; String get food;@JsonKey(name: 'tuesday_pray_meeting') String get prayerDate; String get babysitter;
/// Create a copy of ServingTurnModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServingTurnModelCopyWith<ServingTurnModel> get copyWith => _$ServingTurnModelCopyWithImpl<ServingTurnModel>(this as ServingTurnModel, _$identity);

  /// Serializes this ServingTurnModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServingTurnModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServingTurnModel&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.prayer, _this.prayer) || other.prayer == _this.prayer)&&(identical(other.joycorner, _this.joycorner) || other.joycorner == _this.joycorner)&&(identical(other.food, _this.food) || other.food == _this.food)&&(identical(other.prayerDate, _this.prayerDate) || other.prayerDate == _this.prayerDate)&&(identical(other.babysitter, _this.babysitter) || other.babysitter == _this.babysitter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServingTurnModel;
  return Object.hash(runtimeType,_this.date,_this.prayer,_this.joycorner,_this.food,_this.prayerDate,_this.babysitter);
}

@override
String toString() {
  final _this = this as ServingTurnModel;
  return 'ServingTurnModel(date: ${_this.date}, prayer: ${_this.prayer}, joycorner: ${_this.joycorner}, food: ${_this.food}, prayerDate: ${_this.prayerDate}, babysitter: ${_this.babysitter})';
}


}

/// @nodoc
abstract mixin class $ServingTurnModelCopyWith<$Res>  {
  factory $ServingTurnModelCopyWith(ServingTurnModel value, $Res Function(ServingTurnModel) _then) = _$ServingTurnModelCopyWithImpl;
@useResult
$Res call({
 String date, String prayer, String joycorner, String food,@JsonKey(name: 'tuesday_pray_meeting') String prayerDate, String babysitter
});




}
/// @nodoc
class _$ServingTurnModelCopyWithImpl<$Res>
    implements $ServingTurnModelCopyWith<$Res> {
  _$ServingTurnModelCopyWithImpl(this._self, this._then);

  final ServingTurnModel _self;
  final $Res Function(ServingTurnModel) _then;

/// Create a copy of ServingTurnModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? prayer = null,Object? joycorner = null,Object? food = null,Object? prayerDate = null,Object? babysitter = null,}) {
  return _then(ServingTurnModel(
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


/// Adds pattern-matching-related methods to [ServingTurnModel].
extension ServingTurnModelPatterns on ServingTurnModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServingTurnModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServingTurnModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServingTurnModel value)  $default,){
final _that = this;
switch (_that) {
case _ServingTurnModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServingTurnModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServingTurnModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String prayer,  String joycorner,  String food, @JsonKey(name: 'tuesday_pray_meeting')  String prayerDate,  String babysitter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServingTurnModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String prayer,  String joycorner,  String food, @JsonKey(name: 'tuesday_pray_meeting')  String prayerDate,  String babysitter)  $default,) {final _that = this;
switch (_that) {
case _ServingTurnModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String prayer,  String joycorner,  String food, @JsonKey(name: 'tuesday_pray_meeting')  String prayerDate,  String babysitter)?  $default,) {final _that = this;
switch (_that) {
case _ServingTurnModel() when $default != null:
return $default(_that.date,_that.prayer,_that.joycorner,_that.food,_that.prayerDate,_that.babysitter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServingTurnModel extends ServingTurnModel {
  const _ServingTurnModel({required this.date, required this.prayer, this.joycorner = '', this.food = '', @JsonKey(name: 'tuesday_pray_meeting') this.prayerDate = '', this.babysitter = ''}): super._();
  factory _ServingTurnModel.fromJson(Map<String, dynamic> json) => _$ServingTurnModelFromJson(json);

@override final  String date;
@override final  String prayer;
@override@JsonKey() final  String joycorner;
@override@JsonKey() final  String food;
@override@JsonKey(name: 'tuesday_pray_meeting') final  String prayerDate;
@override@JsonKey() final  String babysitter;

/// Create a copy of ServingTurnModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServingTurnModelCopyWith<_ServingTurnModel> get copyWith => __$ServingTurnModelCopyWithImpl<_ServingTurnModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServingTurnModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServingTurnModel&&(identical(other.date, date) || other.date == date)&&(identical(other.prayer, prayer) || other.prayer == prayer)&&(identical(other.joycorner, joycorner) || other.joycorner == joycorner)&&(identical(other.food, food) || other.food == food)&&(identical(other.prayerDate, prayerDate) || other.prayerDate == prayerDate)&&(identical(other.babysitter, babysitter) || other.babysitter == babysitter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,date,prayer,joycorner,food,prayerDate,babysitter);
}

@override
String toString() {
    return 'ServingTurnModel(date: $date, prayer: $prayer, joycorner: $joycorner, food: $food, prayerDate: $prayerDate, babysitter: $babysitter)';
}


}

/// @nodoc
abstract mixin class _$ServingTurnModelCopyWith<$Res> implements $ServingTurnModelCopyWith<$Res> {
  factory _$ServingTurnModelCopyWith(_ServingTurnModel value, $Res Function(_ServingTurnModel) _then) = __$ServingTurnModelCopyWithImpl;
@override @useResult
$Res call({
 String date, String prayer, String joycorner, String food,@JsonKey(name: 'tuesday_pray_meeting') String prayerDate, String babysitter
});




}
/// @nodoc
class __$ServingTurnModelCopyWithImpl<$Res>
    implements _$ServingTurnModelCopyWith<$Res> {
  __$ServingTurnModelCopyWithImpl(this._self, this._then);

  final _ServingTurnModel _self;
  final $Res Function(_ServingTurnModel) _then;

/// Create a copy of ServingTurnModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? prayer = null,Object? joycorner = null,Object? food = null,Object? prayerDate = null,Object? babysitter = null,}) {
  return _then(_ServingTurnModel(
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
