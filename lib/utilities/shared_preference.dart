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
  static getAnnouncementCache() => _peferences.getBool(_keyAnnouncementCache);

  //Sunday Bible Text
  static Future setBibleTextCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyBibleTextCache, isCacheAvailable);
  }
  static getBibleTextCache() => _peferences.getBool(_keyBibleTextCache);

  //Bible Review
  static Future setBibleReviewCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyBibleReviewCache, isCacheAvailable);
  }
  static getBibleReviewCache() => _peferences.getBool(_keyBibleReviewCache);

  //Serving Turn
  static Future setServingTurnCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyServingTurnCache, isCacheAvailable);
  }
  static getServingTurnCache() => _peferences.getBool(_keyServingTurnCache);

  //Daily Bible Text
  static Future setDailyBibleText1Cache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyDailyBibleText1Cache, isCacheAvailable);
  }
  static getDailyBibleText1Cache() => _peferences.getBool(_keyDailyBibleText1Cache);

  static Future setDailyBibleText2Cache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyDailyBibleText2Cache, isCacheAvailable);
  }
  static getDailyBibleText2Cache() => _peferences.getBool(_keyDailyBibleText2Cache);

  //Message List
  static Future setMessageListTextCache(bool isCacheAvailable) async {
    await _peferences.setBool(_keyMessageListCache, isCacheAvailable);
  }
  static getMessageListTextCache() => _peferences.getBool(_keyMessageListCache);

  //Message List counter
  static Future setMessageListCounter(int count) async {
    await _peferences.setInt(_keyMessageListCounter, count);
  }
  static getMessageListCounter() => _peferences.getInt(_keyMessageListCounter);

}
