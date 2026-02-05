import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/utilities/themes.dart';
import 'package:bcsv_flutter_project/domain/repositories/settings_repository.dart';
import 'package:bcsv_flutter_project/data/repositories/settings_repository_impl.dart';

/// State class for theme settings
class ThemeState {
  final ThemeData themeData;
  final int themeIndex;

  const ThemeState({
    required this.themeData,
    required this.themeIndex,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    int? themeIndex,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      themeIndex: themeIndex ?? this.themeIndex,
    );
  }
}

/// Notifier for theme state management
class ThemeNotifier extends StateNotifier<ThemeState> {
  final SettingsRepository _repository;

  ThemeNotifier(this._repository)
      : super(ThemeState(
          themeData: lightTheme,
          themeIndex: 0,
        ));

  /// Initialize theme from persisted settings
  Future<void> initialize() async {
    final index = await _repository.getThemeIndex();
    state = ThemeState(
      themeData: _getThemeByIndex(index),
      themeIndex: index,
    );
  }

  /// Set theme by index and persist
  Future<void> setThemeByIndex(int index) async {
    await _repository.setThemeIndex(index);
    state = ThemeState(
      themeData: _getThemeByIndex(index),
      themeIndex: index,
    );
  }

  /// Get ThemeData by index
  static ThemeData _getThemeByIndex(int index) {
    switch (index) {
      case 1:
        return darkTheme;
      case 2:
        return sepiaTheme;
      case 3:
        return midnightBlueTheme;
      default:
        return lightTheme;
    }
  }

  /// Static helper for getting theme without state (for initial load)
  static ThemeData getThemeByIndex(int index) => _getThemeByIndex(index);
}

/// Provider for settings repository
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});

/// Provider for theme state
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return ThemeNotifier(repository);
});

/// Convenience provider for just the ThemeData
final themeDataProvider = Provider<ThemeData>((ref) {
  return ref.watch(themeNotifierProvider).themeData;
});

/// Convenience provider for just the theme index
final themeIndexProvider = Provider<int>((ref) {
  return ref.watch(themeNotifierProvider).themeIndex;
});
