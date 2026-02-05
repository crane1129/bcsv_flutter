import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';

/// Connectivity state with detailed information
class ConnectivityState {
  final bool isConnected;
  final List<ConnectivityResult> connectionTypes;
  final DateTime? lastChecked;

  const ConnectivityState({
    required this.isConnected,
    this.connectionTypes = const [],
    this.lastChecked,
  });

  factory ConnectivityState.initial() {
    return const ConnectivityState(isConnected: true);
  }

  factory ConnectivityState.fromResults(List<ConnectivityResult> results) {
    return ConnectivityState(
      isConnected: results.any((r) => r != ConnectivityResult.none),
      connectionTypes: results,
      lastChecked: DateTime.now(),
    );
  }

  bool get isWifi =>
      connectionTypes.contains(ConnectivityResult.wifi);

  bool get isMobile =>
      connectionTypes.contains(ConnectivityResult.mobile);

  bool get isOffline => !isConnected;

  ConnectivityState copyWith({
    bool? isConnected,
    List<ConnectivityResult>? connectionTypes,
    DateTime? lastChecked,
  }) {
    return ConnectivityState(
      isConnected: isConnected ?? this.isConnected,
      connectionTypes: connectionTypes ?? this.connectionTypes,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }
}

/// Notifier for connectivity state
class ConnectivityNotifier extends StateNotifier<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityNotifier({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(ConnectivityState.initial()) {
    _init();
  }

  Future<void> _init() async {
    // Get initial connectivity state
    try {
      final results = await _connectivity.checkConnectivity();
      state = ConnectivityState.fromResults(results);
      log('Initial connectivity: ${state.isConnected ? "online" : "offline"}');
    } catch (e) {
      log('Error checking initial connectivity: $e');
    }

    // Listen for changes
    _subscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        final newState = ConnectivityState.fromResults(results);
        if (newState.isConnected != state.isConnected) {
          log('Connectivity changed: ${newState.isConnected ? "online" : "offline"}');
        }
        state = newState;
      },
      onError: (e) {
        log('Connectivity stream error: $e');
      },
    );
  }

  /// Force refresh connectivity status
  Future<void> refresh() async {
    try {
      final results = await _connectivity.checkConnectivity();
      state = ConnectivityState.fromResults(results);
    } catch (e) {
      log('Error refreshing connectivity: $e');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// Main connectivity provider
final connectivityNotifierProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityState>((ref) {
  return ConnectivityNotifier();
});

/// Simple boolean provider for checking if online
final isOnlineProvider = Provider<bool>((ref) {
  return ref.watch(connectivityNotifierProvider).isConnected;
});

/// Provider that returns true only when on WiFi
final isOnWifiProvider = Provider<bool>((ref) {
  return ref.watch(connectivityNotifierProvider).isWifi;
});
