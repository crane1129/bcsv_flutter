import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/utilities/themes.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme;
  int _themeIndex;

  ThemeNotifier(this._currentTheme, this._themeIndex);

  ThemeData get currentTheme => _currentTheme;
  int get currentIndex => _themeIndex;

  void setThemeByIndex(int index) {
    _themeIndex = index;
    _currentTheme = getThemeByIndex(index);
    UserSharedPreferences.setAppThemeSetting(index); // persist
    notifyListeners();
  }

  static ThemeData getThemeByIndex(int index) {
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
}
