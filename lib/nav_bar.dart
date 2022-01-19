import 'dart:io';
import 'package:bcsv_flutter_project/screens/message_list.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
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
          const UserAccountsDrawerHeader(
            accountName: Text('Bridgeway Baptist Church'),
            accountEmail: Text('bcsv.org'),
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
            title:
                LocaleText('Sunday Sermons', style: kDrawerTitleMenuTextStyle),
          ),
          ListWebViewMenu(
              myIcon: Icons.voice_chat_outlined,
              menuName: "Archives",
              url: ApiEndpoint.apiMap['SERMON_YOUTUBE'],
              trailing: emptyString),
          ListWebViewMenu(
              myIcon: FontAwesomeIcons.youtube,
              menuName: "Youtube Live",
              url: ApiEndpoint.apiMap['YOUTUBE_LIVE'],
              trailing: emptyString),
          const Divider(color: Colors.white30),
          ListTile(
            //leading: Icon(Icons.speaker_notes, color: kInactiveIconColor),
            title: LocaleText('Notification', style: kDrawerTitleMenuTextStyle),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.accessibility_new_outlined,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Serving Turn', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ServingTurnPage()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.notifications_none,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Announcement', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnnouncementPage()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(Icons.mail_outline, color: kActiveIconColor, size: 20),
            title: LocaleText('New Message', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MessageListScreen())).then(
                (onValue) {
                  updateMessageCounter();
                },
              );
            },
            trailing: displayMsgCounter(),
          ),
          const Divider(color: Colors.white30),
          ListTile(
            //leading: Icon(FontAwesomeIcons.bible, color: kInactiveIconColor),
            title: LocaleText('Bible Text', style: kDrawerTitleMenuTextStyle),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(Icons.book_outlined, color: kActiveIconColor, size: 20),
            title: LocaleText('Sermon Bible Text', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SundayBibleTextScreen()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(Icons.create_sharp, color: kActiveIconColor, size: 20),
            title: LocaleText('Sermon Review', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SermonReviewScreen()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.article_outlined, color: kActiveIconColor),
            title: LocaleText('Daily Bible', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DailyBibleTextScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.volunteer_activism, color: kActiveIconColor),
            title: LocaleText('Offering', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OfferingScreen(url: kOfferingUrl)));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.add_shopping_cart_outlined,
          //     menuName: "Reimbursement",
          //     url: ApiEndpoint.apiMap['REIMBURSEMENT'],
          //     trailing: emptyString),
          ListTile(
            leading: Icon(Icons.add_shopping_cart_rounded, color: kActiveIconColor),
            title: LocaleText('Reimbursement', style: kDrawerMenuTextStyle),
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
            title: LocaleText('Opinion', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SubmitOpinionScreen()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.info_outline, color: kActiveIconColor),
            title: LocaleText('About', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: kActiveIconColor),
            title: LocaleText('Settings', style: kDrawerMenuTextStyle),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()));
            },
          ),
          const Divider(color: Colors.white30),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: kActiveIconColor),
            title: LocaleText('Exit', style: kDrawerMenuTextStyle),
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
      messageCounter = UserSharedPreferences.getMessageListCounter() ?? 0;
    });
  }

  Widget displayMsgCounter() {
    if (messageCounter == 0) {
      return emptyString;
    } else {
      return ClipOval(
        child: Container(
          color: Colors.red,
          width: 20,
          height: 20,
          child: Center(
            child: Text(messageCounter.toString(),
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
        title: LocaleText(menuName, style: kDrawerMenuTextStyle),
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
