import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';

part 'serving_turn_model.freezed.dart';
part 'serving_turn_model.g.dart';

/// Data model for serving turn with JSON serialization
@freezed
abstract class ServingTurnModel with _$ServingTurnModel {
  const factory ServingTurnModel({
    required String date,
    required String prayer,
    @Default('') String joycorner,
    @Default('') String food,
    @JsonKey(name: 'tuesday_pray_meeting') @Default('') String prayerDate,
    @Default('') String babysitter,
  }) = _ServingTurnModel;

  const ServingTurnModel._();

  factory ServingTurnModel.fromJson(Map<String, dynamic> json) =>
      _$ServingTurnModelFromJson(json);

  /// Convert to domain entity
  ServingTurnEntity toEntity() {
    return ServingTurnEntity(
      date: date,
      prayer: prayer,
      joycorner: joycorner,
      food: food,
      prayerDate: prayerDate,
      babysitter: babysitter,
    );
  }

  /// Create from domain entity
  factory ServingTurnModel.fromEntity(ServingTurnEntity entity) {
    return ServingTurnModel(
      date: entity.date,
      prayer: entity.prayer,
      joycorner: entity.joycorner,
      food: entity.food,
      prayerDate: entity.prayerDate,
      babysitter: entity.babysitter,
    );
  }
}
