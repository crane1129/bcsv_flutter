import 'package:freezed_annotation/freezed_annotation.dart';

part 'serving_turn.freezed.dart';

/// Domain entity for church serving turn schedule
@freezed
class ServingTurnEntity with _$ServingTurnEntity {
  const factory ServingTurnEntity({
    required String date,
    required String prayer,
    @Default('') String joycorner,
    @Default('') String food,
    @Default('') String prayerDate,
    @Default('') String babysitter,
  }) = _ServingTurnEntity;

  const ServingTurnEntity._();

  /// Get formatted serving info
  String get formattedInfo =>
      '기도: $prayer\n조이코너: $joycorner\n음식: $food';
}
