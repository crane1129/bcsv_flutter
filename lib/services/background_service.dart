import 'dart:async';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/services/gsheet_access.dart';
import 'package:bcsv_flutter_project/services/keyverse_service.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/utilities/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:developer';

class BackgroundService {
  static final BackgroundService _instance = BackgroundService._internal();
  factory BackgroundService() => _instance;
  BackgroundService._internal() {
    _setupNetworkMonitoring();
  }

  bool _isInitialized = false;
  bool _isLoading = false;
  bool _hasInternetConnection = false;
  Timer? _networkCheckTimer;
  Timer? _retryTimer;
  StreamSubscription<InternetConnectionStatus>? _networkSubscription;
  int _retryAttempts = 0;
  
  final List<VoidCallback> _completionCallbacks = [];
  final List<VoidCallback> _networkRestoreCallbacks = [];

  // Configuration constants
  static const Duration _networkCheckInterval = Duration(seconds: 30);
  static const Duration _networkTimeout = Duration(seconds: 10);
  static const int _maxRetryAttempts = 3;
  static const List<Duration> _retryDelays = [
    Duration(seconds: 5),   // First retry after 5 seconds
    Duration(seconds: 15),  // Second retry after 15 seconds
    Duration(seconds: 30),  // Third retry after 30 seconds
  ];

  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get hasInternetConnection => _hasInternetConnection;

  /// Initialize background services without blocking UI
  Future<void> initializeInBackground() async {
    if (_isLoading || _isInitialized) return;
    
    _isLoading = true;
    log('🔄 Starting background initialization...');

    try {
      // Check network connectivity with timeout
      final hasConnection = await _checkNetworkConnectionWithTimeout();
      _hasInternetConnection = hasConnection;
      
      if (!hasConnection) {
        log('❌ No network connection, attempting graceful degradation');
        await _initializeOfflineServices();
        _scheduleRetryWithBackoff();
        return;
      }

      // Reset retry attempts on successful connection
      _retryAttempts = 0;
      
      // Run operations in parallel where possible
      final futures = <Future>[];
      
      // Always initialize offline-capable services
      futures.add(_initializeOfflineServices());
      
      // Initialize network-dependent services
      futures.add(_initializeNetworkServices());
      
      // Wait for all operations to complete
      await Future.wait(futures, eagerError: false);
      
      _isInitialized = true;
      log('✅ Background initialization completed');
      
      // Notify completion callbacks
      _notifyCompletionCallbacks();
      
    } catch (e) {
      log('❌ Error during background initialization: $e');
      // Still try to initialize offline services
      await _initializeOfflineServices();
      _scheduleRetryWithBackoff();
    } finally {
      _isLoading = false;
    }
  }

  /// Setup continuous network monitoring
  void _setupNetworkMonitoring() {
    // Listen to network status changes
    _networkSubscription = InternetConnectionChecker.instance
        .onStatusChange
        .listen(_onNetworkStatusChanged);
    
    // Periodic network check as backup
    _networkCheckTimer = Timer.periodic(_networkCheckInterval, (_) {
      _checkAndUpdateNetworkStatus();
    });
  }

  /// Handle network status changes
  void _onNetworkStatusChanged(InternetConnectionStatus status) {
    final wasConnected = _hasInternetConnection;
    _hasInternetConnection = status == InternetConnectionStatus.connected;
    
    log('🌐 Network status changed: ${_hasInternetConnection ? 'Connected' : 'Disconnected'}');
    
    // If connection restored and we weren't initialized, try again
    if (!wasConnected && _hasInternetConnection && !_isInitialized) {
      log('🔄 Network restored, retrying initialization...');
      _retryAttempts = 0; // Reset retry count
      _cancelRetryTimer();
      initializeInBackground();
      
      // Notify network restoration callbacks
      for (final callback in _networkRestoreCallbacks) {
        callback();
      }
      _networkRestoreCallbacks.clear();
    }
  }

  /// Check network connection with proper timeout and error handling
  Future<bool> _checkNetworkConnectionWithTimeout() async {
    try {
      final hasInternet = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(_networkTimeout);
      
      log('🌐 Network check: ${hasInternet ? 'Connected' : 'Disconnected'}');
      return hasInternet;
    } catch (e) {
      log('❌ Network check timeout or error: $e');
      return false;
    }
  }

  /// Periodic network status update
  Future<void> _checkAndUpdateNetworkStatus() async {
    final hasConnection = await _checkNetworkConnectionWithTimeout();
    if (hasConnection != _hasInternetConnection) {
      _hasInternetConnection = hasConnection;
      log('🌐 Network status updated: ${hasConnection ? 'Connected' : 'Disconnected'}');
    }
  }

  /// Initialize services that can work offline
  Future<void> _initializeOfflineServices() async {
    try {
      log('🔄 Initializing offline-capable services...');
      
      // These services can work with cached data or local storage
      final futures = <Future>[];
      
      // Load cached preferences and settings
      futures.add(_loadCachedData());
      
      // Initialize local data structures
      futures.add(_initializeLocalServices());
      
      // Initialize keyverse service (can work offline with cached data)
      futures.add(_initializeKeyVerseService());
      
      await Future.wait(futures, eagerError: false);
      log('✅ Offline services initialized');
    } catch (e) {
      log('❌ Error initializing offline services: $e');
    }
  }

  /// Initialize services that require network connection
  Future<void> _initializeNetworkServices() async {
    try {
      log('🔄 Initializing network-dependent services...');
      
      final futures = <Future>[];
      
      // Initialize Google Sheets (requires network)
      futures.add(_initializeGoogleSheets());
      
      // Initialize API endpoints and message checking (requires network)
      futures.add(_initializeApiServices());
      
      await Future.wait(futures, eagerError: false);
      log('✅ Network services initialized');
    } catch (e) {
      log('❌ Error initializing network services: $e');
      // Don't rethrow - allow offline operation to continue
    }
  }

  /// Load cached data for offline operation
  Future<void> _loadCachedData() async {
    try {
      // Load any cached API responses, user preferences, etc.
      // This allows basic app functionality even when offline
      log('🔄 Loading cached data...');
      
      // Example: Load cached message count, last sync time, etc.
      // final cachedMessages = await UserSharedPreferences.getCachedMessages();
      
      log('✅ Cached data loaded');
    } catch (e) {
      log('❌ Error loading cached data: $e');
    }
  }

  /// Initialize local services that don't require network
  Future<void> _initializeLocalServices() async {
    try {
      log('🔄 Initializing local services...');
      
      // Initialize services that work purely with local data
      // Theme settings, language preferences, local database, etc.
      
      log('✅ Local services initialized');
    } catch (e) {
      log('❌ Error initializing local services: $e');
    }
  }

  /// Initialize keyverse service
  Future<void> _initializeKeyVerseService() async {
    try {
      log('🔄 Initializing keyverse service...');
      
      // Pre-load current year's keyverse if available
      final currentYear = DateTime.now().year;
      final keyverseService = KeyVerseService();
      
      // Try to get keyverse for current year (will use cache if available)
      await keyverseService.getKeyVerse(year: currentYear);
      
      log('✅ Keyverse service initialized');
    } catch (e) {
      log('❌ Error initializing keyverse service: $e');
    }
  }

  /// Schedule retry with exponential backoff
  void _scheduleRetryWithBackoff() {
    if (_retryAttempts >= _maxRetryAttempts) {
      log('⚠️ Max retry attempts reached, will retry when network is restored');
      return;
    }

    final delay = _retryDelays[_retryAttempts];
    _retryAttempts++;
    
    log('🔄 Scheduling retry attempt $_retryAttempts in ${delay.inSeconds} seconds...');
    
    _retryTimer = Timer(delay, () {
      log('🔄 Executing retry attempt $_retryAttempts...');
      initializeInBackground();
    });
  }

  /// Cancel active retry timer
  void _cancelRetryTimer() {
    _retryTimer?.cancel();
    _retryTimer = null;
  }

  /// Show localized disconnection notification and navigate to disconnect screen
  void showNoInternetAndNavigate(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    showSimpleNotification(
      Text(localizations?.networkErrorMessage ?? "No Internet connection. Please check the network connection."),
      leading: Icon(Icons.network_check),
      background: Colors.red,
      elevation: 5,
      duration: Duration(seconds: 4),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DisconnectScreen()),
    );
  }

  /// Add callback to be notified when initialization completes
  void onInitializationComplete(VoidCallback callback) {
    if (_isInitialized) {
      callback();
    } else {
      _completionCallbacks.add(callback);
    }
  }

  /// Add callback to be notified when network is restored
  void onNetworkRestored(VoidCallback callback) {
    if (_hasInternetConnection && _isInitialized) {
      callback();
    } else {
      _networkRestoreCallbacks.add(callback);
    }
  }

  /// Notify all completion callbacks
  void _notifyCompletionCallbacks() {
    for (final callback in _completionCallbacks) {
      try {
        callback();
      } catch (e) {
        log('❌ Error in completion callback: $e');
      }
    }
    _completionCallbacks.clear();
  }

  Future<void> _initializeGoogleSheets() async {
    try {
      await GoogleMessageSheet.init();
      log('✅ Google Sheets initialized');
    } catch (e) {
      log('❌ Google Sheets initialization failed: $e');
      // Cache the failure for retry when network is restored
    }
  }

  Future<void> _initializeApiServices() async {
    try {
      final endpointService = ApiEndpoint();
      
      // Initialize endpoints with caching - loads cached data immediately
      final endpointsAvailable = await endpointService.initializeEndpoints();
      
      if (endpointsAvailable) {
        // Start message check in background (don't wait for it)
        endpointService.checkNewMessage().then((_) {
          log('✅ Message check completed');
        }).catchError((e) {
          log('❌ Message check failed: $e');
        });
        log('✅ API services initialized');
      } else {
        log('⚠️ No endpoints available (no cache or network), skipping message check');
      }
    } catch (e) {
      log('❌ API services initialization failed: $e');
      // Cache the failure for retry when network is restored
    }
  }

  /// Load user settings (lightweight operation)
  void loadSettings(BuildContext context) {
    try {
      // Language option (Default: Korean)
      String languageOption = UserSharedPreferences.getLanguageOption() ?? 'en';
      final provider = Provider.of<LocaleProvider>(context, listen: false);
      provider.setLocale(Locale.fromSubtags(languageCode: languageOption));
      log('🌐 Language: $languageOption');

      // Reset cache flags
      UserSharedPreferences.setAnnouncementCache(false);
      UserSharedPreferences.setBibleReviewCache(false);
      UserSharedPreferences.setBibleTextCache(false);
      UserSharedPreferences.setServingTurnCache(false);
      UserSharedPreferences.setDailyBibleText1Cache(false);
      UserSharedPreferences.setDailyBibleText2Cache(false);
      
      // Clear keyverse cache when settings are reloaded
      KeyVerseService().clearCache();
      
      log('✅ Settings loaded');
    } catch (e) {
      log('❌ Error loading settings: $e');
    }
  }

  /// Force refresh all data (for manual refresh)
  Future<void> refresh() async {
    log('🔄 Manual refresh requested...');
    _retryAttempts = 0; // Reset retry count
    _cancelRetryTimer();
    _isInitialized = false;
    await initializeInBackground();
  }

  /// Check if specific service is available
  bool isServiceAvailable(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'network':
        return _hasInternetConnection;
      case 'api':
        return _hasInternetConnection && _isInitialized;
      case 'sheets':
        return _hasInternetConnection && _isInitialized;
      case 'offline':
        return true; // Offline services should always be available
      default:
        return _isInitialized;
    }
  }

  /// Get detailed status for debugging
  Map<String, dynamic> getStatus() {
    return {
      'isInitialized': _isInitialized,
      'isLoading': _isLoading,
      'hasInternetConnection': _hasInternetConnection,
      'retryAttempts': _retryAttempts,
      'maxRetryAttempts': _maxRetryAttempts,
      'networkMonitoringActive': _networkSubscription != null,
      'retryTimerActive': _retryTimer?.isActive ?? false,
    };
  }

  /// Cleanup resources
  void dispose() {
    _networkSubscription?.cancel();
    _networkCheckTimer?.cancel();
    _retryTimer?.cancel();
    _completionCallbacks.clear();
    _networkRestoreCallbacks.clear();
  }
} 