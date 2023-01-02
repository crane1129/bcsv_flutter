import 'dart:io';
import 'package:bcsv_flutter_project/screens/message_list.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/setting_screen.dart';
import 'package:bcsv_flutter_project/screens/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/offering_screen.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/review_screen.dart';
import 'package:bcsv_flutter_project/screens/about_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/screens/submit_opinion_screen.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateMessageCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDrawerBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(AppLocalizations.of(context)!.missionStatement),
            accountEmail: Text(AppLocalizations.of(context)!.missionVerse,
                style: TextStyle(fontSize: 10)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kActiveCardColor,
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
                style: kDrawerTitleMenuTextStyle),
          ),
          ListWebViewMenu(
              myIcon: Icons.voice_chat_outlined,
              menuName: AppLocalizations.of(context)!.archives,
              url: ApiEndpoint.apiMap['SERMON_YOUTUBE'],
              trailing: emptyString),
          ListWebViewMenu(
              myIcon: FontAwesomeIcons.youtube,
              menuName: AppLocalizations.of(context)!.youtubeLive,
              url: ApiEndpoint.apiMap['YOUTUBE_LIVE'],
              trailing: emptyString),
          const Divider(color: Colors.white30),
          ListTile(
            //leading: Icon(Icons.speaker_notes, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.notification,
                style: kDrawerTitleMenuTextStyle),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.accessibility_new_outlined,
                color: kActiveIconColor, size: 20),
            title: Text(AppLocalizations.of(context)!.servingTurn,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ServingTurnPage()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.notifications_none,
                color: kActiveIconColor, size: 20),
            title: Text(AppLocalizations.of(context)!.announcement,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnnouncementPage()));
            },
          ),
          // ListTile(
          //   //contentPadding: EdgeInsets.only(left: 30.0),
          //   leading:
          //       Icon(Icons.mail_outline, color: kActiveIconColor, size: 20),
          //   title: Text(AppLocalizations.of(context)!.newMessage,
          //       style: kDrawerMenuTextStyle),
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
          const Divider(color: Colors.white30),
          ListTile(
            //leading: Icon(FontAwesomeIcons.bible, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.bibleText,
                style: kDrawerTitleMenuTextStyle),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(Icons.book_outlined, color: kActiveIconColor, size: 20),
            title: Text(AppLocalizations.of(context)!.sermonBibleText,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SundayBibleTextScreen()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(Icons.create_sharp, color: kActiveIconColor, size: 20),
            title: Text(AppLocalizations.of(context)!.sermonReview,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SermonReviewScreen()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.article_outlined, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.dailyBible,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DailyBibleTextScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.volunteer_activism, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.offering,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OfferingScreen(url: ApiEndpoint.apiMap['OFFERING'])));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.add_shopping_cart_outlined,
          //     menuName: "Reimbursement",
          //     url: ApiEndpoint.apiMap['REIMBURSEMENT'],
          //     trailing: emptyString),
          ListTile(
            leading:
                Icon(Icons.add_shopping_cart_rounded, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.reimbursement,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReimbursementScreen(
                          url: ApiEndpoint.apiMap['REIMBURSEMENT'])));
            },
          ),
          ListTile(
            leading: Icon(Icons.share, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.opinion,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SubmitOpinionScreen()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.info_outline, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.about,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.settings,
                style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: kActiveIconColor),
            title: Text(AppLocalizations.of(context)!.exit,
                style: kDrawerMenuTextStyle),
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
  final String url;
  final Widget trailing;

  ListWebViewMenu(
      {required this.myIcon,
      required this.menuName,
      required this.url,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        //contentPadding: EdgeInsets.only(left: 20.0),
        leading: Icon(myIcon, color: kActiveIconColor, size: 20),
        title: Text(menuName, style: kDrawerMenuTextStyle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WebviewScreen(url: url, title1: menuName, title2: '');
              },
            ),
          );
        },
        trailing: trailing);
  }
}
