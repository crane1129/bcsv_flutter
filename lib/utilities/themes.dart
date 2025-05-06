import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
);

final ThemeData bibleTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.brown,
  scaffoldBackgroundColor: Color(0xFFFAF3E0),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.brown[900]),
  ),
);

final ThemeData sepiaTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF704214),
  scaffoldBackgroundColor: Color(0xFFF4ECD8),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF704214),
    onPrimary: Colors.white,
    onSurface: Color(0xFF4B3832),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF4B3832)),
  ),
);

final ThemeData midnightBlueTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1A237E),
  scaffoldBackgroundColor: Color(0xFF0D111C),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF536DFE),
    onPrimary: Colors.white,
    surface: Color(0xFF1E1E2C),
    onSurface: Colors.white70,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white70,
      fontSize: 14.0,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E2C),
    hintStyle: TextStyle(color: Colors.white54),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
  ),
);
