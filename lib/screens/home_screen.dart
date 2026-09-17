import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/nav_bar.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/components/reusable_card.dart';
import 'package:bcsv_flutter_project/components/icon_content.dart';
import 'package:bcsv_flutter_project/components/webview/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/submit_opinion_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upgrader/upgrader.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
        dialogStyle: UpgradeDialogStyle.cupertino,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: NavBar(),
            appBar: AppBar(
              backgroundColor: Colors.transparent.withValues(alpha: 0.5),
              leading: IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white70,
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: AppBarHeaderText(
                      text1: AppLocalizations.of(context)!.bridgeway,
                      text2: AppLocalizations.of(context)!.baptistChurch)
                  .animate()
                  .fade()
                  .scale(duration: 500.ms),
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard2(
                              onPress: () => _openWebView(
                                  context,
                                  kHomepageChurchUrl,
                                  AppLocalizations.of(context)!.church),
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.church,
                                  label: AppLocalizations.of(context)!
                                      .church)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () => _openWebView(
                                  context,
                                  kHomepageMinistriesUrl,
                                  AppLocalizations.of(context)!.ministries),
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.groups,
                                  label: AppLocalizations.of(context)!
                                      .ministries)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard2(
                              onPress: () => _openWebView(
                                  context,
                                  kHomepageSermonsUrl,
                                  AppLocalizations.of(context)!.sermons),
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.voice_chat_outlined,
                                  label:
                                      AppLocalizations.of(context)!.sermons)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () => _openWebView(
                                  context,
                                  kBridgewayHubUrl,
                                  AppLocalizations.of(context)!.links),
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.link,
                                  label: AppLocalizations.of(context)!.links)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SubmitOpinionScreen();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.emoji_people,
                                  label:
                                      AppLocalizations.of(context)!.opinion)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () => _openWebView(
                                  context,
                                  kHomepageHomeUrl,
                                  AppLocalizations.of(context)!.home),
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: Icons.home_outlined,
                                  label: AppLocalizations.of(context)!.home)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )));
  }

  void _openWebView(BuildContext context, Uri url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewApp(url: url, title1: title, title2: ''),
      ),
    );
  }
}
