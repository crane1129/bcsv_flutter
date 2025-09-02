import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/services/keyverse_service.dart';
import 'package:bcsv_flutter_project/data_models/keyverse_model.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:developer';

class KeyVerseScreen extends StatefulWidget {
  const KeyVerseScreen({Key? key}) : super(key: key);

  @override
  _KeyVerseScreenState createState() => _KeyVerseScreenState();
}

class _KeyVerseScreenState extends State<KeyVerseScreen> {
  final KeyVerseService _keyVerseService = KeyVerseService();
  KeyVerse? _currentKeyVerse;
  bool _isLoading = false;
  int _selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _loadKeyVerse();
  }

  Future<void> _loadKeyVerse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final keyVerse = await _keyVerseService.getKeyVerse(year: _selectedYear);
      setState(() {
        _currentKeyVerse = keyVerse?.firstKeyVerse;
        _isLoading = false;
      });
      
      if (_currentKeyVerse != null) {
        final keyVerse = _currentKeyVerse!;
        log('✅ Keyverse loaded for year $_selectedYear: ${keyVerse.title}');
      } else {
        log('⚠️ No keyverse found for year $_selectedYear');
      }
    } catch (e) {
      log('❌ Error loading keyverse: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshKeyVerse() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final keyVerse = await _keyVerseService.refreshKeyVerse(_selectedYear);
      setState(() {
        _currentKeyVerse = keyVerse?.firstKeyVerse;
        _isLoading = false;
      });
      
      if (_currentKeyVerse != null) {
        log('✅ Keyverse refreshed for year $_selectedYear');
      }
    } catch (e) {
      log('❌ Error refreshing keyverse: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _changeYear(int delta) {
    final newYear = _selectedYear + delta;
    if (newYear >= 2020 && newYear <= 2030) { // Reasonable year range
      setState(() {
        _selectedYear = newYear;
      });
      _loadKeyVerse();
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
          text1: 'Key Verse',
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.refresh),
              color: theme.colorScheme.primary,
              onPressed: _isLoading ? null : _refreshKeyVerse,
              tooltip: 'Refresh Key Verse',
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Year selector
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                        theme.colorScheme.surface,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _changeYear(-1),
                        icon: Icon(Icons.chevron_left),
                        color: theme.colorScheme.primary,
                      ),
                      Text(
                        '$_selectedYear',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _changeYear(1),
                        icon: Icon(Icons.chevron_right),
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

                SizedBox(height: 20),

                // Key verse content
                if (_isLoading)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading key verse...',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_currentKeyVerse != null)
                  Builder(
                    builder: (context) {
                      final keyVerse = _currentKeyVerse!;
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.secondaryContainer.withValues(alpha: 0.1),
                                theme.colorScheme.surface,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Bible reference
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  keyVerse.chapterVerseRange,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.primary,
                                    fontFamily: kSystemWideFont,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              // Verse text
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    keyVerse.verse,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                      height: 1.6,
                                      fontSize: 18,
                                      fontFamily: kSystemWideFont
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(delay: 300.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
                      );
                    },
                  )
                else
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No key verse found for $_selectedYear',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try refreshing or selecting a different year',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 20),

                // Our Church's Vision and Path Forward
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.tertiaryContainer.withValues(alpha: 0.1),
                        theme.colorScheme.surface,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: theme.colorScheme.tertiary,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.vision_direction,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                                fontSize: 18,
                                fontFamily: kSystemWideFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.vision_direction_content,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          height: 1.6,
                          fontFamily: kSystemWideFont,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
