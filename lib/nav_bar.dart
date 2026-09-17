import 'dart:io';
import 'package:bcsv_flutter_project/screens/submit_opinion_screen.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/screens/setting_screen.dart';
import 'package:bcsv_flutter_project/components/webview/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/offering_screen.dart';
import 'package:bcsv_flutter_project/screens/about_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          // The following menu items all mirror the live pages on the
          // bridgeway.online homepage (Next.js), rather than the old Wix
          // backend, which no longer exists.
          ListWebViewMenu(
              myIcon: Icons.home_outlined,
              menuName: AppLocalizations.of(context)!.home,
              url: kHomepageHomeUrl,
              trailing: SizedBox.shrink()),
          ListWebViewMenu(
              myIcon: Icons.church,
              menuName: AppLocalizations.of(context)!.church,
              url: kHomepageChurchUrl,
              trailing: SizedBox.shrink()),
          ListWebViewMenu(
              myIcon: Icons.groups,
              menuName: AppLocalizations.of(context)!.ministries,
              url: kHomepageMinistriesUrl,
              trailing: SizedBox.shrink()),
          ListWebViewMenu(
              myIcon: Icons.voice_chat_outlined,
              menuName: AppLocalizations.of(context)!.sermons,
              url: kHomepageSermonsUrl,
              trailing: SizedBox.shrink()),
          ListWebViewMenu(
              myIcon: Icons.link,
              menuName: AppLocalizations.of(context)!.links,
              url: kBridgewayHubUrl,
              trailing: SizedBox.shrink()),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.volunteer_activism,
                color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.offering,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => OfferingScreen()));
            },
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
}

class ListWebViewMenu extends StatelessWidget {
  final IconData myIcon;
  final String menuName;
  final Uri url;
  final Widget trailing;

  ListWebViewMenu(
      {required this.myIcon,
      required this.menuName,
      required this.url,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(myIcon, color: kActiveIconColor(context), size: 20),
        title: Text(menuName, style: kDrawerMenuTextStyle(context)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WebViewApp(url: url, title1: menuName, title2: '');
              },
            ),
          );
        },
        trailing: trailing);
  }
}
