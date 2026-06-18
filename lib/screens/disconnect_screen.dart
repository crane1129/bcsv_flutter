import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'package:bcsv_flutter_project/screens/home_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import 'dart:developer';

class DisconnectScreen extends StatefulWidget {
  final Widget? returnScreen;
  const DisconnectScreen({super.key, this.returnScreen});

  @override
  _DisconnectScreenState createState() => _DisconnectScreenState();
}

class _DisconnectScreenState extends State<DisconnectScreen>
    with TickerProviderStateMixin {
  StreamSubscription<InternetConnectionStatus>? _networkSubscription;
  Timer? _periodicCheckTimer;
  bool _isCheckingConnection = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _setupNetworkMonitoring();
    _startPeriodicChecking();
  }

  @override
  void dispose() {
    _networkSubscription?.cancel();
    _periodicCheckTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  void _setupNetworkMonitoring() {
    // Listen to real-time network status changes
    _networkSubscription = InternetConnectionChecker.instance
        .onStatusChange
        .listen(_onNetworkStatusChanged);
  }

  void _startPeriodicChecking() {
    // Additional periodic check as backup (every 3 seconds on disconnect screen)
    _periodicCheckTimer = Timer.periodic(Duration(seconds: 3), (_) {
      _checkNetworkAndNavigate();
    });
  }

  void _onNetworkStatusChanged(InternetConnectionStatus status) {
    if (status == InternetConnectionStatus.connected) {
      log('🌐 Network restored on disconnect screen');
      _handleNetworkRestoration();
    }
  }

  Future<void> _checkNetworkAndNavigate() async {
    if (_isCheckingConnection) return;
    
    setState(() {
      _isCheckingConnection = true;
    });

    try {
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 5));
      
      if (hasConnection && mounted) {
        log('✅ Network connection verified, navigating to home');
        _handleNetworkRestoration();
      }
    } catch (e) {
      log('❌ Network check failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingConnection = false;
        });
      }
    }
  }

  void _handleNetworkRestoration() {
    if (!mounted) return;

    // Cancel timers to prevent multiple navigation attempts
    _periodicCheckTimer?.cancel();
    _networkSubscription?.cancel();

    // Re-initialize background services
    BackgroundService().refresh();

    // Navigate back to the calling screen or home as fallback
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget.returnScreen ?? MyHomePage(),
      ),
    );
  }

  Future<void> _onRetryPressed() async {
    await _checkNetworkAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
                         colors: [
               theme.colorScheme.surface,
               theme.colorScheme.surface.withValues(alpha: 0.9),
               theme.colorScheme.surface.withValues(alpha: 0.8),
             ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                // Top spacer
                SizedBox(height: screenSize.height * 0.1),
                
                // Disconnect image with modern styling
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/disconnect.png',
                      width: screenSize.width * 0.5,
                      height: screenSize.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: Offset(0.8, 0.8)),
                
                SizedBox(height: 40),
                
                // Error message
                Text(
                  localizations?.networkErrorMessage ?? 
                  "No Internet connection. Please check your network connection.",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ).animate()
                  .fadeIn(delay: 300.ms, duration: 800.ms)
                  .slideY(begin: 0.3, end: 0),
                
                SizedBox(height: 20),
                
                // Subtitle
                Text(
                  localizations?.retryNetworkMessage ?? 
                  "We'll automatically connect when your network is available, or you can try again.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ).animate()
                  .fadeIn(delay: 600.ms, duration: 800.ms)
                  .slideY(begin: 0.2, end: 0),
                
                // Flexible spacer
                Expanded(child: SizedBox()),
                
                // Connection status indicator
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Icon(
                              Icons.wifi_off_rounded,
                              color: theme.colorScheme.error,
                              size: 24,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 12),
                      Text(
                        localizations?.checkingConnection ?? "Checking connection...",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: 900.ms),
                
                SizedBox(height: 32),
                
                // Retry button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isCheckingConnection ? null : _onRetryPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      elevation: 4,
                      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isCheckingConnection
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                localizations?.checkingConnection ?? "Checking...",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh_rounded),
                              SizedBox(width: 8),
                              Text(
                                localizations?.tryAgain ?? "Try Again",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ).animate()
                  .fadeIn(delay: 1200.ms)
                  .slideY(begin: 0.3, end: 0),
                
                SizedBox(height: 24),
                
                // Auto-retry info
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.autorenew_rounded,
                        size: 16,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      SizedBox(width: 8),
                      Text(
                        localizations?.autoRetryMessage ?? "Auto-retry active",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(delay: 1500.ms),
                
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
