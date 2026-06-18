import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';

import '../components/webview/webview_screen.dart';
import '../services/api_endpoint.dart';

class OfferingScreen extends StatefulWidget {
  const OfferingScreen({super.key});

  @override
  _OfferingScreenState createState() => _OfferingScreenState();
}

class _OfferingScreenState extends State<OfferingScreen> {
  final benevolence_account = "benevolence@bridgeway.online";
  final offering_account = "offering@bridgeway.online";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Check network connectivity when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNetworkConnectivity();
    });
  }

  /// Check network connectivity
  Future<void> _checkNetworkConnectivity() async {
    try {
      log('💝 Checking network connectivity for offering screen...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on offering screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available on offering screen');
    } catch (e) {
      log('❌ Network check failed on offering screen: $e');
      _navigateToDisconnectScreen();
    }
  }

  /// Navigate to disconnect screen when network is unavailable
  void _navigateToDisconnectScreen() {
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DisconnectScreen(
          returnScreen: OfferingScreen(),
        ),
      ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for offering screen');
    await _checkNetworkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ).animate().fadeIn(delay: 200.ms).scale(begin: Offset(0.8, 0.8)),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.offering,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0.95),
              theme.colorScheme.surface.withValues(alpha: 0.9),
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modern hero image section
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/images/offering_background.png',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.3),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate()
                          .fadeIn(duration: 800.ms)
                          .scale(begin: Offset(0.95, 0.95)),

                        // Modern header section
                        Container(
                          margin: EdgeInsets.only(bottom: 32),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                                theme.colorScheme.surface,
                                theme.colorScheme.secondaryContainer.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                blurRadius: 16,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.volunteer_activism,
                                  size: 24,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.offering,
                                      style: kTitleTextStyle(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      AppLocalizations.of(context)!.offeringVerse,
                                      style: kBodyTextStyle(context).copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).animate()
                          .fadeIn(delay: 400.ms, duration: 600.ms)
                          .slideY(begin: -0.2, end: 0),
                        // Sunday Offering Card
                        _buildModernOfferingCard(
                          context: context,
                          theme: theme,
                          title: AppLocalizations.of(context)!.sundayOffering,
                          account: offering_account,
                          icon: Icons.favorite_rounded,
                          iconColor: Colors.green,
                          animationDelay: 600,
                        ),
                        // Benevolence Offering Card
                        _buildModernOfferingCard(
                          context: context,
                          theme: theme,
                          title: AppLocalizations.of(context)!.benevolenceOffering,
                          account: benevolence_account,
                          icon: Icons.favorite_rounded,
                          iconColor: Colors.green,
                          animationDelay: 700,
                        ),
                        // Offering Direction Card
                        _buildModernDirectionCard(
                          context: context,
                          theme: theme,
                          animationDelay: 800,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build modern offering card with enhanced styling
  Widget _buildModernOfferingCard({
    required BuildContext context,
    required ThemeData theme,
    required String title,
    required String account,
    required IconData icon,
    required Color iconColor,
    required int animationDelay,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header with title
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: kListTitleStyleBlack(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Account and copy section
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.1),
                        ),
                      ),
                                             child: Text(
                         account,
                         style: kListTitleStyleBlack(context).copyWith(
                           color: theme.colorScheme.onSurface,
                           fontFamily: 'monospace',
                           fontSize: 12.0,
                         ),
                       ),
                    ),
                  ),
                                     SizedBox(width: 8),
                   Container(
                     decoration: BoxDecoration(
                       color: theme.colorScheme.primary,
                       borderRadius: BorderRadius.circular(8),
                       boxShadow: [
                         BoxShadow(
                           color: theme.colorScheme.primary.withValues(alpha: 0.3),
                           blurRadius: 6,
                           offset: Offset(0, 2),
                         ),
                       ],
                     ),
                     child: Material(
                       color: Colors.transparent,
                       child: InkWell(
                         borderRadius: BorderRadius.circular(8),
                         onTap: () async {
                           await _copyToClipboard(account);
                         },
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Icon(
                                 Icons.copy_rounded,
                                 color: theme.colorScheme.onPrimary,
                                 size: 16,
                               ),
                               SizedBox(width: 6),
                               Text(
                                 AppLocalizations.of(context)!.copy,
                                 style: theme.textTheme.labelMedium?.copyWith(
                                   color: theme.colorScheme.onPrimary,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: animationDelay.ms, duration: 600.ms)
      .slideX(begin: 0.3, end: 0);
  }

  /// Build modern direction card
  Widget _buildModernDirectionCard({
    required BuildContext context,
    required ThemeData theme,
    required int animationDelay,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.surface.withValues(alpha: 0.95),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header with title
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.08),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.info_rounded,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.offering_direction,
                      style: kListTitleStyleBlack(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content and button section
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.offering_direction_text,
                      style: kListTitleStyleBlack(context).copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            await _openOfferingDirection();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.open_in_new_rounded,
                                  color: theme.colorScheme.onPrimary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.openButtonText,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: animationDelay.ms, duration: 600.ms)
      .slideX(begin: 0.3, end: 0);
  }

  /// Copy account to clipboard with modern feedback
  Future<void> _copyToClipboard(String account) async {
    try {
      await Clipboard.setData(ClipboardData(text: account));
      
      if (mounted) {
        showSimpleNotification(
          Text(
            '$account copied to clipboard',
            style: TextStyle(color: Colors.white),
          ),
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          background: Colors.green,
          elevation: 8,
          duration: Duration(seconds: 3),
        );
      }
      
      log('✅ Account copied to clipboard: $account');
    } catch (e) {
      log('❌ Failed to copy to clipboard: $e');
      
      if (mounted) {
        showSimpleNotification(
          Text(
            'Failed to copy to clipboard',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    }
  }

  /// Open offering direction in webview
  Future<void> _openOfferingDirection() async {
    try {
      // Check network connectivity before opening webview
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 5));

      if (!hasConnection) {
        log('❌ No network connection for webview');
        _navigateToDisconnectScreen();
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WebViewApp(
              url: ApiEndpoint.apiMap['ONLINE_OFFERING_DIRECTION']!,
              title1: AppLocalizations.of(context)!.offering_direction,
              title2: '',
            );
          },
        ),
      );
      
      log('🌐 Opening offering direction webview');
    } catch (e) {
      log('❌ Error opening offering direction: $e');
      
      if (mounted) {
        showSimpleNotification(
          Text(
            AppLocalizations.of(context)?.networkErrorMessage ?? 
            'Failed to open directions. Please check your connection.',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    }
  }
}
