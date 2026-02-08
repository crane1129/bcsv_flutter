import 'package:bcsv_flutter_project/screens/bible_search_screen.dart';
import 'package:bcsv_flutter_project/screens/bible_keyword_search_screen.dart';
import 'package:bcsv_flutter_project/screens/message_list.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/nav_bar.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/app_card.dart';
import 'package:bcsv_flutter_project/components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upgrader/upgrader.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'package:bcsv_flutter_project/presentation/providers/keyverse_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'dart:developer';
import '../utilities/constants.dart';
import 'offering_screen.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Card visibility states
  bool showAnnouncementCard = true;
  bool showMessageCard = true;
  bool showServingTurnCard = true;
  bool showOfferingCard = true;
  bool showBibleTextCard = true;
  bool showDailyBibleCard = true;
  bool showBibleSearchCard = true;
  bool showKeywordSearchCard = true;

  @override
  void initState() {
    super.initState();
    log('🟢 [HomeScreen] initState called');
    _loadCardVisibilitySettings();

    // Initialize app services and load keyverse
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('🟢 [HomeScreen] Post-frame callback - initiating loadKeyVerse and app initialization');
      // Load current year's key verse using provider (cache first, then refresh in background)
      ref.read(keyVerseNotifierProvider.notifier).loadKeyVerse(forceRefresh: false);

      // Load messages to get unread count for badge display
      ref.read(messageNotifierProvider.notifier).loadMessages(forceRefresh: false);

      _initializeApp();
    });
  }

  void _loadCardVisibilitySettings() {
    setState(() {
      showAnnouncementCard = UserSharedPreferences.getShowAnnouncementCard();
      showMessageCard = UserSharedPreferences.getShowMessageCard();
      showServingTurnCard = UserSharedPreferences.getShowServingTurnCard();
      showOfferingCard = UserSharedPreferences.getShowOfferingCard();
      showBibleTextCard = UserSharedPreferences.getShowBibleTextCard();
      showDailyBibleCard = UserSharedPreferences.getShowDailyBibleCard();
      showBibleSearchCard = UserSharedPreferences.getShowBibleSearchCard();
      showKeywordSearchCard = UserSharedPreferences.getShowKeywordSearchCard();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh card visibility when returning from settings
    _loadCardVisibilitySettings();
  }

  Future<void> _initializeApp() async {
    try {
      log('🏠 Home screen checking app services...');

      // Check if background services are already initialized (from splash screen)
      if (BackgroundService().isInitialized) {
        log('✅ Background services already initialized');
        return;
      }

      // Only load settings if background service is not initialized
      // (This should rarely happen as splash screen initializes it)
      log('⚠️ Background service not initialized, loading settings as fallback');
      BackgroundService().loadSettings(context);

      // Use background service's network status instead of checking again
      if (!BackgroundService().hasInternetConnection) {
        log('❌ No network connection detected (from background service)');
        // Show disconnect screen after a brief delay to allow UI to settle
        Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            BackgroundService().showNoInternetAndNavigate(context);
          }
        });
        return;
      }

      // Start background initialization for heavy operations (fallback)
      BackgroundService().initializeInBackground();

      log('✅ Home screen app initialization completed');
    } catch (e) {
      log('❌ Error during home screen initialization: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final keyVerseState = ref.watch(keyVerseNotifierProvider);
    log('🔵 [HomeScreen] build called - keyVerse status: ${keyVerseState.status}, hasData: ${keyVerseState.keyVerse != null}');

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
                    padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ? 8 : 12),
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
                                theme.colorScheme.primaryContainer
                                    .withValues(alpha: 0.08),
                                theme.colorScheme.surface,
                                theme.colorScheme.secondaryContainer
                                    .withValues(alpha: 0.03),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.08),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.04),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  // Compact header row
                                  Row(
                                    children: [
                                      // Mission icon
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                        child: keyVerseState.keyVerse != null
                                            ? Text(
                                                keyVerseState.keyVerse!.title,
                                                style: theme.textTheme.titleMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colorScheme.onSurface,
                                                ),
                                              )
                                                  .animate()
                                                  .fadeIn(delay: 300.ms)
                                                  .slideX(begin: -0.3)
                                            : Text(
                                                'Loading...',
                                                style: theme.textTheme.titleMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                                ),
                                              ),
                                      ),

                                      // Compact verse badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme
                                              .colorScheme.secondaryContainer
                                              .withValues(alpha: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: keyVerseState.keyVerse != null
                                            ? Text(
                                                keyVerseState.keyVerse!.shortReference,
                                                style: theme.textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: theme.colorScheme.secondary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                                  .animate()
                                                  .fadeIn(delay: 500.ms)
                                                  .slideX(begin: 0.3)
                                            : Text(
                                                '...',
                                                style: theme.textTheme.labelSmall
                                                    ?.copyWith(
                                                  color: theme.colorScheme.secondary.withValues(alpha: 0.6),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  // Key verse content
                                  if (keyVerseState.isLoading)
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface
                                            .withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Loading key verse...',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurface
                                                  .withValues(alpha: 0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else if (keyVerseState.keyVerse != null)
                                    Builder(
                                      builder: (context) {
                                        final keyVerse = keyVerseState.keyVerse!;
                                        return Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.surface
                                                .withValues(alpha: 0.5),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Key verse text
                                              Text(
                                                keyVerse.verse,
                                                style: theme.textTheme.bodySmall?.copyWith(
                                                  color: theme.colorScheme.onSurface
                                                      .withValues(alpha: 0.8),
                                                  height: 1.5,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: kSystemWideFont,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ).animate().fadeIn(delay: 700.ms),
                                        );
                                      },
                                    )
                                  else
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.surface
                                            .withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .mission_statement_verse,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.8),
                                          height: 1.4,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ).animate().fadeIn(delay: 700.ms),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ).animate().fadeIn(duration: 400.ms).scale(
                            begin: Offset(0.98, 0.98), end: Offset(1.0, 1.0)),

                        // Enhanced grid layout with modern spacing (responsive for iPad)
                        Container(
                          child: Column(
                            children: [
                              // Row 1: Announcement & New Message
                              _buildRow([
                                if (showAnnouncementCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AnnouncementPage())),
                                    cardChild: IconContent(
                                      cardIcon: FontAwesomeIcons.bullhorn,
                                      label: AppLocalizations.of(context)!
                                          .announcement,
                                    ),
                                    animationDelay: 800.ms,
                                    slideDirection: -0.3,
                                  ),
                                if (showMessageCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MessageListScreen())),
                                    cardChild: Builder(
                                      builder: (context) {
                                        final unreadCount = ref.watch(unreadMessageCountProvider);
                                        if (unreadCount > 0) {
                                          return IconMsgContent(
                                            cardIcon: FontAwesomeIcons.newspaper,
                                            label: AppLocalizations.of(context)!.newMessage,
                                            msg_widget: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                '$unreadCount',
                                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            badgeDelay: 1000.ms,
                                          );
                                        }
                                        return IconContent(
                                          cardIcon: FontAwesomeIcons.newspaper,
                                          label: AppLocalizations.of(context)!.newMessage,
                                        );
                                      },
                                    ),
                                    animationDelay: 900.ms,
                                    slideDirection: 0.3,
                                  ),
                              ]),

                              // Row 2: Serving Turn & Offering
                              _buildRow([
                                if (showServingTurnCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServingTurnPage())),
                                    cardChild: IconContent(
                                      cardIcon: FontAwesomeIcons.peopleCarryBox,
                                      label: AppLocalizations.of(context)!
                                          .servingTurn,
                                    ),
                                    animationDelay: 1000.ms,
                                    slideDirection: -0.3,
                                  ),
                                if (showOfferingCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OfferingScreen())),
                                    cardChild: IconContent(
                                      cardIcon:
                                          FontAwesomeIcons.handHoldingHeart,
                                      label: AppLocalizations.of(context)!
                                          .offering,
                                    ),
                                    animationDelay: 1100.ms,
                                    slideDirection: 0.3,
                                  ),
                              ]),

                              // Row 3: Bible Text & Daily Bible
                              _buildRow([
                                if (showBibleTextCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SundayBibleTextScreen())),
                                    cardChild: IconContent(
                                      cardIcon: FontAwesomeIcons.scroll,
                                      label: AppLocalizations.of(context)!
                                          .sermonBibleText,
                                    ),
                                    animationDelay: 1200.ms,
                                    slideDirection: -0.3,
                                  ),
                                if (showDailyBibleCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DailyBibleTextScreen())),
                                    cardChild: IconContent(
                                      cardIcon: FontAwesomeIcons.calendarDays,
                                      label: AppLocalizations.of(context)!
                                          .dailyBible,
                                    ),
                                    animationDelay: 1300.ms,
                                    slideDirection: 0.3,
                                  ),
                              ]),

                              // Row 4: Bible Search & Keyword Search
                              _buildRow([
                                if (showBibleSearchCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BibleSearchScreen())),
                                    cardChild: IconContent(
                                      cardIcon:
                                          FontAwesomeIcons.bookBible,
                                      label: AppLocalizations.of(context)!
                                          .bible_search,
                                    ),
                                    animationDelay: 1400.ms,
                                    slideDirection: -0.3,
                                  ),
                                if (showKeywordSearchCard)
                                  _buildCard(
                                    onPress: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BibleKeywordSearchScreen())),
                                    cardChild: IconContent(
                                      cardIcon: FontAwesomeIcons.magnifyingGlass,
                                      label: AppLocalizations.of(context)!
                                          .keywordSearch,
                                    ),
                                    animationDelay: 1500.ms,
                                    slideDirection: 0.3,
                                  ),
                              ]),

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

  /// Helper method to build a row with dynamic card visibility
  Widget _buildRow(List<Widget> cards) {
    if (cards.isEmpty) return SizedBox.shrink();

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final bool isTablet = width >= 768; // iPad breakpoint
    final bool isPortrait = height > width;

    if (!isTablet) {
      if (cards.length == 1) {
        return Container(margin: EdgeInsets.only(bottom: 12), child: cards.first);
      }
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(children: cards.map((card) => Expanded(child: card)).toList()),
      );
    }

    // Tablet layout: optimize for portrait vs landscape
    final int cardsPerRow = isPortrait ? 2 : 3; // 2 cards per row in portrait, 3 in landscape
    final double bottomMargin = isPortrait ? 8.0 : 12.0; // Reduce spacing in portrait
    
    final List<Widget> chunks = [];
    for (int i = 0; i < cards.length; i += cardsPerRow) {
      final slice = cards.sublist(i, (i + cardsPerRow).clamp(0, cards.length));
      chunks.add(Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: Row(
          children: slice.map((card) => Expanded(child: card)).toList(),
        ),
      ));
    }
    return Column(children: chunks);
  }

  /// Helper method to build individual cards
  Widget _buildCard({
    required VoidCallback onPress,
    required Widget cardChild,
    required Duration animationDelay,
    required double slideDirection,
  }) {
    final theme = Theme.of(context);

    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppCard(
        onTap: onPress,
        color: theme.colorScheme.surface,
        variant: AppCardVariant.elevated,
        child: cardChild,
      ),
    ).animate().fadeIn(delay: animationDelay).slideX(begin: slideDirection);
  }
}
