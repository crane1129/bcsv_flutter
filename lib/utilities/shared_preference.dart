import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences{
  static late SharedPreferences _peferences;
  static const _keyLanguageOption = 'language_option';
  static const _keyAppThemeSetting = 'app_theme_setting';

  static Future init() async {
    _peferences = await SharedPreferences.getInstance();
  }

  static Future setLanguageOption(String languageOption) async {
    await _peferences.setString(_keyLanguageOption, languageOption);
  }
  static getLanguageOption() => _peferences.getString(_keyLanguageOption);

  //App Theme Setting
  static Future setAppThemeSetting(int count) async {
    await _peferences.setInt(_keyAppThemeSetting, count);
  }
  static getAppThemeSetting() => _peferences.getInt(_keyAppThemeSetting);
}
