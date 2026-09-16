import 'package:flutter/material.dart';

// Color tokens mirror the Next.js homepage's design system
// (app/globals.css: --ink, --blue, --muted, --line, --surface) so the app
// looks like an extension of bridgeway.online rather than a separate brand.
const Color kWebBlue = Color(0xFF2E5AA8);
const Color kWebCoral = Color(0xFFFF654D);

const Color kWebInkLight = Color(0xFF17212B);
const Color kWebMutedLight = Color(0xFF5F6B76);
const Color kWebLineLight = Color(0xFFE5E9ED);
const Color kWebSurfaceLight = Color(0xFFFFFFFF);

const Color kWebInkDark = Color(0xFFF4F6F8);
const Color kWebMutedDark = Color(0xFFAEB8C2);
const Color kWebLineDark = Color(0xFF2D3742);
const Color kWebSurfaceDark = Color(0xFF11161B);

const String kAppFontFamily = 'Paperozi';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: kAppFontFamily,
  scaffoldBackgroundColor: kWebSurfaceLight,
  colorScheme: ColorScheme.light(
    primary: kWebBlue,
    onPrimary: Colors.white,
    secondary: kWebCoral,
    onSecondary: Colors.white,
    surface: kWebSurfaceLight,
    onSurface: kWebInkLight,
    outline: kWebLineLight,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: kWebInkLight,
        displayColor: kWebInkLight,
        fontFamily: kAppFontFamily,
      ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: kAppFontFamily,
  scaffoldBackgroundColor: kWebSurfaceDark,
  colorScheme: ColorScheme.dark(
    primary: kWebBlue,
    onPrimary: Colors.white,
    secondary: kWebCoral,
    onSecondary: Colors.white,
    surface: kWebSurfaceDark,
    onSurface: kWebInkDark,
    outline: kWebLineDark,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: kWebInkDark,
        displayColor: kWebInkDark,
        fontFamily: kAppFontFamily,
      ),
);

final ThemeData sepiaTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: kAppFontFamily,
  primaryColor: Color(0xFF704214),
  scaffoldBackgroundColor: Color(0xFFF4ECD8),
  colorScheme: ColorScheme.light(
    primary: Color(0xFF704214),
    onPrimary: Colors.white,
    onSurface: Color(0xFF4B3832),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF4B3832), fontFamily: kAppFontFamily),
  ),
);

final ThemeData midnightBlueTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: kAppFontFamily,
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
      fontFamily: kAppFontFamily,
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
