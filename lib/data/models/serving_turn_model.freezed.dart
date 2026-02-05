// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serving_turn_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServingTurnModel _$ServingTurnModelFromJson(Map<String, dynamic> json) {
  return _ServingTurnModel.fromJson(json);
}

/// @nodoc
mixin _$ServingTurnModel {
  String get date => throw _privateConstructorUsedError;
  String get prayer => throw _privateConstructorUsedError;
  String get joycorner => throw _privateConstructorUsedError;
  String get food => throw _privateConstructorUsedError;
  @JsonKey(name: 'tuesday_pray_meeting')
  String get prayerDate => throw _privateConstructorUsedError;
  String get babysitter => throw _privateConstructorUsedError;

  /// Serializes this ServingTurnModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServingTurnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServingTurnModelCopyWith<ServingTurnModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServingTurnModelCopyWith<$Res> {
  factory $ServingTurnModelCopyWith(
          ServingTurnModel value, $Res Function(ServingTurnModel) then) =
      _$ServingTurnModelCopyWithImpl<$Res, ServingTurnModel>;
  @useResult
  $Res call(
      {String date,
      String prayer,
      String joycorner,
      String food,
      @JsonKey(name: 'tuesday_pray_meeting') String prayerDate,
      String babysitter});
}

/// @nodoc
class _$ServingTurnModelCopyWithImpl<$Res, $Val extends ServingTurnModel>
    implements $ServingTurnModelCopyWith<$Res> {
  _$ServingTurnModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServingTurnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? prayer = null,
    Object? joycorner = null,
    Object? food = null,
    Object? prayerDate = null,
    Object? babysitter = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      prayer: null == prayer
          ? _value.prayer
          : prayer // ignore: cast_nullable_to_non_nullable
              as String,
      joycorner: null == joycorner
          ? _value.joycorner
          : joycorner // ignore: cast_nullable_to_non_nullable
              as String,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as String,
      prayerDate: null == prayerDate
          ? _value.prayerDate
          : prayerDate // ignore: cast_nullable_to_non_nullable
              as String,
      babysitter: null == babysitter
          ? _value.babysitter
          : babysitter // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServingTurnModelImplCopyWith<$Res>
    implements $ServingTurnModelCopyWith<$Res> {
  factory _$$ServingTurnModelImplCopyWith(_$ServingTurnModelImpl value,
          $Res Function(_$ServingTurnModelImpl) then) =
      __$$ServingTurnModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String prayer,
      String joycorner,
      String food,
      @JsonKey(name: 'tuesday_pray_meeting') String prayerDate,
      String babysitter});
}

/// @nodoc
class __$$ServingTurnModelImplCopyWithImpl<$Res>
    extends _$ServingTurnModelCopyWithImpl<$Res, _$ServingTurnModelImpl>
    implements _$$ServingTurnModelImplCopyWith<$Res> {
  __$$ServingTurnModelImplCopyWithImpl(_$ServingTurnModelImpl _value,
      $Res Function(_$ServingTurnModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServingTurnModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? prayer = null,
    Object? joycorner = null,
    Object? food = null,
    Object? prayerDate = null,
    Object? babysitter = null,
  }) {
    return _then(_$ServingTurnModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      prayer: null == prayer
          ? _value.prayer
          : prayer // ignore: cast_nullable_to_non_nullable
              as String,
      joycorner: null == joycorner
          ? _value.joycorner
          : joycorner // ignore: cast_nullable_to_non_nullable
              as String,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as String,
      prayerDate: null == prayerDate
          ? _value.prayerDate
          : prayerDate // ignore: cast_nullable_to_non_nullable
              as String,
      babysitter: null == babysitter
          ? _value.babysitter
          : babysitter // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServingTurnModelImpl extends _ServingTurnModel {
  const _$ServingTurnModelImpl(
      {required this.date,
      required this.prayer,
      this.joycorner = '',
      this.food = '',
      @JsonKey(name: 'tuesday_pray_meeting') this.prayerDate = '',
      this.babysitter = ''})
      : super._();

  factory _$ServingTurnModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServingTurnModelImplFromJson(json);

  @override
  final String date;
  @override
  final String prayer;
  @override
  @JsonKey()
  final String joycorner;
  @override
  @JsonKey()
  final String food;
  @override
  @JsonKey(name: 'tuesday_pray_meeting')
  final String prayerDate;
  @override
  @JsonKey()
  final String babysitter;

  @override
  String toString() {
    return 'ServingTurnModel(date: $date, prayer: $prayer, joycorner: $joycorner, food: $food, prayerDate: $prayerDate, babysitter: $babysitter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServingTurnModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.prayer, prayer) || other.prayer == prayer) &&
            (identical(other.joycorner, joycorner) ||
                other.joycorner == joycorner) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.prayerDate, prayerDate) ||
                other.prayerDate == prayerDate) &&
            (identical(other.babysitter, babysitter) ||
                other.babysitter == babysitter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, prayer, joycorner, food, prayerDate, babysitter);

  /// Create a copy of ServingTurnModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServingTurnModelImplCopyWith<_$ServingTurnModelImpl> get copyWith =>
      __$$ServingTurnModelImplCopyWithImpl<_$ServingTurnModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServingTurnModelImplToJson(
      this,
    );
  }
}

abstract class _ServingTurnModel extends ServingTurnModel {
  const factory _ServingTurnModel(
      {required final String date,
      required final String prayer,
      final String joycorner,
      final String food,
      @JsonKey(name: 'tuesday_pray_meeting') final String prayerDate,
      final String babysitter}) = _$ServingTurnModelImpl;
  const _ServingTurnModel._() : super._();

  factory _ServingTurnModel.fromJson(Map<String, dynamic> json) =
      _$ServingTurnModelImpl.fromJson;

  @override
  String get date;
  @override
  String get prayer;
  @override
  String get joycorner;
  @override
  String get food;
  @override
  @JsonKey(name: 'tuesday_pray_meeting')
  String get prayerDate;
  @override
  String get babysitter;

  /// Create a copy of ServingTurnModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServingTurnModelImplCopyWith<_$ServingTurnModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
