import 'dart:io';
import 'dart:async';
import 'package:bcsv_flutter_project/screens/bible_search_screen.dart';
import 'package:bcsv_flutter_project/screens/bible_keyword_search_screen.dart';
import 'package:bcsv_flutter_project/screens/submit_opinion_screen.dart';
import 'package:bcsv_flutter_project/screens/unconfirmed_opinion_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/setting_screen.dart';
import 'package:bcsv_flutter_project/components/webview/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/offering_screen.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/about_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'package:bcsv_flutter_project/screens/reimbursement_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/globals.dart' as globals;

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Widget emptyString = Text('');
  late int messageCounter;
  Timer? _endpointCheckTimer;
  bool _endpointsInitialized = false;

  @override
  void initState() {
    super.initState();
    updateMessageCounter();
    _checkEndpointInitialization();
  }

  @override
  void dispose() {
    _endpointCheckTimer?.cancel();
    super.dispose();
  }

  void _checkEndpointInitialization() {
    // Check if endpoints are already initialized
    if (ApiEndpoint().isInitialized) {
      _onEndpointsReady();
      return;
    }

    // Set up a timer to periodically check for endpoint initialization
    _endpointCheckTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (ApiEndpoint().isInitialized && !_endpointsInitialized) {
        _onEndpointsReady();
        timer.cancel();
      }
    });

    // Also listen for background service completion
    BackgroundService().onInitializationComplete(() {
      if (!_endpointsInitialized && mounted) {
        _onEndpointsReady();
      }
    });
  }

  void _onEndpointsReady() {
    if (mounted && !_endpointsInitialized) {
      setState(() {
        _endpointsInitialized = true;
      });
      _endpointCheckTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Theme.of(context).colorScheme.onSurface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(AppLocalizations.of(context)!.missionStatement),
            accountEmail: Text(AppLocalizations.of(context)!.missionVerse,
                style: TextStyle(fontSize: 10)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              backgroundImage: AssetImage('assets/images/app.png'),
            ),
            decoration: BoxDecoration(
                color: kMainAppBarColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/mountain1.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            //leading: Icon(FontAwesomeIcons.church, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.sundaySermons,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListWebViewMenu(
              myIcon: Icons.voice_chat_outlined,
              menuName: AppLocalizations.of(context)!.sermonArchives,
              url: ApiEndpoint.apiMap['SERMON_YOUTUBE'],
              trailing: emptyString),
          ListWebViewMenu(
              myIcon: FontAwesomeIcons.youtube,
              menuName: AppLocalizations.of(context)!.youtubeLive,
              url: ApiEndpoint.apiMap['YOUTUBE_LIVE'],
              trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            //leading: Icon(Icons.speaker_notes, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.notification,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.accessibility_new_outlined,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.servingTurn,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ServingTurnPage()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.notifications_none,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.announcement,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnnouncementPage()));
            },
          ),
          // ListTile(
          //   //contentPadding: EdgeInsets.only(left: 30.0),
          //   leading:
          //       Icon(Icons.mail_outline, color: kActiveIconColor(context), size: 20),
          //   title: Text(AppLocalizations.of(context)!.newMessage,
          //       style: kDrawerMenuTextStyle(context)),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (_) => MessageListScreen())).then(
          //       (onValue) {
          //         updateMessageCounter();
          //       },
          //     );
          //   },
          //   trailing: displayMsgCounter(),
          // ),
          const Divider(color: Colors.grey),
          ListTile(
            //leading: Icon(FontAwesomeIcons.bible, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.bibleText,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.book_outlined,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.sermonBibleText,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SundayBibleTextScreen()));
            },
          ),
          // ListTile(
          //   //contentPadding: EdgeInsets.only(left: 30.0),
          //   leading:
          //       Icon(Icons.create_sharp, color: kActiveIconColor(context), size: 20),
          //   title: Text(AppLocalizations.of(context)!.sermonReview,
          //       style: kDrawerMenuTextStyle(context)),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (_) => SermonReviewScreen()));
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.auto_stories, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.dailyBible,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DailyBibleTextScreen()));
            },
          ),
          ListWebViewMenu(
              myIcon: FontAwesomeIcons.calendarDays,
              menuName: AppLocalizations.of(context)!.bible_reading_plan,
              url: ApiEndpoint.apiMap['DAILY_BIBLE_READING_PLAN'],
              trailing: emptyString),
          ListTile(
            leading: Icon(Icons.search, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.bible_search,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BibleSearchScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_search, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.keywordSearch,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BibleKeywordSearchScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: FontAwesomeIcons.magnifyingGlass,
          //     menuName: AppLocalizations.of(context)!.bible_search,
          //     url: ApiEndpoint.apiMap['BIBLE_SEARCH'],
          //     trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.volunteer_activism,
                color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.offering,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          OfferingScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.add_shopping_cart_outlined,
          //     menuName: "Reimbursement",
          //     url: ApiEndpoint.apiMap['REIMBURSEMENT'],
          //     trailing: emptyString),
          ListTile(
            leading: Icon(Icons.add_shopping_cart_rounded,
                color: ApiEndpoint.apiMap['REIMBURSEMENT'] != null 
                    ? kActiveIconColor(context) 
                    : Colors.grey),
            title: Text(AppLocalizations.of(context)!.reimbursement,
                style: ApiEndpoint.apiMap['REIMBURSEMENT'] != null
                    ? kDrawerMenuTextStyle(context)
                    : kDrawerMenuTextStyle(context).copyWith(color: Colors.grey)),
            onTap: ApiEndpoint.apiMap['REIMBURSEMENT'] != null ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReimbursementScreen(
                          url: ApiEndpoint.apiMap['REIMBURSEMENT']!)));
            } : null,
          ),
          ListTile(
            leading: Icon(Icons.emoji_people, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.opinion,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SubmitOpinionScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.share,
          //     menuName: AppLocalizations.of(context)!.opinion,
          //     url: ApiEndpoint.apiMap['FEEDBACK'],
          //     trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.info_outline, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.about,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.settings,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
          FutureBuilder<bool>(
            future: UserSharedPreferences.isStaffModeEnabled(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || !snapshot.data!) {
                return SizedBox(); // or return alternative UI
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  ListTile(
                    //leading: Icon(Icons.admin_panel_settings),
                    title: Text(AppLocalizations.of(context)!.staff_only_mode,
                        style: kDrawerMenuTextStyle(context)),
                  ),
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings,
                        color: kActiveIconColorAdmin(context)),
                    title: Text(
                        AppLocalizations.of(context)!.unconfirmed_opinion,
                        style: kDrawerMenuTextStyle(context)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => UnconfirmedOpinionsScreen()));
                    },
                  ),
                ],
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.exit,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  void updateMessageCounter() {
    setState(() {
      globals.messageCnt = UserSharedPreferences.getMessageListCounter() ?? 0;
    });
  }

  Widget displayMsgCounter() {
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
}

class ListWebViewMenu extends StatelessWidget {
  final IconData myIcon;
  final String menuName;
  final Uri? url;
  final Widget trailing;

  ListWebViewMenu(
      {required this.myIcon,
      required this.menuName,
      required this.url,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    final bool isUrlAvailable = url != null;
    
    return ListTile(
        //contentPadding: EdgeInsets.only(left: 20.0),
        leading: Icon(myIcon, 
            color: isUrlAvailable ? kActiveIconColor(context) : Colors.grey, 
            size: 20),
        title: Text(menuName, 
            style: isUrlAvailable 
                ? kDrawerMenuTextStyle(context)
                : kDrawerMenuTextStyle(context).copyWith(color: Colors.grey)),
        onTap: isUrlAvailable ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // return WebviewScreen(url: url, title1: menuName, title2: '');
                return WebViewApp(url: url!, title1: menuName, title2: '');
              },
            ),
          );
        } : null,
        trailing: trailing);
  }
}
