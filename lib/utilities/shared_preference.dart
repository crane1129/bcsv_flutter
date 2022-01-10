import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  static late SharedPreferences _peferences;
  static const _keyLanguageOption = 'language_option';
  static const _keyAnnouncementContent = 'announcement_content';
  
  static Future init() async {
    _peferences = await SharedPreferences.getInstance();
  }
  
  static Future setLanguageOption(String languageOption) async {
    await _peferences.setString(_keyLanguageOption, languageOption);
  }

  static getLanguageOption() => _peferences.getString(_keyLanguageOption);

  static Future setAnnouncementContent(String announcementContent) async {
    await _peferences.setString(_keyAnnouncementContent, announcementContent);
  }

  static getAnnouncementContent() => _peferences.getString(_keyAnnouncementContent);
}