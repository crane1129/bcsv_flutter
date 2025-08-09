import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BibleKeywordSearchScreen extends StatefulWidget {
  @override
  _BibleKeywordSearchScreenState createState() => _BibleKeywordSearchScreenState();
}

class _BibleKeywordSearchScreenState extends State<BibleKeywordSearchScreen> {
  bool isLoading = false;
  Set<int> selectedIndexes = {};

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
      log('🔍 Checking network connectivity for bible keyword search...');

      final hasConnection = await InternetConnectionChecker
          .instance.hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on bible keyword search screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available on bible keyword search screen');
    } catch (e) {
      log('❌ Network check failed on bible keyword search screen: $e');
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
          returnScreen: BibleKeywordSearchScreen(),
        ),
      ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for bible keyword search');
    await _checkNetworkConnectivity();
  }

  // Text input controller
  final keywordCtrl = TextEditingController();
  double _fontSize = 16.0;

  // Verse results
  List<Map<String, dynamic>> results = [];

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
          text1: 'Keyword Search',
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.text_increase_rounded),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      _fontSize = (_fontSize + 2).clamp(10.0, 30.0);
                    });
                  },
                  tooltip: 'Increase Font Size',
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                ),
                IconButton(
                  icon: Icon(Icons.text_decrease_rounded),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      _fontSize = (_fontSize - 2).clamp(10.0, 30.0);
                    });
                  },
                  tooltip: 'Decrease Font Size',
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms),
        ],
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
          child: Stack(
            children: [
              // Main content with modern design
              RefreshIndicator(
                onRefresh: _refreshData,
                child: CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Modern search form section
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    theme.colorScheme.primaryContainer
                                        .withValues(alpha: 0.1),
                                    theme.colorScheme.surface,
                                    theme.colorScheme.secondaryContainer
                                        .withValues(alpha: 0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: theme.colorScheme.outline
                                      .withValues(alpha: 0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.08),
                                    blurRadius: 16,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header with search icon
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Icon(
                                          Icons.manage_search_rounded,
                                          size: 24,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.keywordSearch,
                                              style: theme.textTheme.titleLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Search Bible verses by keyword',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: theme
                                                    .colorScheme.onSurface
                                                    .withValues(alpha: 0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Font size indicator
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme
                                              .colorScheme.primaryContainer
                                              .withValues(alpha: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '${_fontSize.toInt()}pt',
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),

                                  // Keyword input field with modern styling
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface
                                          .withValues(alpha: 0.7),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: theme.colorScheme.outline
                                            .withValues(alpha: 0.1),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: keywordCtrl,
                                      style: kBodyTextStyle(context),
                                      decoration: InputDecoration(
                                        labelText: 'Enter keyword to search',
                                        hintText: 'e.g., love, hope, faith, peace...',
                                        labelStyle: TextStyle(
                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintStyle: TextStyle(
                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                          fontSize: 12,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search_rounded,
                                          color: theme.colorScheme.primary,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: theme.colorScheme.outline.withValues(alpha: 0.3),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                            color: theme.colorScheme.primary,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                      ),
                                      onSubmitted: (_) => searchKeyword(),
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  // Modern search button
                                  SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isLoading
                                            ? theme.colorScheme.primary
                                                .withValues(alpha: 0.5)
                                            : theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.colorScheme.primary
                                                .withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          onTap: isLoading ? null : searchKeyword,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (isLoading) ...[
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(
                                                        theme.colorScheme
                                                            .onPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                ] else ...[
                                                  Icon(
                                                    Icons.search_rounded,
                                                    color: theme
                                                        .colorScheme.onPrimary,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                ],
                                                Text(
                                                  isLoading
                                                      ? 'Searching...'
                                                      : AppLocalizations.of(context)!.search,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    color: theme
                                                        .colorScheme.onPrimary,
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
                            )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .slideY(begin: -0.2, end: 0),

                            // Modern Search Results section
                            if (results.isNotEmpty ||
                                selectedIndexes.isNotEmpty)
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: theme.colorScheme.outline
                                        .withValues(alpha: 0.1),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow
                                          .withValues(alpha: 0.08),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Results header
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: theme
                                            .colorScheme.secondaryContainer
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        border: Border(
                                          bottom: BorderSide(
                                            color: theme.colorScheme.outline
                                                .withValues(alpha: 0.08),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme.secondary
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              Icons.list_alt_rounded,
                                              size: 20,
                                              color:
                                                  theme.colorScheme.secondary,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              results.isEmpty
                                                  ? 'No Results'
                                                  : 'Search Results (${results.length})',
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                            ),
                                          ),
                                          if (selectedIndexes.isNotEmpty)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary
                                                    .withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '${selectedIndexes.length} selected',
                                                style: theme
                                                    .textTheme.labelSmall
                                                    ?.copyWith(
                                                  color:
                                                      theme.colorScheme.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),

                                    // Results content
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          if (results.isEmpty)
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(32),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Icons.search_off_rounded,
                                                    size: 48,
                                                    color: theme
                                                        .colorScheme.onSurface
                                                        .withValues(alpha: 0.3),
                                                  ),
                                                  SizedBox(height: 16),
                                                  Text(
                                                    'No results found for your keyword',
                                                    style: kBodyTextStyle(
                                                            context,
                                                            fontSize: _fontSize)
                                                        .copyWith(
                                                      color: theme
                                                          .colorScheme.onSurface
                                                          .withValues(
                                                              alpha: 0.6),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            )
                                          else
                                            ...results
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              final i = entry.key;
                                              final verse = entry.value;
                                              final isSelected =
                                                  selectedIndexes.contains(i);

                                              return Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 8),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? theme
                                                          .colorScheme.primary
                                                          .withValues(
                                                              alpha: 0.1)
                                                      : theme
                                                          .colorScheme.surface
                                                          .withValues(
                                                              alpha: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: isSelected
                                                        ? theme
                                                            .colorScheme.primary
                                                            .withValues(
                                                                alpha: 0.3)
                                                        : theme
                                                            .colorScheme.outline
                                                            .withValues(
                                                                alpha: 0.1),
                                                  ),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    onTap: () {
                                                      setState(() {
                                                        if (isSelected) {
                                                          selectedIndexes
                                                              .remove(i);
                                                        } else {
                                                          selectedIndexes
                                                              .add(i);
                                                        }
                                                      });
                                                    },
                                                    onLongPress: () {
                                                      setState(() {
                                                        selectedIndexes.add(i);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(16),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: theme
                                                                  .colorScheme
                                                                  .primary
                                                                  .withValues(
                                                                      alpha:
                                                                          0.1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Text(
                                                              '${verse['chapterVerse']}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    _fontSize -
                                                                        2,
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12),
                                                          Expanded(
                                                            child: Text(
                                                              verse['text'],
                                                              style: TextStyle(
                                                                fontSize:
                                                                    _fontSize,
                                                                color: theme
                                                                    .colorScheme
                                                                    .onSurface,
                                                                height: 1.5,
                                                              ),
                                                            ),
                                                          ),
                                                          if (isSelected)
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 8),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                              ),
                                                              child: Icon(
                                                                Icons.check,
                                                                size: 16,
                                                                color: theme
                                                                    .colorScheme
                                                                    .onPrimary,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  .animate()
                                                  .fadeIn(
                                                      delay: (i * 50).ms,
                                                      duration: 400.ms)
                                                  .slideX(begin: 0.3, end: 0);
                                            }).toList(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 800.ms, duration: 600.ms)
                                  .slideY(begin: 0.3, end: 0),

                            // Modern action buttons section
                            if (selectedIndexes.isNotEmpty ||
                                results.isNotEmpty)
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: theme.colorScheme.outline
                                        .withValues(alpha: 0.1),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.shadow
                                          .withValues(alpha: 0.06),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    if (selectedIndexes.isNotEmpty) ...[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.colorScheme.primary,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: theme
                                                        .colorScheme.primary
                                                        .withValues(alpha: 0.3),
                                                    blurRadius: 6,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  onTap: copySelectedVerses,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.copy_rounded,
                                                          color: theme
                                                              .colorScheme
                                                              .onPrimary,
                                                          size: 18,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Flexible(
                                                          child: Text(
                                                            'Copy (${selectedIndexes.length})',
                                                            style: theme
                                                                .textTheme
                                                                .labelLarge
                                                                ?.copyWith(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: theme
                                                      .colorScheme.outline
                                                      .withValues(alpha: 0.3),
                                                ),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndexes.clear();
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.clear_rounded,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          size: 18,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Flexible(
                                                          child: Text(
                                                            'Clear',
                                                            style: theme
                                                                .textTheme
                                                                .labelLarge
                                                                ?.copyWith(
                                                              color: theme
                                                                  .colorScheme
                                                                  .onSurface,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                      if (results.isNotEmpty)
                                        SizedBox(height: 12),
                                    ],
                                    if (results.isNotEmpty)
                                      SizedBox(
                                        width: double.infinity,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.secondary,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: theme
                                                    .colorScheme.secondary
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 6,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              onTap: copyAllResults,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.copy_all_rounded,
                                                      color: theme.colorScheme
                                                          .onSecondary,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Flexible(
                                                      child: Text(
                                                        'Copy All (${results.length})',
                                                        style: theme.textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                          color: theme
                                                              .colorScheme
                                                              .onSecondary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                              )
                                  .animate()
                                  .fadeIn(delay: 1000.ms, duration: 500.ms)
                                  .slideY(begin: 0.3, end: 0),

                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Modern loading overlay
              if (isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: SpinKitFadingCube(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Searching for keyword...',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void copyAllResults() {
    if (results.isEmpty) return;

    final buffer = StringBuffer();
    for (var verse in results) {
      buffer.writeln(
          '${verse['book']} ${verse['chapterVerse']} — ${verse['text']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString())).then((_) {
      log('✅ Copied ${results.length} verses to clipboard');

      if (mounted) {
        showSimpleNotification(
          Text(
            '📋 Copied ${results.length} verses to clipboard',
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
    }).catchError((error) {
      log('❌ Failed to copy verses: $error');

      if (mounted) {
        showSimpleNotification(
          Text(
            'Failed to copy verses',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    });
  }

  void copySelectedVerses() {
    if (selectedIndexes.isEmpty) return;

    final buffer = StringBuffer();
    final sortedIndexes = selectedIndexes.toList()..sort();
    final selected_verse_count = selectedIndexes.length;

    for (var i in sortedIndexes) {
      final verse = results[i];
      buffer.writeln(
          '${verse['book']} ${verse['chapterVerse']} — ${verse['text']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString())).then((_) {
      log('✅ Copied ${selected_verse_count} selected verses to clipboard');

      if (mounted) {
        showSimpleNotification(
          Text(
            '📋 Copied ${selected_verse_count} selected verse${selected_verse_count > 1 ? 's' : ''} to clipboard',
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

        setState(() => selectedIndexes.clear());
      }
    }).catchError((error) {
      log('❌ Failed to copy selected verses: $error');

      if (mounted) {
        showSimpleNotification(
          Text(
            'Failed to copy selected verses',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
          elevation: 8,
        );
      }
    });
  }

  Future<void> searchKeyword() async {
    FocusScope.of(context).unfocus(); // Hide the keyboard

    // Check network connectivity before searching
    try {
      log('🔍 Checking network connectivity before keyword search...');

      final hasConnection = await InternetConnectionChecker
          .instance.hasConnection
          .timeout(Duration(seconds: 5));

      if (!hasConnection) {
        log('❌ No network connection for keyword search');
        _navigateToDisconnectScreen();
        return;
      }
    } catch (e) {
      log('❌ Network check failed for keyword search: $e');
      _navigateToDisconnectScreen();
      return;
    }

    final keyword = keywordCtrl.text.trim();

    if (keyword.isEmpty) {
      if (mounted) {
        showSimpleNotification(
          Text(
            '⚠️ Please enter a keyword to search',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.warning_rounded, color: Colors.white),
          background: Colors.orange,
          elevation: 8,
        );
      }
      return;
    }

    // Start loading
    setState(() {
      isLoading = true;
      results.clear();
      selectedIndexes.clear(); // Clear selections when starting new search
    });

    log('🔍 Searching bible for keyword: $keyword');

    final query = {
      'keyword': keyword,
    };

    final uri =
        Uri.https('www.bridgeway.online', '/_functions/bibleSearch', query);

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          results = List<Map<String, dynamic>>.from(json['result']);
        });

        log('✅ Bible keyword search completed: ${results.length} results found');

        if (mounted) {
          showSimpleNotification(
            Text(
              '✅ Found ${results.length} verses containing "$keyword"',
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
      } else {
        log("❌ Bible keyword search failed: ${response.statusCode} - ${response.body}");
        if (mounted) {
          showSimpleNotification(
            Text(
              '❌ Search failed. Please try again.',
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.error_rounded, color: Colors.white),
            background: Colors.red,
            elevation: 8,
          );
        }
      }
    } catch (e) {
      log("❌ Bible keyword search exception: $e");

      // Check if it's a network-related error
      if (e.toString().contains('connection') ||
          e.toString().contains('network') ||
          e.toString().contains('timeout')) {
        // Double-check network connectivity
        try {
          final hasConnection = await InternetConnectionChecker
              .instance.hasConnection
              .timeout(Duration(seconds: 5));

          if (!hasConnection) {
            log('🌐 Network disconnection confirmed during keyword search');
            _navigateToDisconnectScreen();
            return;
          }
        } catch (networkError) {
          log('❌ Network verification failed during keyword search: $networkError');
          _navigateToDisconnectScreen();
          return;
        }
      }

      if (mounted) {
        showSimpleNotification(
          Text(
            '⚠️ Network error or server issue. Please try again.',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.warning_rounded, color: Colors.white),
          background: Colors.orange,
          elevation: 8,
        );
      }
    } finally {
      // Stop loading in all cases
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
} 