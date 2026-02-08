import 'dart:developer';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';

/// Utility to wait for API endpoints to be initialized
class EndpointWaiter {
  /// Wait for endpoints to be initialized with timeout
  ///
  /// Useful for screens that need to fetch data immediately after mounting
  /// but endpoints might still be initializing in the background.
  ///
  /// Returns true if endpoints became available, false if timeout
  static Future<bool> waitForEndpoints({
    Duration maxWait = const Duration(seconds: 10),
    Duration checkInterval = const Duration(milliseconds: 500),
  }) async {
    final maxAttempts = maxWait.inMilliseconds ~/ checkInterval.inMilliseconds;

    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      if (ApiEndpoint().isInitialized) {
        log('✅ [EndpointWaiter] Endpoints ready after ${attempt * checkInterval.inMilliseconds}ms');
        return true;
      }

      if (attempt < maxAttempts - 1) {
        log('⏳ [EndpointWaiter] Waiting for endpoints... attempt ${attempt + 1}/$maxAttempts');
        await Future.delayed(checkInterval);
      }
    }

    log('⚠️ [EndpointWaiter] Timeout after ${maxWait.inSeconds}s, endpoints still not ready');
    return false;
  }
}
