// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serving_turn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServingTurnModel _$ServingTurnModelFromJson(Map<String, dynamic> json) =>
    _ServingTurnModel(
      date: json['date'] as String,
      prayer: json['prayer'] as String,
      joycorner: json['joycorner'] as String? ?? '',
      food: json['food'] as String? ?? '',
      prayerDate: json['tuesday_pray_meeting'] as String? ?? '',
      babysitter: json['babysitter'] as String? ?? '',
    );

Map<String, dynamic> _$ServingTurnModelToJson(_ServingTurnModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'prayer': instance.prayer,
      'joycorner': instance.joycorner,
      'food': instance.food,
      'tuesday_pray_meeting': instance.prayerDate,
      'babysitter': instance.babysitter,
    };
