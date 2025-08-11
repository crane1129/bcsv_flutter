import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/link.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load data directly – let API call handle connectivity detection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAnnouncementFromGoogleSheet();
    });
  }

  /// Check network connectivity before loading announcement data
  Future<void> _checkNetworkAndLoadData() async {
    try {
      log('📢 Checking network connectivity for announcements...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on announcement screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available, loading announcements...');
      getAnnouncementFromGoogleSheet();
    } catch (e) {
      log('❌ Network check failed on announcement screen: $e');
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
          returnScreen: AnnouncementPage(),
        ),
      ),
    );
  }

  var announcementTiles = <ContentListTile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha:0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.announcement, text2: ''),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: SpinKitFadingCube(
                        itemBuilder: (BuildContext context, int index) {
                          return const DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      AppLocalizations.of(context)?.dataLoading ?? 'Loading announcements...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: announcementTiles.isEmpty
                    ? _buildEmptyState()
                    : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: _buildListPanel(),
                      ),
              ),
      ),
    );
  }

  void getAnnouncementFromGoogleSheet() async {
    try {
      //Show loading spinner
      setState(() {
        isLoading = true;
      });

      log('🔄 Fetching announcement data from Google Sheets...');

      ModelParam modelParam = ModelParam(
        apiEndpoint: ApiEndpoint.apiMap['ANNOUNCEMENT']!,
        tag: 'announcements',
        cacheFileName: kAnnouncementData,
        getSharedReference: UserSharedPreferences.getAnnouncementCache,
        setSharedReference: UserSharedPreferences.setAnnouncementCache,
      );

      Map data = {};
      ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
          modelParam: modelParam, body: data, isBodyRequired: false);

      String _announcementList = await myGoogleDocContent.getContent();
      var jsonObj = jsonDecode(_announcementList)[modelParam.tag] as List;

      List<dynamic> announcementList =
          jsonObj.map((tagJson) => Announcement.fromJson(tagJson)).toList();

      setState(() {
        for (Announcement content in announcementList.reversed) {
          if (content.announcement.isEmpty) {
            continue;
          }
          announcementTiles.add(
            ContentListTile(
              icon: Icons.calendar_today_outlined,
              headerText: Text('${content.date}  설교 ${content.preacher}',
                  style: kBodyTextStyle(context)),
              contents: [
                Text('기도 ${content.prayer}', style: kBodyTextStyle(context)),
                SelectableText(
                    '광고내용\n${content.announcement}\n\n헌금: ${content.offering}',
                    style: kBodyTextStyle(context)).animate().fade(duration: 500.ms),
                Center(
                  child: content.File_url.toString().isEmpty
                      ? null
                      : Link(
                          target: LinkTarget.blank,
                          uri: Uri.parse(content.File_url),
                          builder: (context, followLink) => ElevatedButton(
                            child: const Text('Open PDF'),
                            onPressed: followLink,
                          ),
                        ),
                ),
              ],
            ),
          );
        }

        //Hide loading spinner
        isLoading = false;
      });

      log('✅ Announcement data loaded successfully');
    } catch (e) {
      log('❌ Error loading announcement data: $e');
      
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
              'Failed to load announcements. Please try again.',
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

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for announcements');
    
    // Clear existing data
    setState(() {
      announcementTiles.clear();
    });
    
    // Check network and reload data
    await _checkNetworkAndLoadData();
  }

  /// Build empty state when no announcements are available
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.announcement_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.announcement ?? 'No announcements available',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Pull down to refresh or check your connection',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)?.tryAgain ?? 'Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildListPanel() {
    return ExpansionPanelList.radio(
      children: announcementTiles
          .map(
            (tile) => ExpansionPanelRadio(
              //backgroundColor: Theme.of(context).colorScheme.onSurface,
              value: tile.headerText,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => buildHeaderTile(tile),
              body: Column(
                children: tile.contents.map(buildContentTile).toList(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildHeaderTile(ContentListTile tile) {
    return ListTile(
      leading: Icon(tile.icon),
      title: tile.headerText,
      iconColor: Theme.of(context).colorScheme.surface,
      //tileColor: Theme.of(context).colorScheme.onSurface,
      // selectedTileColor: Colors.indigo,
    );
  }

  Widget buildContentTile(Widget content) {
    return ListTile(
      title: content,
    );
  }
}
