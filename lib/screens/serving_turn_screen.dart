import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';

class ServingTurnPage extends StatefulWidget {
  const ServingTurnPage({Key? key}) : super(key: key);

  @override
  _ServingTurnPageState createState() => _ServingTurnPageState();
}

class _ServingTurnPageState extends State<ServingTurnPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load data directly – let API call handle connectivity detection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getServingTurnFromGoogleSheet();
    });
  }

  /// Check network connectivity before loading serving turn data
  Future<void> _checkNetworkAndLoadData() async {
    try {
      log('🔄 Checking network connectivity for serving turns...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 5));

      if (!hasConnection) {
        log('❌ No network connection detected on serving turn screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available, loading serving turns...');
    getServingTurnFromGoogleSheet();
    } catch (e) {
      log('❌ Network check failed on serving turn screen: $e');
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
          returnScreen: ServingTurnPage(),
        ),
      ),
    );
  }

  var servingTurnTiles = <Widget>[];

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
          text1: AppLocalizations.of(context)!.servingTurn,
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
          child: isLoading
              ? _buildLoadingState(theme)
              : (servingTurnTiles.isEmpty
                  ? _buildEmptyState(theme)
                  : CustomScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    // Modern header section
                                    Container(
                                      margin: EdgeInsets.only(bottom: 24),
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
                                              Icons.people_outline_rounded,
                                              size: 28,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.servingTurn,
                                                  style: theme.textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: theme.colorScheme.onSurface,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Church service schedule',
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).animate()
                                      .fadeIn(duration: 600.ms)
                                      .slideY(begin: -0.2, end: 0),
                                    
                                    // Modern card grid
                                    Column(
                                      children: servingTurnTiles.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        Widget tile = entry.value;
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          child: tile,
                                        ).animate()
                                          .fadeIn(delay: (400 + (index * 100)).ms)
                                          .slideX(begin: 0.3, end: 0);
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
        ),
      ),
    );
  }

  /// Build modern loading state
  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
                height: 200,
                width: 200,
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                      decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.dataLoading ?? 'Loading serving turns...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state when no serving turns are available
  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline_rounded,
            size: 80,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.servingTurn ?? 'No serving turns available',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Pull down to refresh or check your connection',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)?.tryAgain ?? 'Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
            ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for serving turns');
    
    // Clear existing data
    setState(() {
      servingTurnTiles.clear();
    });
    
    // Check network and reload data
    await _checkNetworkAndLoadData();
  }

  void getServingTurnFromGoogleSheet() async {
    try {
    //Show loading spinner
      setState(() {
    isLoading = true;
      });

      log('🔄 Fetching serving turn data from Google Sheets...');

    // Ensure SERVING_TURN endpoint is available (may not be bound yet)
    Uri? servingEndpoint = ApiEndpoint.apiMap['SERVING_TURN'];
    if (servingEndpoint == null) {
      log('⚠️ SERVING_TURN endpoint not loaded. Attempting to bind endpoints locally...');
      final bindSuccess = await ApiEndpoint().bindEndpoints();
      if (bindSuccess) {
        servingEndpoint = ApiEndpoint.apiMap['SERVING_TURN'];
      }
    }

    if (servingEndpoint == null) {
      log('❌ SERVING_TURN endpoint still not available after binding attempt');
      throw Exception('API endpoints not initialized. Please try again later.');
    }

    ModelParam modelParam = ModelParam(
      apiEndpoint: servingEndpoint,
      tag: 'servingTurns',
      cacheFileName: kServingTurnData,
      getSharedReference: UserSharedPreferences.getServingTurnCache,
      setSharedReference: UserSharedPreferences.setServingTurnCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _servingTurntList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_servingTurntList)[modelParam.tag] as List;

    List<dynamic> servingTurnList =
        jsonObj.map((tagJson) => ServingTurn.fromJson(tagJson)).toList();

      setState(() {
        for (ServingTurn content in servingTurnList) {
          servingTurnTiles.add(
            _buildModernServingCard(content),
          );
        }

        //Hide loading spinner
        isLoading = false;
      });

      log('✅ Serving turn data loaded successfully');
    } catch (e) {
      log('❌ Error loading serving turn data: $e');
      
      // Check if it's a network-related error
      if (e.toString().contains('connection') || 
          e.toString().contains('network') || 
          e.toString().contains('timeout')) {
        
        // Double-check network connectivity
        try {
          final hasConnection = await InternetConnectionChecker.instance
              .hasConnection
              .timeout(Duration(seconds: 5));
          
          if (!hasConnection) {
            log('🌐 Network disconnection confirmed, navigating to disconnect screen');
            _navigateToDisconnectScreen();
            return;
          }
        } catch (networkError) {
          log('❌ Network verification failed: $networkError');
          _navigateToDisconnectScreen();
          return;
        }
      }
      
      // If not a network error, just hide loading and show error state
      setState(() {
        isLoading = false;
      });
      
      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.networkErrorMessage ?? 
              'Failed to load serving turns. Please try again.',
            ),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: AppLocalizations.of(context)?.tryAgain ?? 'Retry',
              textColor: Colors.white,
              onPressed: () {
                _checkNetworkAndLoadData();
              },
            ),
          ),
        );
      }
    }
  }

  /// Build modern serving card with enhanced styling
  Widget _buildModernServingCard(ServingTurn content) {
    final theme = Theme.of(context);
    
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
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: -1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header with date
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
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      content.date.isEmpty ? 'N/A' : content.date,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content tiles
            ModernServingTurnTile(
              content: content.prayer,
              leadingText: Text(
                AppLocalizations.of(context)!.prayer,
                style: kBodyTextStyle(context),
              ),
              icon: Icons.mic_outlined,
            ),
            ModernServingTurnTile(
              content: content.food,
              leadingText: Text(
                AppLocalizations.of(context)!.foodPrep,
                style: kBodyTextStyle(context),
                maxLines: 1,
              ),
              icon: Icons.restaurant_rounded,
            ),
            ModernServingTurnTile(
              content: content.prayerDate + '\n' + content.babysitter,
              leadingText: Text(
                AppLocalizations.of(context)!.wednesday_worship,
                style: kBodyTextStyle(context),
                maxLines: 1,
              ),
              icon: Icons.baby_changing_station,
            ),
          ],
        ),
      ),
    );
  }
}

class ModernServingTurnTile extends StatelessWidget {
  const ModernServingTurnTile({
    Key? key,
    required this.content,
    required this.leadingText,
    required this.icon,
  }) : super(key: key);

  final Widget leadingText;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 16,
            ),
          ),
          SizedBox(width: 4),
          
          // Leading text
          Expanded(
            flex: 1,
            child: leadingText,
          ),
          
          SizedBox(width: 4),
          
          // Content
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                content.isEmpty ? 'N/A' : content,
                style: kBodyTextStyle(context),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Keep the original ServingTurnTile for backward compatibility if needed
class ServingTurnTile extends StatelessWidget {
  const ServingTurnTile(
      {Key? key, required this.content, required this.leadingText})
      : super(key: key);

  final Widget leadingText;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
      leading: leadingText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                content.isEmpty ? 'N/A' : content,
                style: kBodyTextStyle(context),
                overflow: TextOverflow.ellipsis, // Optional
                maxLines: 1, // Optional
              ),
            ),
          ),
        ],
      ),
    );
  }
}
