import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'dart:developer';

/// Service for managing app icon badges
///
/// This service wraps flutter_app_badger to update the badge count
/// on the app icon when there are unread messages.
class AppBadgeService {
  /// Update app badge with count
  static Future<void> updateBadgeCount(int count) async {
    try {
      if (count > 0) {
        await FlutterAppBadger.updateBadgeCount(count);
        log('🔴 App badge updated: $count');
      } else {
        await FlutterAppBadger.removeBadge();
        log('✅ App badge removed');
      }
    } catch (e) {
      log('⚠️ Failed to update app badge: $e');
    }
  }

  /// Remove app badge
  static Future<void> removeBadge() async {
    try {
      await FlutterAppBadger.removeBadge();
      log('✅ App badge removed');
    } catch (e) {
      log('⚠️ Failed to remove app badge: $e');
    }
  }

  /// Check if app badging is supported
  static Future<bool> isSupported() async {
    try {
      return await FlutterAppBadger.isAppBadgeSupported();
    } catch (e) {
      log('⚠️ Failed to check app badge support: $e');
      return false;
    }
  }
}
