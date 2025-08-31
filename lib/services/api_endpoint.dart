import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:developer';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
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
  static const Duration _defaultTimeout = Duration(seconds: 10);
  static const Duration _messageTimeout = Duration(seconds: 15);

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
    
    // Update endpoints in background if cache is expired or doesn't exist
    if (!hasCache || UserSharedPreferences.isEndpointsCacheExpired()) {
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
    final uri = Uri.https('www.bridgeway.online', '/_functions/endpoints');

    try {
      final response = await http.get(uri).timeout(
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

  Future<void> checkNewMessage() async {
    try {
      // Get messages from the google doc
      http.Response response = await http.get(apiMap['MESSAGE']!).timeout(
        _messageTimeout,
        onTimeout: () => throw TimeoutException('Message fetch timeout', _messageTimeout),
      );
      
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/${kPrayerListData}");

      int messageCounter = 0;

      if (response.statusCode == 200) {
        var new_msg_id = <String>[];
        var downloadedJsonObjMsg = jsonDecode(response.body) as List;
        var storedJsonObjMsg = <dynamic>[];

        try {
          storedJsonObjMsg = jsonDecode(file.readAsStringSync()) as List;
        } on Exception {
          log("⚠️ File not found: ${file}");
        }

        var messages = jsonDecode(response.body) as List;
        if (storedJsonObjMsg.length > 0) {
          // Optimize: Use Set for faster lookups instead of List.contains
          var messageIdSet = <String>{};
          var messageIdWithViewStatus = <String, bool>{};
          
          for (dynamic message in storedJsonObjMsg) {
            final messageId = message['MessageID'].toString();
            messageIdSet.add(messageId);
            messageIdWithViewStatus[messageId] = message['viewed'] ?? false;
          }

          for (dynamic message in downloadedJsonObjMsg) {
            final messageId = message['MessageID'].toString();
            if (!messageIdSet.contains(messageId)) {
              // New message
              new_msg_id.add(messageId);
              messageCounter++;
            } else {
              // Existing message, check if viewed
              if (messageIdWithViewStatus[messageId] == false) {
                new_msg_id.add(messageId);
                messageCounter++;
              }
            }
          }

          UserSharedPreferences.setMessageListCounter(messageCounter);

          //Add 'viewed' element in message and save data to cache
          for (var i = 0; i < messages.length; i++) {
            final messageId = messages[i]['MessageID'];
            messages[i]['viewed'] = !new_msg_id.contains(messageId);
          }
        } else {
          // This block is executed at the first time
          // when the app is installed and launched.
          UserSharedPreferences.setMessageListCounter(messages.length);
          for (var i = 0; i < messages.length; i++) {
              messages[i]['viewed'] = false;
          }
        }

        await file.writeAsString(jsonEncode(messages), flush: true, mode: FileMode.write);
        UserSharedPreferences.setMessageListTextCache(true);
        log("✅ Message stored.");
      } else {
        log("❌ Message fetch failed with status: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Error checking messages: $e");
      // Don't block app startup if message check fails
    }
  }
}
