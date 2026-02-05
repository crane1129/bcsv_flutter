import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:bcsv_flutter_project/core/config/app_config.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

/// Wrapper around FlutterSecureStorage for sensitive data
class SecureStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  SecureStorage._();

  /// Store a string value securely
  static Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      log('SecureStorage write error: $e');
      throw SecureStorageException(
        message: 'Failed to write to secure storage',
        originalError: e,
      );
    }
  }

  /// Read a string value from secure storage
  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      log('SecureStorage read error: $e');
      throw SecureStorageException(
        message: 'Failed to read from secure storage',
        originalError: e,
      );
    }
  }

  /// Delete a value from secure storage
  static Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      log('SecureStorage delete error: $e');
      throw SecureStorageException(
        message: 'Failed to delete from secure storage',
        originalError: e,
      );
    }
  }

  /// Check if a key exists in secure storage
  static Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      log('SecureStorage containsKey error: $e');
      return false;
    }
  }

  /// Clear all secure storage
  static Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      log('SecureStorage deleteAll error: $e');
      throw SecureStorageException(
        message: 'Failed to clear secure storage',
        originalError: e,
      );
    }
  }

  // Google Credentials specific methods

  /// Store Google service account credentials JSON
  static Future<void> storeGoogleCredentials(Map<String, dynamic> credentials) async {
    final jsonString = jsonEncode(credentials);
    await write(AppConfig.googleCredentialsKey, jsonString);
    log('Google credentials stored securely');
  }

  /// Retrieve Google service account credentials JSON
  static Future<Map<String, dynamic>?> getGoogleCredentials() async {
    final jsonString = await read(AppConfig.googleCredentialsKey);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      log('Error parsing Google credentials: $e');
      return null;
    }
  }

  /// Get Google credentials as raw JSON string (for GSheets library)
  static Future<String?> getGoogleCredentialsRaw() async {
    return await read(AppConfig.googleCredentialsKey);
  }

  /// Check if Google credentials are stored
  static Future<bool> hasGoogleCredentials() async {
    return await containsKey(AppConfig.googleCredentialsKey);
  }

  /// Store Google Spreadsheet ID
  static Future<void> storeSpreadsheetId(String spreadsheetId) async {
    await write(AppConfig.googleSpreadsheetIdKey, spreadsheetId);
  }

  /// Get Google Spreadsheet ID
  static Future<String?> getSpreadsheetId() async {
    return await read(AppConfig.googleSpreadsheetIdKey);
  }
}
