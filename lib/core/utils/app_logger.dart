import 'package:flutter/foundation.dart';

/// Centralized logging utility that works with both DevTools and console output
class AppLogger {
  /// Log with emoji prefix for easy scanning
  /// Uses debugPrint so logs appear in flutter logs output
  static void log(String message, {String tag = 'App'}) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
    }
  }

  /// Log method entry
  static void entry(String method, {String tag = 'App', Map<String, dynamic>? params}) {
    final paramsStr = params?.entries.map((e) => '${e.key}: ${e.value}').join(', ') ?? '';
    log('🎯 $method called${paramsStr.isNotEmpty ? " ($paramsStr)" : ""}', tag: tag);
  }

  /// Log state change
  static void state(String message, {String tag = 'App'}) {
    log('🔵 $message', tag: tag);
  }

  /// Log network operation
  static void network(String message, {String tag = 'App'}) {
    log('🌐 $message', tag: tag);
  }

  /// Log data stats
  static void data(String message, {String tag = 'App'}) {
    log('📊 $message', tag: tag);
  }

  /// Log cache info
  static void cache(String message, {String tag = 'App'}) {
    log('📦 $message', tag: tag);
  }

  /// Log success
  static void success(String message, {String tag = 'App'}) {
    log('✅ $message', tag: tag);
  }

  /// Log warning
  static void warning(String message, {String tag = 'App'}) {
    log('⚠️ $message', tag: tag);
  }

  /// Log error
  static void error(String message, {String tag = 'App', Object? error, StackTrace? stackTrace}) {
    log('❌ $message${error != null ? ": $error" : ""}', tag: tag);
    if (stackTrace != null && kDebugMode) {
      log('📍 Stack: ${stackTrace.toString().split('\n').take(5).join('\n')}', tag: tag);
    }
  }
}
