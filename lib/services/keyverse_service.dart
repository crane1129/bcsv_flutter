import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/data_models/keyverse_model.dart';
import 'dart:developer';

class KeyVerseService {
  static final KeyVerseService _instance = KeyVerseService._internal();
  factory KeyVerseService() => _instance;
  KeyVerseService._internal();

  static const String _baseUrl = 'https://bcsv-api.crane1129.workers.dev';
  static const String _endpoint = '/api/keyVerse';
  static const Duration _timeout = Duration(seconds: 30);

  // Cache keys
  static const String _keyVerseCache = 'keyverse_cache';
  static const String _keyVerseCacheTimestamp = 'keyverse_cache_timestamp';
  static const String _keyVerseYear = 'keyverse_year';

  /// Get keyverse for a specific year (defaults to current year)
  Future<KeyVerseResponse?> getKeyVerse({int? year}) async {
    try {
      final targetYear = year ?? DateTime.now().year;
      log('🔍 Fetching keyverse for year: $targetYear');

      // Check cache first
      final cachedData = _getCachedKeyVerse(targetYear);
      if (cachedData != null) {
        log('✅ Keyverse loaded from cache for year: $targetYear');
        return cachedData;
      }

      // Fetch from server if not cached
      final serverData = await _fetchKeyVerseFromServer(targetYear);
      if (serverData != null) {
        // Cache the data
        _cacheKeyVerse(targetYear, serverData);
        log('✅ Keyverse fetched and cached for year: $targetYear');
        return serverData;
      }

      log('❌ Failed to fetch keyverse for year: $targetYear');
      return null;
    } catch (e) {
      log('❌ Error getting keyverse for year $year: $e');
      return null;
    }
  }

  /// Fetch keyverse data from the server
  Future<KeyVerseResponse?> _fetchKeyVerseFromServer(int year) async {
    try {
      final uri = Uri.parse('$_baseUrl$_endpoint?year=$year');
      log('🌐 Fetching from: $uri');

      final response = await http.get(uri).timeout(_timeout);
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        log('📥 Keyverse response received: ${jsonData.length} bytes');
        
        // Parse and validate response structure
        try {
          final keyverseResponse = KeyVerseResponse.fromJson(jsonData);
          if (keyverseResponse.results.isNotEmpty) {
            log('✅ Keyverse data validated: ${keyverseResponse.results.length} results');
            return keyverseResponse;
          }
        } catch (parseError) {
          log('❌ Error parsing keyverse response: $parseError');
          return null;
        }
        
        log('⚠️ Invalid keyverse response structure');
        return null;
      } else {
        log('❌ HTTP error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      if (e is TimeoutException) {
        log('⏰ Keyverse request timeout');
      } else {
        log('❌ Network error fetching keyverse: $e');
      }
      return null;
    }
  }

  /// Get cached keyverse data for a specific year
  KeyVerseResponse? _getCachedKeyVerse(int year) {
    try {
      final cachedYear = UserSharedPreferences.getInt(_keyVerseYear);
      if (cachedYear != year) {
        log('🔄 Cache year mismatch: cached=$cachedYear, requested=$year');
        return null;
      }

      final cachedJson = UserSharedPreferences.getString(_keyVerseCache);
      if (cachedJson == null || cachedJson.isEmpty) {
        log('🔄 No cached keyverse data found');
        return null;
      }

      final timestamp = UserSharedPreferences.getInt(_keyVerseCacheTimestamp);
      if (timestamp == null) return null;
      
      final now = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = Duration(milliseconds: now - timestamp);

      // Cache expires after 24 hours
      if (cacheAge.inHours > 24) {
        log('⏰ Keyverse cache expired (age: ${cacheAge.inHours}h)');
        return null;
      }

      try {
        final jsonData = jsonDecode(cachedJson);
        final cachedData = KeyVerseResponse.fromJson(jsonData);
        log('✅ Keyverse cache hit for year: $year (age: ${cacheAge.inHours}h)');
        return cachedData;
      } catch (parseError) {
        log('❌ Error parsing cached keyverse data: $parseError');
        return null;
      }
    } catch (e) {
      log('❌ Error reading cached keyverse: $e');
      return null;
    }
  }

  /// Cache keyverse data locally
  void _cacheKeyVerse(int year, KeyVerseResponse data) {
    try {
      final jsonString = jsonEncode(data.toJson());
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      UserSharedPreferences.setString(_keyVerseCache, jsonString);
      UserSharedPreferences.setInt(_keyVerseCacheTimestamp, timestamp);
      UserSharedPreferences.setInt(_keyVerseYear, year);

      log('💾 Keyverse cached for year: $year (${jsonString.length} bytes)');
    } catch (e) {
      log('❌ Error caching keyverse: $e');
    }
  }

  /// Clear cached keyverse data
  void clearCache() {
    try {
      UserSharedPreferences.remove(_keyVerseCache);
      UserSharedPreferences.remove(_keyVerseCacheTimestamp);
      UserSharedPreferences.remove(_keyVerseYear);
      log('🗑️ Keyverse cache cleared');
    } catch (e) {
      log('❌ Error clearing keyverse cache: $e');
    }
  }

  /// Get the currently cached year
  int? getCachedYear() {
    try {
      return UserSharedPreferences.getInt(_keyVerseYear);
    } catch (e) {
      log('❌ Error getting cached year: $e');
      return null;
    }
  }

  /// Check if keyverse is available for a specific year
  bool hasKeyVerse(int year) {
    try {
      final cachedYear = UserSharedPreferences.getInt(_keyVerseYear);
      if (cachedYear != year) return false;

      final cachedData = UserSharedPreferences.getString(_keyVerseCache);
      if (cachedData == null || cachedData.isEmpty) return false;

      final timestamp = UserSharedPreferences.getInt(_keyVerseCacheTimestamp);
      if (timestamp == null) return false;
      
      final now = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = Duration(milliseconds: now - timestamp);

      return cacheAge.inHours <= 24;
    } catch (e) {
      log('❌ Error checking keyverse availability: $e');
      return false;
    }
  }

  /// Get the current year's keyverse (convenience method)
  Future<KeyVerse?> getCurrentYearKeyVerse() async {
    final response = await getKeyVerse();
    return response?.firstKeyVerse;
  }

  /// Get keyverse for a specific year and return the first result
  Future<KeyVerse?> getKeyVerseForYear(int year) async {
    final response = await getKeyVerse(year: year);
    return response?.firstKeyVerse;
  }

  /// Force refresh keyverse data for a specific year
  Future<KeyVerseResponse?> refreshKeyVerse(int year) async {
    try {
      log('🔄 Force refreshing keyverse for year: $year');
      
      // Clear existing cache for this year
      if (getCachedYear() == year) {
        clearCache();
      }

      // Fetch fresh data
      final freshData = await _fetchKeyVerseFromServer(year);
      if (freshData != null) {
        _cacheKeyVerse(year, freshData);
        log('✅ Keyverse refreshed for year: $year');
        return freshData;
      }

      log('❌ Failed to refresh keyverse for year: $year');
      return null;
    } catch (e) {
      log('❌ Error refreshing keyverse: $e');
      return null;
    }
  }
}
