import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  static late SharedPreferences _peferences;
  static const _keyLanguageOption = 'language_option';
  static const _keyAnnouncementCache = 'announcement_cache';
  static const _keyBibleTextCache = 'bible_text_cache';
  static const _keyServingTurnCache = 'serving_turn_cache';
  static const _keyDailyBibleText1Cache = 'daily_bible_text1_cache';
  static const _keyDailyBibleText2Cache = 'daily_bible_text2_cache';
  static const _keyBibleReviewCache = 'bible_review_cache';
  static const _keyMessageListCache = 'message_list_cache';
  static const _keyMessageListCounter = 'message_list_counter';
  static const _keyAppThemeSetting = 'app_theme_setting';
  static const _keyStaffMode = 'staff_mode';
  static const _keyStaffPassword = 'staff_password';
  
  // Card visibility settings
  static const _keyShowAnnouncementCard = 'show_announcement_card';
  static const _keyShowMessageCard = 'show_message_card';
  static const _keyShowServingTurnCard = 'show_serving_turn_card';
  static const _keyShowOfferingCard = 'show_offering_card';
  static const _keyShowBibleTextCard = 'show_bible_text_card';
  static const _keyShowDailyBibleCard = 'show_daily_bible_card';
  static const _keyShowBibleSearchCard = 'show_bible_search_card';
  static const _keyShowKeywordSearchCard = 'show_keyword_search_card';
  
  // API Endpoints cache
  static const _keyEndpointsCache = 'endpoints_cache';
  static const _keyEndpointsCacheTimestamp = 'endpoints_cache_timestamp';

  // Key Verse cache
  static const _keyKeyverseCache = 'keyverse_cache';
  static const _keyKeyverseCacheTimestamp = 'keyverse_cache_timestamp';
  static const _keyKeyverseCachedYear = 'keyverse_cached_year';

  // Daily Bible cache
  static const _keyDailyBibleCacheDate = 'daily_bible_cache_date';
  static const _keyDailyBibleCacheTimestamp = 'daily_bible_cache_timestamp';

  // Sunday Bible Text cache
  static const _keySundayBibleTextCacheTimestamp = 'sunday_bible_text_cache_timestamp';

  // Message last seen timestamp (for new message detection)
  static const _keyLastSeenMessageTimestamp = 'last_seen_message_timestamp';
  
  static Future init() async {
    _peferences = await SharedPreferences.getInstance();
  }
  
  static Future setLanguageOption(String languageOption) async {
    await _peferences.setString(_keyLanguageOption, languageOption);
  }
  static getLanguageOption() => _peferences.getString(_keyLanguageOption);

  //Announcement
  static Future setAnnouncementCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyAnnouncementCache, isCacheAvailable);
  }
  static getAnnouncementCache() => _peferences.getBool(_keyAnnouncementCache) ?? false;

  //Sunday Bible Text
  static Future setBibleTextCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyBibleTextCache, isCacheAvailable);
  }
  static getBibleTextCache() => _peferences.getBool(_keyBibleTextCache) ?? false;

  //Bible Review
  static Future setBibleReviewCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyBibleReviewCache, isCacheAvailable);
  }
  static getBibleReviewCache() => _peferences.getBool(_keyBibleReviewCache) ?? false;

  //Serving Turn
  static Future setServingTurnCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyServingTurnCache, isCacheAvailable);
  }
  static getServingTurnCache() => _peferences.getBool(_keyServingTurnCache) ?? false;

  //Daily Bible Text
  static Future setDailyBibleText1Cache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyDailyBibleText1Cache, isCacheAvailable);
  }
  static getDailyBibleText1Cache() => _peferences.getBool(_keyDailyBibleText1Cache) ?? false;

  static Future setDailyBibleText2Cache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyDailyBibleText2Cache, isCacheAvailable);
  }
  static getDailyBibleText2Cache() => _peferences.getBool(_keyDailyBibleText2Cache) ?? false;

  //Message List
  static Future setMessageListTextCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyMessageListCache, isCacheAvailable);
  }
  static getMessageListTextCache() => _peferences.getBool(_keyMessageListCache) ?? false;

  //Message List counter
  static Future setMessageListCounter(int count) async {
    await _peferences.setInt(_keyMessageListCounter, count);
  }
  static getMessageListCounter() => _peferences.getInt(_keyMessageListCounter);

  //App Theme Setting
  static Future setAppThemeSetting(int count) async {
    await _peferences.setInt(_keyAppThemeSetting, count);
  }
  static getAppThemeSetting() => _peferences.getInt(_keyAppThemeSetting);

  //Staff mode
  static Future setStaffMode(bool enabled) async {
    await _peferences.setBool(_keyStaffMode, enabled);
  }

  static Future<bool> isStaffModeEnabled() async {
    return _peferences.getBool(_keyStaffMode) ?? false;
  }

  static Future setStaffPassword(String password) async {
    await _peferences.setString(_keyStaffPassword, password);
  }
  
  // Card visibility settings methods
  static Future setShowAnnouncementCard(bool show) async {
    await _peferences.setBool(_keyShowAnnouncementCard, show);
  }
  static getShowAnnouncementCard() => _peferences.getBool(_keyShowAnnouncementCard) ?? true;
  
  static Future setShowMessageCard(bool show) async {
    await _peferences.setBool(_keyShowMessageCard, show);
  }
  static getShowMessageCard() => _peferences.getBool(_keyShowMessageCard) ?? true;
  
  static Future setShowServingTurnCard(bool show) async {
    await _peferences.setBool(_keyShowServingTurnCard, show);
  }
  static getShowServingTurnCard() => _peferences.getBool(_keyShowServingTurnCard) ?? true;
  
  static Future setShowOfferingCard(bool show) async {
    await _peferences.setBool(_keyShowOfferingCard, show);
  }
  static getShowOfferingCard() => _peferences.getBool(_keyShowOfferingCard) ?? true;
  
  static Future setShowBibleTextCard(bool show) async {
    await _peferences.setBool(_keyShowBibleTextCard, show);
  }
  static getShowBibleTextCard() => _peferences.getBool(_keyShowBibleTextCard) ?? true;
  
  static Future setShowDailyBibleCard(bool show) async {
    await _peferences.setBool(_keyShowDailyBibleCard, show);
  }
  static getShowDailyBibleCard() => _peferences.getBool(_keyShowDailyBibleCard) ?? true;
  
  static Future setShowBibleSearchCard(bool show) async {
    await _peferences.setBool(_keyShowBibleSearchCard, show);
  }
  static getShowBibleSearchCard() => _peferences.getBool(_keyShowBibleSearchCard) ?? true;
  
  static Future setShowKeywordSearchCard(bool show) async {
    await _peferences.setBool(_keyShowKeywordSearchCard, show);
  }
  static getShowKeywordSearchCard() => _peferences.getBool(_keyShowKeywordSearchCard) ?? true;
  
  // API Endpoints cache methods
  static Future setEndpointsCache(String endpointsJson) async {
    await _peferences.setString(_keyEndpointsCache, endpointsJson);
    await _peferences.setInt(_keyEndpointsCacheTimestamp, DateTime.now().millisecondsSinceEpoch);
  }
  
  static String? getEndpointsCache() => _peferences.getString(_keyEndpointsCache);
  
  static int? getEndpointsCacheTimestamp() => _peferences.getInt(_keyEndpointsCacheTimestamp);
  
  static bool isEndpointsCacheExpired({Duration maxAge = const Duration(hours: 24)}) {
    final timestamp = getEndpointsCacheTimestamp();
    if (timestamp == null) return true;

    final cacheDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    return now.difference(cacheDate) > maxAge;
  }

  // Key Verse cache methods
  static Future setKeyverseCache(String? keyverseJson) async {
    if (keyverseJson == null) {
      await _peferences.remove(_keyKeyverseCache);
    } else {
      await _peferences.setString(_keyKeyverseCache, keyverseJson);
    }
  }

  static String? getKeyverseCache() => _peferences.getString(_keyKeyverseCache);

  static Future setKeyverseCacheTimestamp(int? timestamp) async {
    if (timestamp == null) {
      await _peferences.remove(_keyKeyverseCacheTimestamp);
    } else {
      await _peferences.setInt(_keyKeyverseCacheTimestamp, timestamp);
    }
  }

  static int? getKeyverseCacheTimestamp() => _peferences.getInt(_keyKeyverseCacheTimestamp);

  static Future setKeyverseCachedYear(int? year) async {
    if (year == null) {
      await _peferences.remove(_keyKeyverseCachedYear);
    } else {
      await _peferences.setInt(_keyKeyverseCachedYear, year);
    }
  }

  static int? getKeyverseCachedYear() => _peferences.getInt(_keyKeyverseCachedYear);

  // Daily Bible cache methods
  static Future setDailyBibleCacheDate(String? date) async {
    if (date == null) {
      await _peferences.remove(_keyDailyBibleCacheDate);
    } else {
      await _peferences.setString(_keyDailyBibleCacheDate, date);
    }
  }

  static String? getDailyBibleCacheDate() =>
      _peferences.getString(_keyDailyBibleCacheDate);

  static Future setDailyBibleCacheTimestamp(int? timestamp) async {
    if (timestamp == null) {
      await _peferences.remove(_keyDailyBibleCacheTimestamp);
    } else {
      await _peferences.setInt(_keyDailyBibleCacheTimestamp, timestamp);
    }
  }

  static int? getDailyBibleCacheTimestamp() =>
      _peferences.getInt(_keyDailyBibleCacheTimestamp);

  // Sunday Bible Text cache methods
  static Future setSundayBibleTextCacheTimestamp(int? timestamp) async {
    if (timestamp == null) {
      await _peferences.remove(_keySundayBibleTextCacheTimestamp);
    } else {
      await _peferences.setInt(_keySundayBibleTextCacheTimestamp, timestamp);
    }
  }

  static int? getSundayBibleTextCacheTimestamp() =>
      _peferences.getInt(_keySundayBibleTextCacheTimestamp);

  // Message last seen timestamp methods
  static Future setLastSeenMessageTimestamp(String timestamp) async {
    await _peferences.setString(_keyLastSeenMessageTimestamp, timestamp);
  }

  static String? getLastSeenMessageTimestamp() =>
      _peferences.getString(_keyLastSeenMessageTimestamp);

  // Generic methods for other data types
  static Future setString(String key, String value) async {
    await _peferences.setString(key, value);
  }
  
  static String? getString(String key) => _peferences.getString(key);
  
  static Future setInt(String key, int value) async {
    await _peferences.setInt(key, value);
  }
  
  static int? getInt(String key) => _peferences.getInt(key);
  
  static Future remove(String key) async {
    await _peferences.remove(key);
  }
}
