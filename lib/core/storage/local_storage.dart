import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';

/// Wrapper around SharedPreferences with typed access and error handling
class LocalStorage {
  static SharedPreferences? _prefs;

  LocalStorage._();

  /// Initialize SharedPreferences - call during app startup
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw const StorageException(
        message: 'LocalStorage not initialized. Call LocalStorage.init() first.',
      );
    }
    return _prefs!;
  }

  // String operations
  static Future<bool> setString(String key, String value) async {
    return instance.setString(key, value);
  }

  static String? getString(String key) {
    return instance.getString(key);
  }

  // Int operations
  static Future<bool> setInt(String key, int value) async {
    return instance.setInt(key, value);
  }

  static int? getInt(String key) {
    return instance.getInt(key);
  }

  // Bool operations
  static Future<bool> setBool(String key, bool value) async {
    return instance.setBool(key, value);
  }

  static bool? getBool(String key) {
    return instance.getBool(key);
  }

  // Double operations
  static Future<bool> setDouble(String key, double value) async {
    return instance.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return instance.getDouble(key);
  }

  // StringList operations
  static Future<bool> setStringList(String key, List<String> value) async {
    return instance.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return instance.getStringList(key);
  }

  // JSON operations for complex objects
  static Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return instance.setString(key, jsonEncode(value));
  }

  static Map<String, dynamic>? getJson(String key) {
    final jsonString = instance.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Remove and clear
  static Future<bool> remove(String key) async {
    return instance.remove(key);
  }

  static Future<bool> clear() async {
    return instance.clear();
  }

  static bool containsKey(String key) {
    return instance.containsKey(key);
  }
}
