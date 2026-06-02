import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';

class BibleSearchScreen extends StatefulWidget {
  const BibleSearchScreen({super.key});

  @override
  _BibleSearchScreenState createState() => _BibleSearchScreenState();
}

class _BibleSearchScreenState extends State<BibleSearchScreen> {
  bool isLoading = false;
  // Dropdown values
  String selectedTestament = 'new';
  String? selectedBook;
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
      log('🔍 Checking network connectivity for bible search...');

      final hasConnection = await InternetConnectionChecker
          .instance.hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on bible search screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available on bible search screen');
    } catch (e) {
      log('❌ Network check failed on bible search screen: $e');
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
          returnScreen: BibleSearchScreen(),
        ),
      ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for bible search');
    await _checkNetworkConnectivity();
  }

  // Text input controllers
  final startChapCtrl = TextEditingController();
  final startVerseCtrl = TextEditingController();
  final endChapCtrl = TextEditingController();
  final endVerseCtrl = TextEditingController();
  double _fontSize = 16.0;
  final oldTestamentBooks = [
    "창세기",
    "출애굽기",
    "레위기",
    "민수기",
    "신명기",
    "여호수아",
    "사사기",
    "룻기",
    "사무엘상",
    "사무엘하",
    "열왕기상",
    "열왕기하",
    "역대상",
    "역대하",
    "에스라",
    "느헤미야",
    "에스더",
    "욥기",
    "시편",
    "잠언",
    "전도서",
    "아가",
    "이사야",
    "예레미야",
    "예레미야 애가",
    "에스겔",
    "다니엘",
    "호세아",
    "요엘",
    "아모스",
    "오바댜",
    "요나",
    "미가",
    "나훔",
    "하박국",
    "스바냐",
    "학개",
    "스가랴",
    "말라기"
  ];

  final newTestamentBooks = [
    "마태복음",
    "마가복음",
    "누가복음",
    "요한복음",
    "사도행전",
    "로마서",
    "고린도전서",
    "고린도후서",
    "갈라디아서",
    "에베소서",
    "빌립보서",
    "골로새서",
    "데살로니가전서",
    "데살로니가후서",
    "디모데전서",
    "디모데후서",
    "디도서",
    "빌레몬서",
    "히브리서",
    "야고보서",
    "베드로전서",
    "베드로후서",
    "요한일서",
    "요한이서",
    "요한삼서",
    "유다서",
    "요한계시록"
  ];

  // Verse results
  List<Map<String, dynamic>> results = [];

  @override
  Widget build(BuildContext context) {
    final books =
        selectedTestament == 'new' ? newTestamentBooks : oldTestamentBooks;
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
          text1: AppLocalizations.of(context)!.bible_search,
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
              CustomScrollView(
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
                                          Icons.search_rounded,
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
                                              AppLocalizations.of(context)!
                                                  .bible_search,
                                              style: theme.textTheme.titleLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Search through scripture verses',
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

                                  // Testament toggle with modern styling
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ChoiceChip(
                      label: Text(
                                                AppLocalizations.of(context)!
                                                    .bible_new_testament),
                                            selected:
                                                selectedTestament == 'new',
                      onSelected: (_) {
                        setState(() {
                          selectedTestament = 'new';
                                                selectedBook =
                                                    newTestamentBooks.first;
                          clearInputs();
                        });
                      },
                                          ),
                    ),
                    SizedBox(width: 8),
                                        Expanded(
                                          child: ChoiceChip(
                      label: Text(
                                                AppLocalizations.of(context)!
                                                    .bible_old_testament),
                                            selected:
                                                selectedTestament == 'old',
                      onSelected: (_) {
                        setState(() {
                          selectedTestament = 'old';
                                                selectedBook =
                                                    oldTestamentBooks.first;
                          clearInputs();
                        });
                      },
                                          ),
                    ),
                  ],
                                    ),
                ),
                SizedBox(height: 16),

                                  // Book dropdown with modern container
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface
                                          .withValues(alpha: 0.7),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: theme.colorScheme.outline
                                            .withValues(alpha: 0.1),
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                  value: selectedBook,
                                      hint: Text("Select Book",
                                          style: kBodyTextStyle(context)),
                  style: kBodyTextStyle(context),
                  isExpanded: true,
                                      underline: SizedBox.shrink(),
                  items: books
                                          .map((b) => DropdownMenuItem(
                                              value: b, child: Text(b)))
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedBook = val;
                    clearInputs();
                  }),
                ),
                                  ),
                SizedBox(height: 16),

                                  // Input fields with modern styling
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
                                    child: Column(
                                      children: [
                Row(children: [
                  Expanded(
                      child: _numberField(
                                                  AppLocalizations.of(context)!
                                                      .start_chapter,
                          startChapCtrl)),
                                          SizedBox(width: 12),
                  Expanded(
                      child: _numberField(
                                                  AppLocalizations.of(context)!
                                                      .start_verse,
                          startVerseCtrl)),
                ]),
                                        SizedBox(height: 16),
                Row(children: [
                  Expanded(
                      child: _numberField(
                                                  AppLocalizations.of(context)!
                                                      .end_chapter,
                          endChapCtrl)),
                                          SizedBox(width: 12),
                  Expanded(
                      child: _numberField(
                                                  AppLocalizations.of(context)!
                                                      .end_verse,
                          endVerseCtrl)),
                ]),
                                      ],
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
                                          onTap: isLoading ? null : fetchVerses,
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
                                                      : AppLocalizations.of(
                                                              context)!
                                                          .search,
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
                                                    'No results found',
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
                  }),
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
                            'Searching scripture...',
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
    final selectedVerseCount = selectedIndexes.length;

    for (var i in sortedIndexes) {
      final verse = results[i];
      buffer.writeln(
          '${verse['book']} ${verse['chapterVerse']} — ${verse['text']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString())).then((_) {
      log('✅ Copied $selectedVerseCount selected verses to clipboard');

      if (mounted) {
        showSimpleNotification(
          Text(
            '📋 Copied $selectedVerseCount selected verse${selectedVerseCount > 1 ? 's' : ''} to clipboard',
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

  Widget _numberField(String label, TextEditingController controller) {
    final theme = Theme.of(context);

    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: kBodyTextStyle(context),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          fontSize: 12,
          fontWeight: FontWeight.w500,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  void clearInputs() {
    startChapCtrl.clear();
    startVerseCtrl.clear();
    endChapCtrl.clear();
    endVerseCtrl.clear();
    results.clear();
  }

  Future<void> fetchVerses() async {
    FocusScope.of(context).unfocus(); // Hide the keyboard


    final book = selectedBook;
    final startChap = startChapCtrl.text;
    final startVerse = startVerseCtrl.text;
    final endChap = endChapCtrl.text;
    final endVerse = endVerseCtrl.text;

    if (book == null || startChap.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📘 책 이름과 시작 장을 입력해주세요.')),
      );
      return;
    }

    if (startVerse.isEmpty && (endChap.isNotEmpty || endVerse.isNotEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('시작 절이 없으면 범위 입력이 올바르지 않습니다.')),
      );
      return;
    }

    // Start loading
    setState(() {
      isLoading = true;
      results.clear();
      selectedIndexes.clear(); // Clear selections when starting new search
    });

    log('🔍 Searching bible: $book $startChap:$startVerse - $endChap:$endVerse');

    final query = {
      'book': book,
      'startChap': startChap,
      if (startVerse.isNotEmpty) 'startVerse': startVerse,
      if (endChap.isNotEmpty) 'endChap': endChap,
      if (endVerse.isNotEmpty) 'endVerse': endVerse,
    };

    final uri =
        Uri.https('www.bridgeway.online', '/_functions/bibleSearch', query);

    try {
      // Enforce a strict network timeout for the request
      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 30), onTimeout: () => throw TimeoutException('Request timeout'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          results = List<Map<String, dynamic>>.from(json['result']);
        });

        log('✅ Bible search completed: ${results.length} results found');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ Found ${results.length} verses'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        log("❌ Bible search failed: ${response.statusCode} - ${response.body}");
        if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('검색 중 오류가 발생했습니다.')),
        );
        }
      }
    } catch (e) {
      log("❌ Bible search exception: $e");

      if (!mounted) return;

      if (e is TimeoutException) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('요청이 시간 초과되었습니다. 잠시 후 다시 시도해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('네트워크 오류 또는 서버 문제입니다.'),
            backgroundColor: Colors.red,
          ),
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
