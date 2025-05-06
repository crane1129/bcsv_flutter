// Assuming you've already added these imports:
import 'package:bcsv_flutter_project/utilities/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. Extend ThemeNotifier to include new themes
class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;
  String _themeName = 'light';

  ThemeData get currentTheme => _currentTheme;
  String get themeName => _themeName;

  void setTheme(String name, ThemeData theme) {
    _themeName = name;
    _currentTheme = theme;
    notifyListeners();
  }
}