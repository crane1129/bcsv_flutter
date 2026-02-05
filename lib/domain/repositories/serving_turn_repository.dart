import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';

/// Repository interface for serving turn data access
abstract class ServingTurnRepository {
  /// Get all serving turns
  Future<List<ServingTurnEntity>> getServingTurns({bool forceRefresh = false});

  /// Get cached serving turns only (for offline use)
  Future<List<ServingTurnEntity>?> getCachedServingTurns();

  /// Check if cached serving turns are available and valid
  Future<bool> hasCachedServingTurns();

  /// Clear serving turn cache
  Future<void> clearCache();

  /// Get the timestamp of when serving turns were last updated
  DateTime? getLastUpdated();

  /// Get current week's serving turn
  ServingTurnEntity? getCurrentServingTurn(List<ServingTurnEntity> servingTurns);
}
