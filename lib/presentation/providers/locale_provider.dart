import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/l10n/l10n.dart';
import 'package:bcsv_flutter_project/domain/repositories/settings_repository.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart';

/// State class for locale settings
class LocaleState {
  final Locale? locale;

  const LocaleState({this.locale});

  LocaleState copyWith({Locale? locale, bool clearLocale = false}) {
    return LocaleState(
      locale: clearLocale ? null : (locale ?? this.locale),
    );
  }
}

/// Notifier for locale state management
class LocaleNotifier extends StateNotifier<LocaleState> {
  final SettingsRepository _repository;

  LocaleNotifier(this._repository) : super(const LocaleState());

  /// Initialize locale from persisted settings
  Future<void> initialize() async {
    final languageCode = await _repository.getLanguageOption();
    if (languageCode != null) {
      final locale = Locale(languageCode);
      if (L10n.all.contains(locale)) {
        state = LocaleState(locale: locale);
      }
    }
  }

  /// Set locale and persist
  Future<void> setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;

    await _repository.setLanguageOption(locale.languageCode);
    state = LocaleState(locale: locale);
  }

  /// Clear locale (use system default)
  void clearLocale() {
    state = const LocaleState(locale: null);
  }
}

/// Provider for locale state
final localeNotifierProvider =
    StateNotifierProvider<LocaleNotifier, LocaleState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return LocaleNotifier(repository);
});

/// Convenience provider for just the Locale
final localeProvider = Provider<Locale?>((ref) {
  return ref.watch(localeNotifierProvider).locale;
});
