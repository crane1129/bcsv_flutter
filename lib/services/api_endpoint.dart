import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';

/// API Endpoint manager with caching support
/// 
/// This service manages API endpoints with the following behavior:
/// 1. Loads cached endpoints immediately for fast app startup
/// 2. Updates endpoints in background when cache is expired or missing
/// 3. Stores endpoints in SharedPreferences for persistence across app restarts
/// 
/// Usage:
/// - For app initialization: Use `initializeEndpoints()` to load cache immediately
/// - For manual refresh: Use `bindEndpoints()` to force fetch fresh endpoints
/// - For checking availability: Use `hasEndpoint(key)` or `isInitialized`
class ApiEndpoint {
  static final ApiEndpoint _instance = ApiEndpoint._internal();
  factory ApiEndpoint() => _instance;
  ApiEndpoint._internal();

  static final Map<String, Uri> apiMap = {};
  static bool _isInitialized = false;
  static bool _isUpdating = false;
  
  // Timeout configuration
  static const Duration _defaultTimeout = Duration(seconds: 20);

  Future<bool> bindEndpoints() async {
    try {
      final data = await fetchEndpoints();
      if (data.isEmpty) {
        log('⚠️ No endpoint data received');
        return false;
      }

      List<Endpoint> endpointObjs = data.map((e) => Endpoint.fromJson(e)).toList();

      apiMap.clear();
      for (Endpoint e in endpointObjs) {
        apiMap[e.endpoint] = Uri.parse(e.url);
      }

      // Save to cache for future app starts
      await _saveEndpointsToCache(data);
      
      _isInitialized = true;
      log('✅ Endpoint bind is complete. ${apiMap.length} endpoints loaded');
      return true;
    } catch (e) {
      log("❌ bindEndpoints error: $e");
      return false;
    }
  }

  Uri? get(String key) => apiMap[key];
  
  /// Check if endpoints are initialized
  bool get isInitialized => _isInitialized;
  
  /// Check if a specific endpoint is available
  bool hasEndpoint(String key) => apiMap.containsKey(key);

  /// Initialize endpoints by loading cached data first, then updating in background
  Future<bool> initializeEndpoints() async {
    if (_isInitialized) return true;

    // Load cached endpoints immediately
    final hasCache = await _loadCachedEndpoints();
    _isInitialized = hasCache;

    if (!hasCache) {
      // No cache — must fetch now so the UI has endpoints on first launch
      await bindEndpoints();
    } else {
      // Cache exists — always refresh in background so a force-close/reopen picks up changes
      _updateEndpointsInBackground();
    }

    return _isInitialized;
  }

  /// Load endpoints from SharedPreferences cache
  Future<bool> _loadCachedEndpoints() async {
    try {
      final cachedData = UserSharedPreferences.getEndpointsCache();
      if (cachedData == null) {
        log('🔄 No cached endpoints found');
        return false;
      }

      final List<dynamic> endpointData = jsonDecode(cachedData);
      final List<Endpoint> endpointObjs = endpointData.map((e) => Endpoint.fromJson(e)).toList();

      apiMap.clear();
      for (Endpoint e in endpointObjs) {
        apiMap[e.endpoint] = Uri.parse(e.url);
      }

      log('✅ Loaded ${apiMap.length} endpoints from cache');
      return true;
    } catch (e) {
      log('❌ Error loading cached endpoints: $e');
      return false;
    }
  }

  /// Save endpoints to SharedPreferences cache
  Future<void> _saveEndpointsToCache(List<Map<String, dynamic>> endpointData) async {
    try {
      final jsonString = jsonEncode(endpointData);
      await UserSharedPreferences.setEndpointsCache(jsonString);
      log('✅ Endpoints saved to cache');
    } catch (e) {
      log('❌ Error saving endpoints to cache: $e');
    }
  }

  /// Update endpoints in background without blocking the UI
  void _updateEndpointsInBackground() {
    if (_isUpdating) return;
    
    _isUpdating = true;
    bindEndpoints().then((success) {
      _isUpdating = false;
      if (success) {
        log('✅ Background endpoint update completed');
      } else {
        log('⚠️ Background endpoint update failed');
      }
    });
  }

  Future<List<Map<String, dynamic>>> fetchEndpoints() async {
    final uri = Uri.parse('https://bcsv-api.crane1129.workers.dev/api/endpoints');

    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ).timeout(
        _defaultTimeout,
        onTimeout: () => throw TimeoutException('Endpoint fetch timeout', _defaultTimeout),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> items = json['results'];
        return items.cast<Map<String, dynamic>>();
      } else {
        throw Exception("Failed to load endpoints: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Error fetching endpoints: $e");
      return [];
    }
  }

  /// @deprecated This method is deprecated and replaced by MessageRepository pattern.
  /// Kept for backwards compatibility during migration.
  /// Use MessageRepositoryImpl and MessageProvider instead.
  @Deprecated('Use MessageRepositoryImpl.getNewMessageCount() instead')
  Future<void> checkNewMessage() async {
    // This method is deprecated. Message checking is now handled by:
    // - MessageRepositoryImpl.getNewMessageCount()
    // - MessageProvider for state management
    // - Uses createdAt timestamp instead of MessageID
    log('⚠️ checkNewMessage() is deprecated - use MessageProvider instead');
  }
}
