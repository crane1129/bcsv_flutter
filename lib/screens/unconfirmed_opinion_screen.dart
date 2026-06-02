import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/appbar_header_text.dart';
import '../utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:developer';

class UnconfirmedOpinionsScreen extends StatefulWidget {
  const UnconfirmedOpinionsScreen({super.key});

  @override
  _UnconfirmedOpinionsScreenState createState() =>
      _UnconfirmedOpinionsScreenState();
}

class _UnconfirmedOpinionsScreenState extends State<UnconfirmedOpinionsScreen> {
  Future<List<Map<String, dynamic>>>? _futureOpinions;

  @override
  void initState() {
    super.initState();
    // Check network connectivity when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNetworkAndLoadData();
    });
  }

  /// Check network connectivity and load data
  Future<void> _checkNetworkAndLoadData() async {
    try {
      log('🔍 Checking network connectivity for unconfirmed opinions...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on unconfirmed opinions screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available on unconfirmed opinions screen');
      setState(() {
    _futureOpinions = fetchOpinions();
      });
    } catch (e) {
      log('❌ Network check failed on unconfirmed opinions screen: $e');
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
          returnScreen: UnconfirmedOpinionsScreen(),
        ),
      ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for unconfirmed opinions');
    await _checkNetworkAndLoadData();
  }

  Future<List<Map<String, dynamic>>> fetchOpinions() async {
    try {
      log('📋 Fetching unconfirmed opinions...');
      
    final uri =
        Uri.https('www.bridgeway.online', '/_functions/unconfirmedOpinions');
      final response = await http.get(uri).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
        final opinions = List<Map<String, dynamic>>.from(json['result']);
        log('✅ Loaded ${opinions.length} unconfirmed opinions');
        return opinions;
    } else {
        log('❌ Failed to load unconfirmed opinions: ${response.statusCode}');
      throw Exception("Failed to load unconfirmed opinions");
      }
    } catch (e) {
      log('❌ Exception fetching unconfirmed opinions: $e');
      
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
            log('🌐 Network disconnection confirmed during fetch');
            _navigateToDisconnectScreen();
            return [];
          }
        } catch (networkError) {
          log('❌ Network verification failed during fetch: $networkError');
          _navigateToDisconnectScreen();
          return [];
        }
      }
      
      rethrow;
    }
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
            text1: AppLocalizations.of(context)!.unconfirmed_opinion,
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
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureOpinions,
        builder: (context, snapshot) {
          // Show loading state if _futureOpinions is null or still loading
          if (_futureOpinions == null || snapshot.connectionState != ConnectionState.done) {
                  return _buildLoadingState(theme);
          }

          if (snapshot.hasError) {
                  return _buildErrorState(theme, snapshot.error.toString());
          }

          final opinions = snapshot.data ?? [];
          if (opinions.isEmpty) {
                  return _buildEmptyState(theme);
                }

                return CustomScrollView(
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
                                      Icons.pending_actions_rounded,
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
                                          'Pending Opinions',
                                          style: theme.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${opinions.length} opinion${opinions.length != 1 ? 's' : ''} awaiting confirmation',
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
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
              final item = opinions[index];
                          return _buildModernOpinionCard(item, index);
                        },
                        childCount: opinions.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Modern loading state widget
  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
            SizedBox(height: 16),
            Text(
              'Loading opinions...',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Modern error state widget
  Widget _buildErrorState(ThemeData theme, String error) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.error.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Error Loading Opinions',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              error.replaceAll('Exception: ', ''),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Modern empty state widget
  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 48,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'All Caught Up!',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'No unconfirmed opinions at the moment.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Build modern opinion card
  Widget _buildModernOpinionCard(Map<String, dynamic> item, int index) {
    final theme = Theme.of(context);
              final rawDate = item['dateCreated'];
              final formattedDate = rawDate != null
                  ? DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.parse(rawDate))
                  : 'Unknown date';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with category and date
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item['category'] ?? "No Category",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    formattedDate,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Message content
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  item['message'] ?? "",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),

              // User information
              if ((item['name']?.isNotEmpty ?? false) || (item['email']?.isNotEmpty ?? false)) ...[
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item['name']?.isNotEmpty ?? false)
                        Row(
                          children: [
                            Icon(Icons.person_rounded, 
                                 size: 16, 
                                 color: theme.colorScheme.secondary),
                            SizedBox(width: 8),
                            Text(
                              item['name'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      if ((item['name']?.isNotEmpty ?? false) && (item['email']?.isNotEmpty ?? false))
                        SizedBox(height: 4),
                      if (item['email']?.isNotEmpty ?? false)
                        Row(
                          children: [
                            Icon(Icons.email_rounded, 
                                 size: 16, 
                                 color: theme.colorScheme.secondary),
                            SizedBox(width: 8),
                            Text(
                              item['email'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],

              // Attachment section
                      if ((item['attachmentUrl'] ?? '').isNotEmpty) ...[
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image preview (if it's an image)
                        if (isImageFile(item['attachmentUrl']))
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                            child: Image.network(
                              item['attachmentUrl'],
                              fit: BoxFit.cover,
                              height: 200,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  "❌ Image failed to load",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Download button
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.tertiary.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _downloadAttachment(item['attachmentUrl']),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.download_rounded,
                                      color: theme.colorScheme.onTertiary,
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Download Attachment',
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: theme.colorScheme.onTertiary,
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

              // Action buttons
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => confirmOpinion(item['id']),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Confirm',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
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
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _copyOpinionToClipboard(item, formattedDate),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                Icon(
                                  Icons.copy_rounded,
                                  color: theme.colorScheme.onSurface,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Copy',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: theme.colorScheme.onSurface,
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
            ],
          ),
        ),
      ),
    ).animate()
      .fadeIn(delay: (index * 100).ms, duration: 400.ms)
      .slideX(begin: 0.3, end: 0);
  }

  /// Download attachment file
  Future<void> _downloadAttachment(String url) async {
    try {
      log('📥 Attempting to download attachment: $url');
      
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        log('✅ Successfully opened attachment URL');
      } else {
        log('❌ Cannot launch attachment URL');
        
        if (mounted) {
          showSimpleNotification(
            Text(
              "❌ Failed to open attachment file",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.error_rounded, color: Colors.white),
            background: Colors.red,
            elevation: 8,
          );
        }
      }
    } catch (e) {
      log('❌ Exception downloading attachment: $e');
      
      if (mounted) {
        showSimpleNotification(
          Text(
            "❌ Error accessing attachment",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    }
  }

  /// Copy opinion details to clipboard
  Future<void> _copyOpinionToClipboard(Map<String, dynamic> item, String formattedDate) async {
    try {
                              final buffer = StringBuffer();
                              buffer.writeln("Category: ${item['category'] ?? ''}");
                              buffer.writeln("Message: ${item['message'] ?? ''}");
                              if ((item['name'] ?? '').isNotEmpty) buffer.writeln("Name: ${item['name']}");
                              if ((item['email'] ?? '').isNotEmpty) buffer.writeln("Email: ${item['email']}");
                              buffer.writeln("Date: $formattedDate");
      
      await Clipboard.setData(ClipboardData(text: buffer.toString()));
      log('✅ Opinion copied to clipboard');
      
      if (mounted) {
        showSimpleNotification(
          Text(
            "📋 Opinion copied to clipboard",
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
          background: Colors.blue,
          elevation: 8,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      log('❌ Failed to copy opinion: $e');
      
      if (mounted) {
        showSimpleNotification(
          Text(
            "❌ Failed to copy to clipboard",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    }
  }

  Future<void> confirmOpinion(String id) async {
    // Check network connectivity before confirming
    try {
      log('🔍 Checking network connectivity before confirming opinion...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 5));

      if (!hasConnection) {
        log('❌ No network connection for opinion confirmation');
        _navigateToDisconnectScreen();
        return;
      }
    } catch (e) {
      log('❌ Network check failed for opinion confirmation: $e');
      _navigateToDisconnectScreen();
      return;
    }

    try {
      log('✅ Confirming opinion with ID: $id');
      
    final uri = Uri.https('www.bridgeway.online', '/_functions/confirmOpinion');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
      ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
        log('✅ Opinion confirmed successfully');
        
      setState(() {
        _futureOpinions = fetchOpinions(); // Refresh the list
      });

        if (mounted) {
          showSimpleNotification(
            Text(
              "✅ Opinion confirmed successfully",
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
            duration: Duration(seconds: 4),
          );
        }
    } else {
        log('❌ Failed to confirm opinion: ${response.statusCode} - ${response.body}');
        
        if (mounted) {
          showSimpleNotification(
            Text(
              "❌ Failed to confirm opinion. Please try again.",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.error_rounded, color: Colors.white),
            background: Colors.red,
            elevation: 8,
          );
        }
      }
    } catch (e) {
      log('❌ Exception confirming opinion: $e');
      
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
            log('🌐 Network disconnection confirmed during confirmation');
            _navigateToDisconnectScreen();
            return;
          }
        } catch (networkError) {
          log('❌ Network verification failed during confirmation: $networkError');
          _navigateToDisconnectScreen();
          return;
        }
      }
      
      if (mounted) {
        showSimpleNotification(
          Text(
            "⚠️ An error occurred. Please try again.",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.warning_rounded, color: Colors.white),
          background: Colors.orange,
          elevation: 8,
        );
      }
    }
  }

  bool isImageFile(String url) {
    try {
      final uri = Uri.parse(url);
      final path = uri.path.toLowerCase(); // get only the path, excluding query
      return path.endsWith('.jpg') ||
          path.endsWith('.jpeg') ||
          path.endsWith('.png') ||
          path.endsWith('.gif') ||
          path.endsWith('.webp');
    } catch (_) {
      return false;
    }
  }
}
