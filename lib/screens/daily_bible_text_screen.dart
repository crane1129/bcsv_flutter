import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

double _fontSize = 16.0;

class DailyBibleTextScreen extends StatefulWidget {
  const DailyBibleTextScreen({Key? key}) : super(key: key);

  @override
  _DailyBibleTextScreenState createState() => _DailyBibleTextScreenState();
}

class _DailyBibleTextScreenState extends State<DailyBibleTextScreen> {
  bool isLoading = false;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDailyBibleText(_selectedDate);
  }

  // Date navigation helpers
  void _goToPreviousDate() {
    final DateTime previous = _selectedDate.subtract(Duration(days: 1));
    setState(() {
      _selectedDate = previous;
      _headerData = null;
      _bodyText = '';
    });
    UserSharedPreferences.setDailyBibleText1Cache(false);
    UserSharedPreferences.setDailyBibleText2Cache(false);
    getDailyBibleText(previous);
  }

  void _goToNextDate() {
    final DateTime today = DateTime.now();
    _selectedDate = _selectedDate.add(Duration(days: 1));
    final DateTime nextDateOnly = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    final DateTime todayOnly = DateTime(today.year, today.month, today.day);
    if (nextDateOnly.isAfter(todayOnly)) return;
    setState(() {
      _headerData = null;
      _bodyText = '';
    });
    UserSharedPreferences.setDailyBibleText1Cache(false);
    UserSharedPreferences.setDailyBibleText2Cache(false);
    getDailyBibleText(nextDateOnly);
  }

  bool _isToday(DateTime date) {
    final DateTime today = DateTime.now();
    final DateTime dateOnly = DateTime(date.year, date.month, date.day);
    final DateTime todayOnly = DateTime(today.year, today.month, today.day);
    return dateOnly.isAtSameMomentAs(todayOnly);
  }

  Map<String, dynamic>? _headerData;
  String _bodyText = '';

  @override
  Widget build(BuildContext context) {
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
          text1: AppLocalizations.of(context)!.dailyBible,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.text_increase_rounded),
                  color: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.3),
                ),
                IconButton(
                  icon: Icon(Icons.text_decrease_rounded),
                  color: Theme.of(context).colorScheme.primary,
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
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? _buildLoadingState()
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: (_headerData == null && _bodyText.isEmpty)
                      ? _buildEmptyState()
                      : CustomScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date navigation section
                                    _buildDateNavigation(),

                                    // Bible content card
                                    if (_headerData != null ||
                                        _bodyText.isNotEmpty)
                                      _buildBibleContentCard(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }

  void getDailyBibleText(DateTime _targetDate) async {
    final stopwatch = Stopwatch()..start();
    print('🔄 [DEBUG] Starting getDailyBibleText() method');
    print('🔄 [DEBUG] Target Date: ${DateFormat('yyyy-MM-dd').format(_targetDate)}');

    try {
      //Show loading spinner
      setState(() {
        isLoading = true;
      });
      print('✅ [DEBUG] Loading state set to true');

      // Check API endpoints availability
      final endpoint1 = ApiEndpoint.apiMap['DAILY_BIBLE1'];
      final endpoint2 = ApiEndpoint.apiMap['DAILY_BIBLE2'];

      print('🔗 [DEBUG] API Endpoints check:');
      print('   - DAILY_BIBLE1: ${endpoint1 != null ? "✅ Available" : "❌ Missing"}');
      print('   - DAILY_BIBLE2: ${endpoint2 != null ? "✅ Available" : "❌ Missing"}');

      if (endpoint1 == null || endpoint2 == null) {
        print('⚠️ [DEBUG] API endpoints missing, attempting to bind...');
        final bindSuccess = await ApiEndpoint().bindEndpoints();
        print('🔧 [DEBUG] Endpoint binding result: ${bindSuccess ? "✅ Success" : "❌ Failed"}');
      }

      ModelParam modelParam = ModelParam(
        apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE1']!,
        tag: '',
        cacheFileName: kDailyBible1Data,
        getSharedReference: UserSharedPreferences.getDailyBibleText1Cache,
        setSharedReference: UserSharedPreferences.setDailyBibleText1Cache,
      );

      // Use selected date for requests
      String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(_targetDate);
      print('📅 [DEBUG] Request date: $formattedCurrentDate');

      Map data = {'qt_ty': 'QT1', 'Base_de': formattedCurrentDate};
      print('📤 [DEBUG] Request data: $data');

      // Check cache status before API call
      // final isCached1 = UserSharedPreferences.getDailyBibleText1Cache();
      // final isCached2 = UserSharedPreferences.getDailyBibleText2Cache();
      // final isCached1 = false;
      // final isCached2 = false;
      // print('💾 [DEBUG] Cache status:');
      // print('   - DAILY_BIBLE1 cache: ${isCached1 ? "✅ Available" : "❌ Empty"}');
      // print('   - DAILY_BIBLE2 cache: ${isCached2 ? "✅ Available" : "❌ Empty"}');

      print('🚀 [DEBUG] Fetching DAILY_BIBLE1 data...');
      final bible1Stopwatch = Stopwatch()..start();
      ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
          modelParam: modelParam, body: data, isBodyRequired: true);
      String dailyBibleText1 = await myGoogleDocContent.getContent();
      bible1Stopwatch.stop();

      print('📥 [DEBUG] DAILY_BIBLE1 response:');
      print('   - Length: ${dailyBibleText1.length} characters');
      print('   - Time: ${bible1Stopwatch.elapsedMilliseconds}ms');
      print('   - Preview: ${dailyBibleText1.length > 100 ? dailyBibleText1.substring(0, 100) + "..." : dailyBibleText1}');

      ModelParam modelParam2 = ModelParam(
        apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE2']!,
        tag: '',
        cacheFileName: kDailyBible2Data,
        getSharedReference: UserSharedPreferences.getDailyBibleText2Cache,
        setSharedReference: UserSharedPreferences.setDailyBibleText2Cache,
      );

      print('🚀 [DEBUG] Fetching DAILY_BIBLE2 data...');
      final bible2Stopwatch = Stopwatch()..start();
      ApiGoogleDocContent myGoogleDocContent2 = ApiGoogleDocContent(
          modelParam: modelParam2, body: data, isBodyRequired: true);
      String dailyBibleText2 = await myGoogleDocContent2.getContent();
      bible2Stopwatch.stop();

      print('📥 [DEBUG] DAILY_BIBLE2 response:');
      print('   - Length: ${dailyBibleText2.length} characters');
      print('   - Time: ${bible2Stopwatch.elapsedMilliseconds}ms');
      print('   - Preview: ${dailyBibleText2.length > 100 ? dailyBibleText2.substring(0, 100) + "..." : dailyBibleText2}');

      // Validate responses
      if (dailyBibleText1.isEmpty || dailyBibleText2.isEmpty) {
        print('❌ [DEBUG] Empty response detected!');
        print('   - Bible1 empty: ${dailyBibleText1.isEmpty}');
        print('   - Bible2 empty: ${dailyBibleText2.isEmpty}');
        throw Exception('Empty response from server');
      }

      print('🔄 [DEBUG] Parsing JSON responses...');
      var jsonObj1 = jsonDecode(dailyBibleText1);
      var jsonObj2 = jsonDecode(dailyBibleText2);

      print('✅ [DEBUG] JSON parsing successful:');
      print('   - Bible1 type: ${jsonObj1.runtimeType}');
      print('   - Bible2 type: ${jsonObj2.runtimeType}');
      if (jsonObj1 is Map) print('   - Bible1 keys: ${jsonObj1.keys.toList()}');
      if (jsonObj2 is List) print('   - Bible2 length: ${jsonObj2.length}');

      // Build header data
      final title = "${jsonObj1['Bible_name']}  ${jsonObj1['Bible_chapter']}";
      final subtitle = jsonObj1['Base_de'];
      _selectedDate = DateTime.parse(subtitle);

      print('📋 [DEBUG] Header data:');
      print('   - Title: $title');
      print('   - Subtitle: $subtitle');

      // Build body text
      String bodyText = '';
      int verseCount = 0;
      for (var word in jsonObj2) {
        bodyText += "${word['Verse'].toString()} ${word['Bible_Cn']}\n\n";
        verseCount++;
      }

      print('📖 [DEBUG] Body text built:');
      print('   - Verse count: $verseCount');
      print('   - Total length: ${bodyText.length} characters');
      print('   - First verse preview: ${bodyText.length > 100 ? bodyText.substring(0, 100) + "..." : bodyText}');

      setState(() {
        _headerData = {
          'title': title,
          'subtitle': subtitle,
        };
        _bodyText = bodyText;
        isLoading = false;
      });

      stopwatch.stop();
      print('🎉 [DEBUG] getDailyBibleText() completed successfully!');
      print('   - Total time: ${stopwatch.elapsedMilliseconds}ms');
      print('   - Bible1 fetch: ${bible1Stopwatch.elapsedMilliseconds}ms');
      print('   - Bible2 fetch: ${bible2Stopwatch.elapsedMilliseconds}ms');
      print('   - UI updated with ${verseCount} verses');

    } catch (e, stackTrace) {
      stopwatch.stop();
      print('💥 [DEBUG] Error in getDailyBibleText():');
      print('   - Error: $e');
      print('   - Time elapsed: ${stopwatch.elapsedMilliseconds}ms');
      print('   - Stack trace: $stackTrace');

      setState(() {
        isLoading = false;
      });

      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load daily Bible: ${e.toString()}'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                print('🔁 [DEBUG] User requested retry');
                getDailyBibleText(_targetDate);
              },
            ),
          ),
        );
      }
    }
  }

  /// Build modern loading state
  Widget _buildLoadingState() {
    final theme = Theme.of(context);
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
            AppLocalizations.of(context)?.dataLoading ??
                'Loading daily Bible...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state when no data is available
  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.bookBible,
            size: 80,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.dailyBible,
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

  /// Build date navigation section
  Widget _buildDateNavigation() {
    final theme = Theme.of(context);
    final bool isToday = _isToday(_selectedDate);

    return Container(
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
      child: Column(
        children: [
          // Date display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  FontAwesomeIcons.calendar,
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
                      DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      isToday ? 'Today\'s Reading' : 'Previous Reading',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _goToPreviousDate,
                  icon: Icon(Icons.chevron_left_rounded),
                  label: Text('Previous Day'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: isToday ? null : _goToNextDate,
                  icon: Icon(Icons.chevron_right_rounded),
                  label: Text('Next Day'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isToday 
                        ? theme.colorScheme.surfaceVariant
                        : theme.colorScheme.primaryContainer,
                    foregroundColor: isToday 
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onPrimaryContainer,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
  }

  /// Build modern Bible content card
  Widget _buildBibleContentCard() {
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
            // Header with bible reference
            if (_headerData != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
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
                        FontAwesomeIcons.calendar,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _headerData!['title'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                              fontSize: _fontSize + 2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _headerData!['subtitle'],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                              fontSize: _fontSize - 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2, end: 0),

            // Bible text content
            if (_bodyText.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: SelectableText(
                  _bodyText,
                  style: kBodyTextStyle(context, fontSize: _fontSize).copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 800.ms)
                  .slideY(begin: 0.2, end: 0),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    // Clear existing data
    setState(() {
      _headerData = null;
      _bodyText = '';
    });

    // Reload data
    UserSharedPreferences.setDailyBibleText1Cache(false);
    UserSharedPreferences.setDailyBibleText2Cache(false);
    getDailyBibleText(_selectedDate);
  }
}

class DailyBibleTile extends StatelessWidget {
  const DailyBibleTile(
      {Key? key,
      required this.content,
      required this.leadingText,
      required this.subTitle})
      : super(key: key);

  final Widget leadingText;
  final String content;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          content.isEmpty
              ? Text('N/A')
              : Text(content,
                  style: kBodyTextStyle(context, fontSize: _fontSize)),
        ],
      ),
    );
  }
}
