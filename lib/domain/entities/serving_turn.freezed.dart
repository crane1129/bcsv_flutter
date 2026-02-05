// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serving_turn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ServingTurnEntity {
  String get date => throw _privateConstructorUsedError;
  String get prayer => throw _privateConstructorUsedError;
  String get joycorner => throw _privateConstructorUsedError;
  String get food => throw _privateConstructorUsedError;
  String get prayerDate => throw _privateConstructorUsedError;
  String get babysitter => throw _privateConstructorUsedError;

  /// Create a copy of ServingTurnEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServingTurnEntityCopyWith<ServingTurnEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServingTurnEntityCopyWith<$Res> {
  factory $ServingTurnEntityCopyWith(
          ServingTurnEntity value, $Res Function(ServingTurnEntity) then) =
      _$ServingTurnEntityCopyWithImpl<$Res, ServingTurnEntity>;
  @useResult
  $Res call(
      {String date,
      String prayer,
      String joycorner,
      String food,
      String prayerDate,
      String babysitter});
}

/// @nodoc
class _$ServingTurnEntityCopyWithImpl<$Res, $Val extends ServingTurnEntity>
    implements $ServingTurnEntityCopyWith<$Res> {
  _$ServingTurnEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServingTurnEntity
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
abstract class _$$ServingTurnEntityImplCopyWith<$Res>
    implements $ServingTurnEntityCopyWith<$Res> {
  factory _$$ServingTurnEntityImplCopyWith(_$ServingTurnEntityImpl value,
          $Res Function(_$ServingTurnEntityImpl) then) =
      __$$ServingTurnEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String prayer,
      String joycorner,
      String food,
      String prayerDate,
      String babysitter});
}

/// @nodoc
class __$$ServingTurnEntityImplCopyWithImpl<$Res>
    extends _$ServingTurnEntityCopyWithImpl<$Res, _$ServingTurnEntityImpl>
    implements _$$ServingTurnEntityImplCopyWith<$Res> {
  __$$ServingTurnEntityImplCopyWithImpl(_$ServingTurnEntityImpl _value,
      $Res Function(_$ServingTurnEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServingTurnEntity
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
    return _then(_$ServingTurnEntityImpl(
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

class _$ServingTurnEntityImpl extends _ServingTurnEntity {
  const _$ServingTurnEntityImpl(
      {required this.date,
      required this.prayer,
      this.joycorner = '',
      this.food = '',
      this.prayerDate = '',
      this.babysitter = ''})
      : super._();

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
  @JsonKey()
  final String prayerDate;
  @override
  @JsonKey()
  final String babysitter;

  @override
  String toString() {
    return 'ServingTurnEntity(date: $date, prayer: $prayer, joycorner: $joycorner, food: $food, prayerDate: $prayerDate, babysitter: $babysitter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServingTurnEntityImpl &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType, date, prayer, joycorner, food, prayerDate, babysitter);

  /// Create a copy of ServingTurnEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServingTurnEntityImplCopyWith<_$ServingTurnEntityImpl> get copyWith =>
      __$$ServingTurnEntityImplCopyWithImpl<_$ServingTurnEntityImpl>(
          this, _$identity);
}

abstract class _ServingTurnEntity extends ServingTurnEntity {
  const factory _ServingTurnEntity(
      {required final String date,
      required final String prayer,
      final String joycorner,
      final String food,
      final String prayerDate,
      final String babysitter}) = _$ServingTurnEntityImpl;
  const _ServingTurnEntity._() : super._();

  @override
  String get date;
  @override
  String get prayer;
  @override
  String get joycorner;
  @override
  String get food;
  @override
  String get prayerDate;
  @override
  String get babysitter;

  /// Create a copy of ServingTurnEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServingTurnEntityImplCopyWith<_$ServingTurnEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
