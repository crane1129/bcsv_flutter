import 'package:bcsv_flutter_project/screens/bible_search_screen.dart';
import 'package:bcsv_flutter_project/screens/message_list.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/nav_bar.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/components/reusable_card.dart';
import 'package:bcsv_flutter_project/components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/globals.dart' as globals;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upgrader/upgrader.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:developer';
import 'offering_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget emptyString = Text('');
  late int messageCounter;

  @override
  void initState() {
    super.initState();

    // Initialize app services immediately when home screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      log('🏠 Home screen initializing app services...');

      // Load user settings immediately (lightweight operation)
      BackgroundService().loadSettings(context);

      // Check network connectivity before starting background services
      final hasConnection =
          await InternetConnectionChecker.instance.hasConnection;

      if (!hasConnection) {
        log('❌ No network connection detected on home screen');
        // Show disconnect screen after a brief delay to allow UI to settle
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            BackgroundService().showNoInternetAndNavigate(context);
          }
        });
        return;
      }

      // Start background initialization for heavy operations
      BackgroundService().initializeInBackground();

      log('✅ Home screen app initialization completed');
    } catch (e) {
      log('❌ Error during home screen initialization: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return UpgradeAlert(
      dialogStyle: UpgradeDialogStyle.cupertino,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavBar(),
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
              icon: Icon(Icons.menu),
              color: Colors.white70,
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ).animate().fadeIn(delay: 200.ms).scale(begin: Offset(0.8, 0.8)),
          title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.bridgeway,
            text2: AppLocalizations.of(context)!.baptistChurch,
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
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Compact mission statement section
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primaryContainer.withValues(alpha: 0.08),
                                theme.colorScheme.surface,
                                theme.colorScheme.secondaryContainer.withValues(alpha: 0.03),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outline.withValues(alpha: 0.08),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.04),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  // Compact header row
                                  Row(
                                    children: [
                                      // Mission icon
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.favorite_rounded,
                                          size: 16,
                                          color: theme.colorScheme.primary,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      
                                      // Mission statement
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!.missionStatement,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                        ).animate()
                                          .fadeIn(delay: 300.ms)
                                          .slideX(begin: -0.3),
                                      ),
                                      
                                      // Compact verse badge
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.missionVerse,
                                          style: theme.textTheme.labelSmall?.copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ).animate()
                                          .fadeIn(delay: 500.ms)
                                          .slideX(begin: 0.3),
                                      ),
                                    ],
                                  ),
                                  
                                  SizedBox(height: 8),
                                  
                                  // Full verse content
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.mission_statement_verse,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                                        height: 1.4,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      textAlign: TextAlign.center,
                                    ).animate()
                                      .fadeIn(delay: 700.ms),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).animate()
                          .fadeIn(duration: 400.ms)
                          .scale(begin: Offset(0.98, 0.98), end: Offset(1.0, 1.0)),

                        // Enhanced grid layout with modern spacing
                        Container(
                          constraints: BoxConstraints(
                            maxWidth:
                                screenSize.width > 600 ? 600 : double.infinity,
                          ),
                          child: Column(
                            children: [
                              // Row 1: Announcement (full width)
                              Container(
                                height: 110,
                                margin: EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ReusableCard2(
                                  onPress: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnnouncementPage(),
                                      ),
                                    );
                                  },
                                  color: theme.colorScheme.surface,
                                  cardChild: IconContent(
                                    cardIcon: FontAwesomeIcons.bullhorn,
                                    label: AppLocalizations.of(context)!
                                        .announcement,
                                  ),
                                ),
                              )
                                  .animate()
                                  .fadeIn(delay: 600.ms)
                                  .slideY(begin: 0.3),

                              // Row 2: Serving Turn & New Message
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(right: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ServingTurnPage(),
                                            ),
                                          );
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconContent(
                                          cardIcon:
                                              FontAwesomeIcons.peopleCarryBox,
                                          label: AppLocalizations.of(context)!
                                              .servingTurn,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 700.ms)
                                      .slideX(begin: -0.3),
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(left: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  MessageListScreen(),
                                            ),
                                          ).then((onValue) {
                                            updateMessageCounter();
                                          });
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconMsgContent(
                                          cardIcon: FontAwesomeIcons.message,
                                          label: AppLocalizations.of(context)!
                                              .newMessage,
                                          msg_widget: displayMsgCounter(),
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 800.ms)
                                      .slideX(begin: 0.3),
                                ],
                              ),

                              // Row 3: Bible Text & Daily Bible
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(right: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SundayBibleTextScreen(),
                                            ),
                                          );
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconContent(
                                          cardIcon: FontAwesomeIcons.bookBible,
                                          label: AppLocalizations.of(context)!
                                              .bibleText,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 900.ms)
                                      .slideX(begin: -0.3),
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(left: 8, bottom: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DailyBibleTextScreen(),
                                            ),
                                          );
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconContent(
                                          cardIcon:
                                              FontAwesomeIcons.calendarDays,
                                          label: AppLocalizations.of(context)!
                                              .dailyBible,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 1000.ms)
                                      .slideX(begin: 0.3),
                                ],
                              ),

                              // Row 4: Offering & Bible Search
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(right: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OfferingScreen(),
                                            ),
                                          );
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconContent(
                                          cardIcon:
                                              FontAwesomeIcons.handHoldingHeart,
                                          label: AppLocalizations.of(context)!
                                              .offering,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 1100.ms)
                                      .slideX(begin: -0.3),
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      margin:
                                          EdgeInsets.only(left: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ReusableCard2(
                                        onPress: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BibleSearchScreen(),
                                            ),
                                          );
                                        },
                                        color: theme.colorScheme.surface,
                                        cardChild: IconContent(
                                          cardIcon:
                                              FontAwesomeIcons.magnifyingGlass,
                                          label: AppLocalizations.of(context)!
                                              .bible_search,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate()
                                      .fadeIn(delay: 1200.ms)
                                      .slideX(begin: 0.3),
                                ],
                              ),

                              // Bottom spacing for modern feel
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
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

  Widget displayMsgCounter() {
    updateMessageCounter();

    if (globals.messageCnt == 0) {
      return emptyString;
    } else {
      return ClipOval(
        child: Container(
          color: Colors.red,
          width: 20,
          height: 20,
          child: Center(
            child: Text(globals.messageCnt.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ),
      );
    }
  }

  void updateMessageCounter() {
    setState(() {
      globals.messageCnt = UserSharedPreferences.getMessageListCounter() ?? 0;
    });
  }
}
