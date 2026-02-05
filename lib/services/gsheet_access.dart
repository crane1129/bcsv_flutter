import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/core/storage/secure_storage.dart';
import 'package:bcsv_flutter_project/core/error/app_exception.dart';
import 'dart:developer';

class GoogleMessageSheet {
  static GSheets? _gsheets;
  static Worksheet? _userSheet;
  static String sheetName = 'Request';
  static bool _initialized = false;

  // Timeout configuration
  static const Duration _initTimeout = Duration(seconds: 20);

  /// Initialize with credentials from secure storage
  static Future<void> init() async {
    if (_initialized && _userSheet != null) {
      log('Google Sheets already initialized');
      return;
    }

    try {
      // Get credentials from secure storage
      final credentials = await SecureStorage.getGoogleCredentialsRaw();
      final spreadsheetId = await SecureStorage.getSpreadsheetId();

      if (credentials == null || spreadsheetId == null) {
        log('Google credentials not found in secure storage');
        throw const CredentialNotFoundException();
      }

      _gsheets = GSheets(credentials);

      final spreadsheet = await _gsheets!.spreadsheet(spreadsheetId).timeout(
        _initTimeout,
        onTimeout: () {
          throw Exception('Google Sheets init timeout');
        },
      );

      _userSheet = await _getWorkSheet(spreadsheet, title: sheetName);
      _initialized = true;
      log('Google Sheets initialized successfully');
    } catch (e) {
      log('Error initializing Google Sheets: $e');
      _initialized = false;
      // Don't throw - let the app continue without Google Sheets functionality
    }
  }

  /// Re-initialize with new credentials (for credential updates)
  static Future<void> reinitialize() async {
    _initialized = false;
    _gsheets = null;
    _userSheet = null;
    await init();
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title).timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Add worksheet timeout'),
          );
    } catch (e) {
      // If adding fails, try to get existing worksheet
      final worksheet = spreadsheet.worksheetByTitle(sheetName);
      if (worksheet == null) {
        throw Exception('Failed to get or create worksheet: $e');
      }
      return worksheet;
    }
  }

  /// Check if the service is properly initialized
  static bool get isInitialized => _initialized && _userSheet != null;

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) {
      log('Google Sheets not initialized, cannot insert data');
      showSimpleNotification(
          Text("Failed to submit opinion - service unavailable"),
          leading: Icon(Icons.error),
          background: Colors.orange,
          elevation: 5);
      return;
    }

    try {
      await _userSheet!.values.map.appendRows(rowList).timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw Exception('Insert rows timeout'),
          );

      showSimpleNotification(Text("Your opinion has successfully submitted"),
          leading: Icon(Icons.send), background: Colors.green, elevation: 5);
    } catch (e) {
      log('Error inserting to Google Sheets: $e');
      showSimpleNotification(
          Text("Failed to submit opinion - please try again"),
          leading: Icon(Icons.error),
          background: Colors.red,
          elevation: 5);
    }
  }
}
