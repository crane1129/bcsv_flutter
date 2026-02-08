import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/presentation/providers/serving_turn_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/sunday_bible_text_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/daily_bible_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/keyverse_provider.dart';
import 'dart:developer';

void main() {
  group('Provider Diagnostic Tests', () {
    test('ServingTurnProvider initializes correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(servingTurnNotifierProvider);

      expect(state.servingTurns, isEmpty);
      expect(state.isLoading, false);
      expect(state.hasError, false);

      log('✅ ServingTurnProvider initialized correctly');
    });

    test('SundayBibleTextProvider initializes correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(sundayBibleTextNotifierProvider);

      expect(state.texts, isEmpty);
      expect(state.isLoading, false);
      expect(state.hasError, false);

      log('✅ SundayBibleTextProvider initialized correctly');
    });

    test('DailyBibleProvider initializes correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(dailyBibleNotifierProvider);

      expect(state.dailyBible, isNull);
      expect(state.isLoading, false);
      expect(state.hasError, false);

      log('✅ DailyBibleProvider initialized correctly');
    });

    test('KeyVerseProvider initializes correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(keyVerseNotifierProvider);

      expect(state.keyVerse, isNull);
      expect(state.isLoading, false);
      expect(state.hasError, false);

      log('✅ KeyVerseProvider initialized correctly');
    });

    test('All repository providers are accessible', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Test that all repository providers can be read without error
      expect(() => container.read(servingTurnRepositoryProvider), returnsNormally);
      expect(() => container.read(sundayBibleTextRepositoryProvider), returnsNormally);
      expect(() => container.read(dailyBibleRepositoryProvider), returnsNormally);
      expect(() => container.read(keyVerseRepositoryProvider), returnsNormally);

      log('✅ All repository providers are accessible');
    });
  });
}
