import 'package:bcsv_flutter_project/domain/entities/keyverse.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/domain/repositories/keyverse_repository.dart';
import 'package:bcsv_flutter_project/domain/repositories/message_repository.dart';
import 'package:bcsv_flutter_project/domain/repositories/settings_repository.dart';

class FakeKeyVerseRepository implements KeyVerseRepository {
  static final _testKeyVerse = KeyVerseEntity(
    year: DateTime.now().year,
    title: '사랑의 교회',
    book: '요한복음',
    chapter: 3,
    verseFrom: 16,
    verseEnd: 17,
    verse: '하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니',
  );

  bool _wasFromCache = false;
  DateTime? _lastUpdated;

  @override
  Future<KeyVerseEntity?> getKeyVerse({
    int? year,
    bool forceRefresh = false,
  }) async {
    _wasFromCache = !forceRefresh;
    _lastUpdated = DateTime.now();
    return _testKeyVerse;
  }

  @override
  Future<KeyVerseEntity?> getCurrentYearKeyVerse({
    bool forceRefresh = false,
  }) async {
    return getKeyVerse(year: DateTime.now().year, forceRefresh: forceRefresh);
  }

  @override
  Future<KeyVerseEntity?> getCachedKeyVerse(int year) async => _testKeyVerse;

  @override
  Future<bool> hasCachedKeyVerse(int year) async => true;

  @override
  bool wasLastFetchFromCache() => _wasFromCache;

  @override
  Future<void> clearCache() async {}

  @override
  DateTime? getLastUpdated() => _lastUpdated;
}

class FakeMessageRepository implements MessageRepository {
  final List<MessageEntity> _messages = [
    MessageEntity(
      id: 'test-1',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      title: 'Test Announcement',
      message: '<p>Welcome to Bridgeway Baptist Church!</p>',
      category: 'Announcement',
      startDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  bool _wasFromCache = false;
  DateTime? _lastUpdated;
  DateTime? _lastSeenTimestamp;

  @override
  Future<List<MessageEntity>> getMessages({bool forceRefresh = false}) async {
    _wasFromCache = !forceRefresh;
    _lastUpdated = DateTime.now();
    return _messages;
  }

  @override
  Future<List<MessageEntity>?> getCachedMessages() async => _messages;

  @override
  Future<bool> hasCachedMessages() async => true;

  @override
  bool wasLastFetchFromCache() => _wasFromCache;

  @override
  Future<void> clearCache() async {}

  @override
  DateTime? getLastUpdated() => _lastUpdated;

  @override
  Future<int> getNewMessageCount() async {
    if (_lastSeenTimestamp == null) return _messages.length;
    return _messages
        .where((m) => m.createdAt.isAfter(_lastSeenTimestamp!))
        .length;
  }

  @override
  DateTime? getLastSeenTimestamp() => _lastSeenTimestamp;

  @override
  Future<void> setLastSeenTimestamp(DateTime timestamp) async {
    _lastSeenTimestamp = timestamp;
  }
}

class FakeSettingsRepository implements SettingsRepository {
  int _themeIndex = 0;
  String? _languageOption = 'en';
  bool _staffMode = false;
  final Map<String, bool> _cardVisibility = {};

  @override
  Future<int> getThemeIndex() async => _themeIndex;

  @override
  Future<void> setThemeIndex(int index) async => _themeIndex = index;

  @override
  Future<String?> getLanguageOption() async => _languageOption;

  @override
  Future<void> setLanguageOption(String languageCode) async {
    _languageOption = languageCode;
  }

  @override
  Future<bool> getShowAnnouncementCard() async =>
      _cardVisibility['announcement'] ?? true;

  @override
  Future<void> setShowAnnouncementCard(bool show) async =>
      _cardVisibility['announcement'] = show;

  @override
  Future<bool> getShowMessageCard() async =>
      _cardVisibility['message'] ?? true;

  @override
  Future<void> setShowMessageCard(bool show) async =>
      _cardVisibility['message'] = show;

  @override
  Future<bool> getShowServingTurnCard() async =>
      _cardVisibility['servingTurn'] ?? true;

  @override
  Future<void> setShowServingTurnCard(bool show) async =>
      _cardVisibility['servingTurn'] = show;

  @override
  Future<bool> getShowOfferingCard() async =>
      _cardVisibility['offering'] ?? true;

  @override
  Future<void> setShowOfferingCard(bool show) async =>
      _cardVisibility['offering'] = show;

  @override
  Future<bool> getShowBibleTextCard() async =>
      _cardVisibility['bibleText'] ?? true;

  @override
  Future<void> setShowBibleTextCard(bool show) async =>
      _cardVisibility['bibleText'] = show;

  @override
  Future<bool> getShowDailyBibleCard() async =>
      _cardVisibility['dailyBible'] ?? true;

  @override
  Future<void> setShowDailyBibleCard(bool show) async =>
      _cardVisibility['dailyBible'] = show;

  @override
  Future<bool> getShowBibleSearchCard() async =>
      _cardVisibility['bibleSearch'] ?? true;

  @override
  Future<void> setShowBibleSearchCard(bool show) async =>
      _cardVisibility['bibleSearch'] = show;

  @override
  Future<bool> getShowKeywordSearchCard() async =>
      _cardVisibility['keywordSearch'] ?? true;

  @override
  Future<void> setShowKeywordSearchCard(bool show) async =>
      _cardVisibility['keywordSearch'] = show;

  @override
  Future<bool> isStaffModeEnabled() async => _staffMode;

  @override
  Future<void> setStaffMode(bool enabled) async => _staffMode = enabled;
}
