import 'dart:io';

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

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDrawerBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('bcsv.org'),
            accountEmail: Text('version 2.0'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/app.png'),
            ),
            decoration: BoxDecoration(
                color: kMainAppBarColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/mountain1.jpeg'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.church, color: kInactiveIconColor),
            title: LocaleText('Sunday Sermons',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(FontAwesomeIcons.solidFileVideo,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Archives'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WebviewScreen(
                        url: ApiEndpoint.apiMap['SERMON_YOUTUBE'] ?? kBaseUrl,
                        title1: '',
                        title2: '');
                  },
                ),
              );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(FontAwesomeIcons.youtube,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Youtube Live'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WebviewScreen(
                    url: ApiEndpoint.apiMap['YOUTUBE_LIVE'] ?? kBaseUrl,
                    title1: '',
                    title2: '');
              }));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.speaker_notes, color: kInactiveIconColor),
            title: LocaleText('News',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(FontAwesomeIcons.peopleCarry,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Serving Turn'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ServingTurnPage()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(FontAwesomeIcons.bullhorn,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Announcement'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnnouncementPage()));
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.bible, color: kInactiveIconColor),
            title: LocaleText('Bible Text',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(FontAwesomeIcons.bookOpen,
                color: kActiveIconColor, size: 20),
            title: LocaleText('Sermon Bible Text'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SundayBibleTextScreen()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            leading:
                Icon(FontAwesomeIcons.pen, color: kActiveIconColor, size: 20),
            title: LocaleText('Sermon Review'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SermonReviewScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading:
                Icon(FontAwesomeIcons.calendarDay, color: kActiveIconColor),
            title: LocaleText('Daily Bible'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DailyBibleTextScreen()));
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.handHoldingHeart,
                color: kActiveIconColor),
            title: LocaleText('Offering'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OfferingScreen(url: kOfferingUrl)));
            },
          ),
          ListTile(
            leading: Icon(Icons.event_available, color: kActiveIconColor),
            title: LocaleText('Upcoming Event'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WebviewScreen(
                          url: ApiEndpoint.apiMap['EVENT'] ?? kBaseUrl,
                          title1: '',
                          title2: '')));
            },
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text('20',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.info, color: kActiveIconColor),
            title: LocaleText('About'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.donate, color: kActiveIconColor),
            title: LocaleText('Reimbursement'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WebviewScreen(
                          url: ApiEndpoint.apiMap['REIMBURSEMENT'] ?? kBaseUrl,
                          title1: '',
                          title2: '')));
            },
          ),
          ListTile(
              leading: Icon(Icons.settings, color: kActiveIconColor),
              title: LocaleText('Settings'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage()));
              }),
          const Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: LocaleText('Exit'),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
