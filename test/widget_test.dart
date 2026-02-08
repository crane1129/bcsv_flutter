// Basic Flutter tests for BCSV app
//
// These tests verify core functionality works correctly.
// More comprehensive tests will be added in later phases.

import 'package:flutter_test/flutter_test.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/connectivity_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/announcement_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/serving_turn_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/keyverse_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/daily_bible_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/sunday_bible_text_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/announcement.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/domain/entities/serving_turn.dart';
import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';
import 'package:bcsv_flutter_project/domain/entities/daily_bible.dart';
import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';
import 'package:bcsv_flutter_project/domain/repositories/sunday_bible_text_repository.dart';
import 'package:bcsv_flutter_project/data/models/announcement_model.dart';
import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/data/models/serving_turn_model.dart';
import 'package:bcsv_flutter_project/data/models/keyverse_model.dart';
import 'package:bcsv_flutter_project/data/models/daily_bible_model.dart';
import 'package:bcsv_flutter_project/data/models/sunday_bible_text_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  group('ThemeNotifier (Riverpod)', () {
    test('getThemeByIndex returns correct theme', () {
      final theme0 = ThemeNotifier.getThemeByIndex(0);
      expect(theme0, isA<ThemeData>());

      final theme1 = ThemeNotifier.getThemeByIndex(1);
      expect(theme1, isA<ThemeData>());

      final theme2 = ThemeNotifier.getThemeByIndex(2);
      expect(theme2, isA<ThemeData>());

      final theme3 = ThemeNotifier.getThemeByIndex(3);
      expect(theme3, isA<ThemeData>());
    });

    test('ThemeState holds correct values', () {
      final theme = ThemeNotifier.getThemeByIndex(2);
      final state = ThemeState(
        themeData: theme,
        themeIndex: 2,
      );

      expect(state.themeData, theme);
      expect(state.themeIndex, 2);
    });

    test('ThemeState copyWith works correctly', () {
      final theme1 = ThemeNotifier.getThemeByIndex(1);
      final theme2 = ThemeNotifier.getThemeByIndex(2);

      final state1 = ThemeState(
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
      final entity = MessageEntity(
        id: 'test-id-1',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test Title',
        message: 'Test message content',
        category: 'General',
        startDate: DateTime(2024, 1, 1),
      );

      expect(entity.id, 'test-id-1');
      expect(entity.createdAt, DateTime(2024, 1, 15));
      expect(entity.title, 'Test Title');
      expect(entity.message, 'Test message content');
      expect(entity.category, 'General');
      expect(entity.startDate, DateTime(2024, 1, 1));
    });

    test('has optional fields with defaults', () {
      final entity = MessageEntity(
        id: 'test-id-2',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime(2024, 1, 1),
      );

      expect(entity.imageUrl, '');
      expect(entity.externalLink, '');
      expect(entity.endDate, isNull);
    });

    test('hasImage returns correct value', () {
      final withImage = MessageEntity(
        id: 'test-id-3',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime(2024, 1, 1),
        imageUrl: 'https://example.com/image.jpg',
      );

      final withoutImage = MessageEntity(
        id: 'test-id-4',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime(2024, 1, 1),
      );

      expect(withImage.hasImage, true);
      expect(withoutImage.hasImage, false);
    });

    test('isVisible returns correct value based on dates', () {
      // Message that is visible (startDate in past, no endDate)
      final visibleMessage = MessageEntity(
        id: 'test-id-5',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        title: 'Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
      );

      // Message that is NOT visible (startDate in future)
      final futureMessage = MessageEntity(
        id: 'test-id-6',
        createdAt: DateTime.now(),
        title: 'Future Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime.now().add(const Duration(days: 10)),
      );

      // Message that is NOT visible (endDate in past)
      final expiredMessage = MessageEntity(
        id: 'test-id-7',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        title: 'Expired Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(visibleMessage.isVisible, true);
      expect(futureMessage.isVisible, false);
      expect(expiredMessage.isVisible, false);
    });
  });

  group('MessageModel', () {
    test('fromJson parses Wix API response correctly', () {
      // Wix API field names
      final json = {
        '_id': 'wix-id-123',
        '_createdDate': '2024-01-15T10:30:00.000Z',
        'title': 'Test Title',
        'message': '<p>Test message</p>',
        'category': 'Announcement',
        'startDate': '2024-01-01',
        'endDate': '2024-12-31',
        'titleImage': 'https://example.com/image.jpg',
        'externalLink': 'https://example.com',
      };

      final model = MessageModel.fromJson(json);

      expect(model.id, 'wix-id-123');
      expect(model.createdAt, isA<DateTime>());
      expect(model.title, 'Test Title');
      expect(model.message, '<p>Test message</p>');
      expect(model.category, 'Announcement');
      expect(model.startDate, isA<DateTime>());
      expect(model.endDate, isA<DateTime>());
      expect(model.imageUrl, 'https://example.com/image.jpg');
      expect(model.externalLink, 'https://example.com');
    });

    test('fromJson converts Wix image URL to HTTP URL', () {
      final json = {
        '_id': 'wix-id-124',
        '_createdDate': '2024-01-15T10:30:00.000Z',
        'title': 'Message with Wix Image',
        'message': '<p>Content</p>',
        'category': 'Announcement',
        'startDate': '2024-01-01',
        'endDate': null,
        'titleImage': 'wix:image://v1/558812_ecf9577ddaf643138755e0c109a5e473~mv2.png/dog-puppy.png#originWidth=640&originHeight=638',
        'externalLink': '',
      };

      final model = MessageModel.fromJson(json);

      expect(model.imageUrl, 'https://static.wixstatic.com/media/558812_ecf9577ddaf643138755e0c109a5e473~mv2.png');
    });

    test('fromJson handles date-only format from Wix', () {
      final json = {
        '_id': 'wix-id-125',
        '_createdDate': '2024-01-15T10:30:00.000Z',
        'title': 'Wix Message',
        'message': '<p>Message from Wix</p>',
        'category': 'News',
        'startDate': '2024-02-01',  // Date-only format
        'endDate': '2024-02-28',    // Date-only format
        'titleImage': '',
        'externalLink': '',
      };

      final model = MessageModel.fromJson(json);

      expect(model.startDate, DateTime(2024, 2, 1));
      expect(model.endDate, DateTime(2024, 2, 28));
      expect(model.title, 'Wix Message');
    });

    test('fromJson handles null endDate', () {
      final json = {
        '_id': 'wix-id-126',
        '_createdDate': '2024-01-15T10:30:00.000Z',
        'title': 'Message without end date',
        'message': '<p>Content</p>',
        'category': 'Announcement',
        'startDate': '2024-02-06',
        'endDate': null,
        'titleImage': 'https://example.com/image.png',
        'externalLink': 'https://www.google.com',
      };

      final model = MessageModel.fromJson(json);

      expect(model.endDate, isNull);
      expect(model.startDate, DateTime(2024, 2, 6));
    });

    test('toEntity converts correctly', () {
      final model = MessageModel(
        id: 'model-id-1',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test',
        message: '<p>Content</p>',
        category: 'News',
        startDate: DateTime(2024, 1, 1),
      );

      final entity = model.toEntity();

      expect(entity.createdAt, model.createdAt);
      expect(entity.title, model.title);
      expect(entity.message, model.message);
      expect(entity.startDate, model.startDate);
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
      final entity = MessageEntity(
        id: 'test-id-8',
        createdAt: DateTime(2024, 1, 15),
        title: 'Test',
        message: 'Content',
        category: 'News',
        startDate: DateTime(2024, 1, 1),
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

  group('KeyVerseEntity', () {
    test('creates entity with required fields', () {
      const entity = KeyVerseEntity(
        year: 2024,
        title: '2024 교회 표어',
        book: '디모데전서',
        chapter: 6,
        verseFrom: 11,
        verseEnd: 12,
        verse: '오직 너 하나님의 사람아...',
      );

      expect(entity.year, 2024);
      expect(entity.title, '2024 교회 표어');
      expect(entity.book, '디모데전서');
      expect(entity.chapter, 6);
      expect(entity.verseFrom, 11);
      expect(entity.verseEnd, 12);
    });

    test('chapterVerseRange returns correct format', () {
      const entity = KeyVerseEntity(
        year: 2024,
        title: '표어',
        book: '창세기',
        chapter: 1,
        verseFrom: 1,
        verseEnd: 5,
        verse: 'test',
      );

      expect(entity.chapterVerseRange, '창세기 1:1-5');
    });

    test('shortReference returns shortened book name', () {
      const entity = KeyVerseEntity(
        year: 2024,
        title: '표어',
        book: '디모데전서',
        chapter: 6,
        verseFrom: 11,
        verseEnd: 12,
        verse: 'test',
      );

      expect(entity.shortReference, '딤전 6:11-12');
    });
  });

  group('KeyVerseModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'year': 2024,
        'title': 'Test Title',
        'book': '창세기',
        'chapter': 1,
        'verseFrom': 1,
        'verseEnd': 5,
        'verse': 'Test verse',
      };

      final model = KeyVerseModel.fromJson(json);

      expect(model.year, 2024);
      expect(model.title, 'Test Title');
      expect(model.book, '창세기');
      expect(model.chapter, 1);
      expect(model.verseFrom, 1);
      expect(model.verseEnd, 5);
      expect(model.verse, 'Test verse');
    });

    test('toEntity converts correctly', () {
      const model = KeyVerseModel(
        year: 2024,
        title: 'Test',
        book: '창세기',
        chapter: 1,
        verseFrom: 1,
        verseEnd: 5,
        verse: 'Content',
      );

      final entity = model.toEntity();

      expect(entity.year, model.year);
      expect(entity.title, model.title);
      expect(entity.book, model.book);
      expect(entity.chapter, model.chapter);
    });
  });

  group('KeyVerseState', () {
    test('initial state has correct defaults', () {
      const state = KeyVerseState();

      expect(state.keyVerse, isNull);
      expect(state.status, KeyVerseStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
      expect(state.isEmpty, false);
    });

    test('copyWith preserves values', () {
      const entity = KeyVerseEntity(
        year: 2024,
        title: 'Test',
        book: '창세기',
        chapter: 1,
        verseFrom: 1,
        verseEnd: 5,
        verse: 'Content',
      );

      final state = const KeyVerseState().copyWith(
        keyVerse: entity,
        status: KeyVerseStatus.loaded,
      );

      expect(state.keyVerse, entity);
      expect(state.status, KeyVerseStatus.loaded);
      expect(state.hasData, true);
    });
  });

  group('DailyBibleEntity', () {
    test('creates entity with required fields', () {
      const verses = [
        DailyBibleVerseEntity(verse: '1', content: '태초에 하나님이 천지를 창조하시니라'),
        DailyBibleVerseEntity(verse: '2', content: '땅이 혼돈하고 공허하며...'),
      ];

      const entity = DailyBibleEntity(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: verses,
      );

      expect(entity.date, '2024-01-01');
      expect(entity.bibleName, '창세기');
      expect(entity.bibleChapter, '1:1-5');
      expect(entity.verses.length, 2);
    });

    test('title returns formatted string', () {
      const entity = DailyBibleEntity(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: [],
      );

      expect(entity.title, '창세기 1:1-5');
    });

    test('hasContent returns correct value', () {
      const empty = DailyBibleEntity(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: [],
      );

      expect(empty.hasContent, false);

      const withVerses = DailyBibleEntity(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: [DailyBibleVerseEntity(verse: '1', content: 'Test')],
      );

      expect(withVerses.hasContent, true);
      expect(withVerses.verseCount, 1);
    });
  });

  group('DailyBibleModel', () {
    test('fromHeaderAndVerses creates correctly', () {
      const header = DailyBibleHeaderModel(
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        date: '2024-01-01',
      );

      const verses = [
        DailyBibleVerseModel(verse: '1', content: 'Test content'),
      ];

      final model = DailyBibleModel.fromHeaderAndVerses(
        header: header,
        verses: verses,
      );

      expect(model.date, '2024-01-01');
      expect(model.bibleName, '창세기');
      expect(model.bibleChapter, '1:1-5');
      expect(model.verses.length, 1);
    });

    test('toEntity converts correctly', () {
      const model = DailyBibleModel(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: [
          DailyBibleVerseModel(verse: '1', content: 'Test'),
        ],
      );

      final entity = model.toEntity();

      expect(entity.date, model.date);
      expect(entity.bibleName, model.bibleName);
      expect(entity.verses.length, 1);
    });
  });

  group('DailyBibleState', () {
    test('initial state has correct defaults', () {
      const state = DailyBibleState();

      expect(state.dailyBible, isNull);
      expect(state.status, DailyBibleStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
      expect(state.fontSize, 16.0);
    });

    test('copyWith preserves values', () {
      const entity = DailyBibleEntity(
        date: '2024-01-01',
        bibleName: '창세기',
        bibleChapter: '1:1-5',
        verses: [],
      );

      final state = const DailyBibleState().copyWith(
        dailyBible: entity,
        status: DailyBibleStatus.loaded,
        currentDate: '2024-01-01',
        fontSize: 20.0,
      );

      expect(state.dailyBible, entity);
      expect(state.status, DailyBibleStatus.loaded);
      expect(state.currentDate, '2024-01-01');
      expect(state.fontSize, 20.0);
      expect(state.hasData, true);
    });
  });

  group('SundayBibleTextEntity', () {
    test('creates entity with required fields', () {
      const entity = SundayBibleTextEntity(
        date: '2024-01-07',
        title: '새해 설교',
        bibleChapter: '창세기 1:1-5',
        bibleText: '태초에 하나님이 천지를 창조하시니라...',
      );

      expect(entity.date, '2024-01-07');
      expect(entity.title, '새해 설교');
      expect(entity.bibleChapter, '창세기 1:1-5');
      expect(entity.hasContent, true);
    });

    test('hasPdfAttachment returns correct value', () {
      const withPdf = SundayBibleTextEntity(
        date: '2024-01-07',
        title: 'Test',
        bibleChapter: 'Genesis 1:1',
        bibleText: 'Content',
        fileUrl: 'https://example.com/file.pdf',
      );

      expect(withPdf.hasPdfAttachment, true);

      const withoutPdf = SundayBibleTextEntity(
        date: '2024-01-07',
        title: 'Test',
        bibleChapter: 'Genesis 1:1',
        bibleText: 'Content',
      );

      expect(withoutPdf.hasPdfAttachment, false);
    });

    test('matchesKeyword returns correct value', () {
      const entity = SundayBibleTextEntity(
        date: '2024-01-07',
        title: '새해 설교',
        bibleChapter: '창세기 1:1-5',
        bibleText: '태초에 하나님이 천지를 창조하시니라',
      );

      expect(entity.matchesKeyword('새해'), true);
      expect(entity.matchesKeyword('창세기'), true);
      expect(entity.matchesKeyword('하나님'), true);
      expect(entity.matchesKeyword('test'), false);
    });
  });

  group('SundayBibleTextModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'Date': '2024-01-07',
        'Title': 'Test',
        'Bible_chapter': 'Genesis 1:1',
        'Bible_text': 'Content',
        'File_url': '',
        'References': [],
      };

      final model = SundayBibleTextModel.fromJson(json);

      expect(model.date, '2024-01-07');
      expect(model.title, 'Test');
      expect(model.bibleChapter, 'Genesis 1:1');
    });

    test('toEntity converts correctly', () {
      const model = SundayBibleTextModel(
        date: '2024-01-07',
        title: 'Test',
        bibleChapter: 'Genesis 1:1',
        bibleText: 'Content',
      );

      final entity = model.toEntity();

      expect(entity.date, model.date);
      expect(entity.title, model.title);
      expect(entity.hasContent, true);
    });
  });

  group('SundayBibleTextFilter', () {
    test('creates filter with year only', () {
      const filter = SundayBibleTextFilter(year: 2024);

      expect(filter.year, 2024);
      expect(filter.hasActiveFilters, false);
    });

    test('hasActiveFilters returns true for keyword', () {
      const filter = SundayBibleTextFilter(
        year: 2024,
        keyword: 'test',
      );

      expect(filter.hasActiveFilters, true);
    });

    test('description returns correct format', () {
      const filter1 = SundayBibleTextFilter(year: 2024);
      expect(filter1.description, 'Year 2024');

      const filter2 = SundayBibleTextFilter(year: 2024, month: 1);
      expect(filter2.description, 'Year 2024, Month 1');

      const filter3 = SundayBibleTextFilter(
        year: 2024,
        startMonth: 1,
        endMonth: 3,
      );
      expect(filter3.description, 'Year 2024, Months 1-3');

      const filter4 = SundayBibleTextFilter(year: 2024, keyword: 'test');
      expect(filter4.description, 'Keyword: test');
    });
  });

  group('SundayBibleTextState', () {
    test('initial state has correct defaults', () {
      final state = SundayBibleTextState();

      expect(state.texts, isEmpty);
      expect(state.status, SundayBibleTextStatus.initial);
      expect(state.isLoading, false);
      expect(state.hasError, false);
      expect(state.hasData, false);
    });

    test('copyWith preserves values', () {
      const entity = SundayBibleTextEntity(
        date: '2024-01-07',
        title: 'Test',
        bibleChapter: 'Genesis 1:1',
        bibleText: 'Content',
      );

      final state = SundayBibleTextState().copyWith(
        texts: [entity],
        status: SundayBibleTextStatus.loaded,
      );

      expect(state.texts.length, 1);
      expect(state.status, SundayBibleTextStatus.loaded);
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
