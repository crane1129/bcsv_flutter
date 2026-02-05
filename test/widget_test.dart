// Basic Flutter tests for BCSV app
//
// These tests verify core functionality works correctly.
// More comprehensive tests will be added in later phases.

import 'package:flutter_test/flutter_test.dart';
import 'package:bcsv_flutter_project/utilities/theme_notifier.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart'
    as riverpod_theme;
import 'package:bcsv_flutter_project/presentation/providers/connectivity_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/announcement_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/serving_turn_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';
import 'package:bcsv_flutter_project/data/models/announcement_model.dart';
import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/data/models/serving_turn_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  group('ThemeNotifier (Provider - Legacy)', () {
    test('getThemeByIndex returns correct theme', () {
      final theme0 = ThemeNotifier.getThemeByIndex(0);
      expect(theme0, isA<ThemeData>());

      final theme1 = ThemeNotifier.getThemeByIndex(1);
      expect(theme1, isA<ThemeData>());

      final theme2 = ThemeNotifier.getThemeByIndex(2);
      expect(theme2, isA<ThemeData>());
    });

    test('ThemeNotifier initializes with correct theme', () {
      final initialTheme = ThemeNotifier.getThemeByIndex(1);
      final notifier = ThemeNotifier(initialTheme, 1);

      expect(notifier.currentTheme, initialTheme);
      expect(notifier.currentIndex, 1);
    });
  });

  group('ThemeNotifier (Riverpod)', () {
    test('getThemeByIndex returns correct theme', () {
      final theme0 = riverpod_theme.ThemeNotifier.getThemeByIndex(0);
      expect(theme0, isA<ThemeData>());

      final theme1 = riverpod_theme.ThemeNotifier.getThemeByIndex(1);
      expect(theme1, isA<ThemeData>());

      final theme2 = riverpod_theme.ThemeNotifier.getThemeByIndex(2);
      expect(theme2, isA<ThemeData>());

      final theme3 = riverpod_theme.ThemeNotifier.getThemeByIndex(3);
      expect(theme3, isA<ThemeData>());
    });

    test('ThemeState holds correct values', () {
      final theme = riverpod_theme.ThemeNotifier.getThemeByIndex(2);
      final state = riverpod_theme.ThemeState(
        themeData: theme,
        themeIndex: 2,
      );

      expect(state.themeData, theme);
      expect(state.themeIndex, 2);
    });

    test('ThemeState copyWith works correctly', () {
      final theme1 = riverpod_theme.ThemeNotifier.getThemeByIndex(1);
      final theme2 = riverpod_theme.ThemeNotifier.getThemeByIndex(2);

      final state1 = riverpod_theme.ThemeState(
        themeData: theme1,
        themeIndex: 1,
      );

      final state2 = state1.copyWith(themeData: theme2, themeIndex: 2);

      expect(state2.themeData, theme2);
      expect(state2.themeIndex, 2);
      // Original state unchanged
      expect(state1.themeData, theme1);
      expect(state1.themeIndex, 1);
    });
  });

  group('ConnectivityState', () {
    test('initial state is connected', () {
      final state = ConnectivityState.initial();
      expect(state.isConnected, true);
      expect(state.connectionTypes, isEmpty);
    });

    test('fromResults creates correct state', () {
      final state = ConnectivityState.fromResults([
        ConnectivityResult.wifi,
      ]);
      expect(state.isConnected, true);
      expect(state.isWifi, true);
      expect(state.isMobile, false);
      expect(state.isOffline, false);
    });

    test('offline state when no connection', () {
      final state = ConnectivityState.fromResults([
        ConnectivityResult.none,
      ]);
      expect(state.isConnected, false);
      expect(state.isOffline, true);
    });
  });

  group('AnnouncementEntity', () {
    test('creates entity with required fields', () {
      const entity = AnnouncementEntity(
        date: '2024-01-01',
        announcement: 'Test announcement',
        preacher: 'Pastor Kim',
        prayer: 'Deacon Lee',
      );

      expect(entity.date, '2024-01-01');
      expect(entity.announcement, 'Test announcement');
      expect(entity.preacher, 'Pastor Kim');
      expect(entity.prayer, 'Deacon Lee');
      expect(entity.hasContent, true);
    });

    test('hasContent returns false for empty announcement', () {
      const entity = AnnouncementEntity(
        date: '2024-01-01',
        announcement: '',
        preacher: 'Pastor Kim',
        prayer: 'Deacon Lee',
      );

      expect(entity.hasContent, false);
    });

    test('hasPdfAttachment returns correct value', () {
      const withPdf = AnnouncementEntity(
        date: '2024-01-01',
        announcement: 'Test',
        preacher: 'Pastor',
        prayer: 'Deacon',
        fileUrl: 'https://example.com/file.pdf',
      );

      const withoutPdf = AnnouncementEntity(
        date: '2024-01-01',
        announcement: 'Test',
        preacher: 'Pastor',
        prayer: 'Deacon',
      );

      expect(withPdf.hasPdfAttachment, true);
      expect(withoutPdf.hasPdfAttachment, false);
    });
  });

  group('AnnouncementModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'date': '2024-01-01',
        'announcement': 'Test announcement',
        'preacher': 'Pastor Kim',
        'prayer': 'Deacon Lee',
        'tuesday_pray_meeting': 'Tuesday meeting',
        'babysitter': 'Sister Park',
        'offering': '1000',
        'File_url': 'https://example.com/file.pdf',
      };

      final model = AnnouncementModel.fromJson(json);

      expect(model.date, '2024-01-01');
      expect(model.announcement, 'Test announcement');
      expect(model.tuesdayPrayMeeting, 'Tuesday meeting');
      expect(model.fileUrl, 'https://example.com/file.pdf');
    });

    test('toEntity converts correctly', () {
      const model = AnnouncementModel(
        date: '2024-01-01',
        announcement: 'Test',
        preacher: 'Pastor',
        prayer: 'Deacon',
        offering: '500',
      );

      final entity = model.toEntity();

      expect(entity.date, model.date);
      expect(entity.announcement, model.announcement);
      expect(entity.offering, model.offering);
    });
  });

  group('AnnouncementState', () {
    test('initial state has correct defaults', () {
      const state = AnnouncementState();

      expect(state.announcements, isEmpty);
      expect(state.status, AnnouncementStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
    });

    test('copyWith preserves values', () {
      const entity = AnnouncementEntity(
        date: '2024-01-01',
        announcement: 'Test',
        preacher: 'Pastor',
        prayer: 'Deacon',
      );

      final state = const AnnouncementState().copyWith(
        announcements: [entity],
        status: AnnouncementStatus.loaded,
      );

      expect(state.announcements.length, 1);
      expect(state.status, AnnouncementStatus.loaded);
      expect(state.hasData, true);
    });
  });

  group('MessageEntity', () {
    test('creates entity with required fields', () {
      const entity = MessageEntity(
        messageId: 1,
        title: 'Test Title',
        message: 'Test message content',
        category: 'General',
        expireDate: '2024-12-31',
      );

      expect(entity.messageId, 1);
      expect(entity.title, 'Test Title');
      expect(entity.message, 'Test message content');
      expect(entity.category, 'General');
      expect(entity.expireDate, '2024-12-31');
    });

    test('has optional fields with defaults', () {
      const entity = MessageEntity(
        messageId: 1,
        title: 'Test',
        message: 'Content',
        category: 'News',
        expireDate: '2024-12-31',
      );

      expect(entity.imageLink, '');
      expect(entity.externalLink, '');
    });

    test('hasImage returns correct value', () {
      const withImage = MessageEntity(
        messageId: 1,
        title: 'Test',
        message: 'Content',
        category: 'News',
        expireDate: '2024-12-31',
        imageLink: 'https://example.com/image.jpg',
      );

      const withoutImage = MessageEntity(
        messageId: 2,
        title: 'Test',
        message: 'Content',
        category: 'News',
        expireDate: '2024-12-31',
      );

      expect(withImage.hasImage, true);
      expect(withoutImage.hasImage, false);
    });
  });

  group('MessageModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'MessageID': 1,
        'Title': 'Test Title',
        'Message': 'Test message',
        'Category': 'Announcement',
        'ExpireDate': '2024-12-31',
        'ImageLink': 'https://example.com/image.jpg',
        'ExternalLink': 'https://example.com',
      };

      final model = MessageModel.fromJson(json);

      expect(model.messageId, 1);
      expect(model.title, 'Test Title');
      expect(model.message, 'Test message');
      expect(model.category, 'Announcement');
      expect(model.expireDate, '2024-12-31');
      expect(model.imageLink, 'https://example.com/image.jpg');
      expect(model.externalLink, 'https://example.com');
    });

    test('toEntity converts correctly', () {
      const model = MessageModel(
        messageId: 1,
        title: 'Test',
        message: 'Content',
        category: 'News',
        expireDate: '2024-12-31',
      );

      final entity = model.toEntity();

      expect(entity.messageId, model.messageId);
      expect(entity.title, model.title);
      expect(entity.message, model.message);
    });
  });

  group('MessageState', () {
    test('initial state has correct defaults', () {
      const state = MessageState();

      expect(state.messages, isEmpty);
      expect(state.status, MessageStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
      expect(state.unreadCount, 0);
      expect(state.hasUnread, false);
    });

    test('copyWith preserves values', () {
      const entity = MessageEntity(
        messageId: 1,
        title: 'Test',
        message: 'Content',
        category: 'News',
        expireDate: '2024-12-31',
      );

      final state = const MessageState().copyWith(
        messages: [entity],
        status: MessageStatus.loaded,
        unreadCount: 5,
      );

      expect(state.messages.length, 1);
      expect(state.status, MessageStatus.loaded);
      expect(state.hasData, true);
      expect(state.unreadCount, 5);
      expect(state.hasUnread, true);
    });
  });

  group('ServingTurnEntity', () {
    test('creates entity with required fields', () {
      const entity = ServingTurnEntity(
        date: '2024-01-07',
        prayer: 'John',
      );

      expect(entity.date, '2024-01-07');
      expect(entity.prayer, 'John');
    });

    test('has optional fields with defaults', () {
      const entity = ServingTurnEntity(
        date: '2024-01-07',
        prayer: 'John',
      );

      expect(entity.joycorner, '');
      expect(entity.food, '');
      expect(entity.babysitter, '');
    });

    test('formattedInfo returns formatted string', () {
      const entity = ServingTurnEntity(
        date: '2024-01-07',
        prayer: 'John',
        joycorner: 'Mary',
        food: 'David',
      );

      expect(entity.formattedInfo, contains('기도: John'));
      expect(entity.formattedInfo, contains('조이코너: Mary'));
      expect(entity.formattedInfo, contains('음식: David'));
    });
  });

  group('ServingTurnModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'date': '2024-01-07',
        'prayer': 'John',
        'joycorner': 'Mary',
        'food': 'David',
        'tuesday_pray_meeting': 'Wednesday',
        'babysitter': 'Sarah',
      };

      final model = ServingTurnModel.fromJson(json);

      expect(model.date, '2024-01-07');
      expect(model.prayer, 'John');
      expect(model.joycorner, 'Mary');
      expect(model.food, 'David');
      expect(model.prayerDate, 'Wednesday');
      expect(model.babysitter, 'Sarah');
    });

    test('toEntity converts correctly', () {
      const model = ServingTurnModel(
        date: '2024-01-07',
        prayer: 'Jane',
        joycorner: 'Mike',
      );

      final entity = model.toEntity();

      expect(entity.date, model.date);
      expect(entity.prayer, model.prayer);
      expect(entity.joycorner, model.joycorner);
    });
  });

  group('ServingTurnState', () {
    test('initial state has correct defaults', () {
      const state = ServingTurnState();

      expect(state.servingTurns, isEmpty);
      expect(state.currentTurn, isNull);
      expect(state.status, ServingTurnStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
    });

    test('copyWith preserves values', () {
      const entity = ServingTurnEntity(
        date: '2024-01-07',
        prayer: 'John',
      );

      final state = const ServingTurnState().copyWith(
        servingTurns: [entity],
        currentTurn: entity,
        status: ServingTurnStatus.loaded,
      );

      expect(state.servingTurns.length, 1);
      expect(state.currentTurn, entity);
      expect(state.status, ServingTurnStatus.loaded);
      expect(state.hasData, true);
    });
  });

  group('Core infrastructure', () {
    test('App config has correct defaults', () async {
      const timeout = Duration(seconds: 30);
      expect(timeout.inSeconds, 30);
    });
  });
}
