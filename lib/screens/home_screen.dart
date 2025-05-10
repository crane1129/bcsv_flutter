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
import 'package:bcsv_flutter_project/components/webview/webview_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/globals.dart' as globals;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:upgrader/upgrader.dart';
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
    //refresh the page here
    super.initState();
  }

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
                              onPress: () {
                                //AnnouncementPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AnnouncementPage();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.bullhorn,
                                  label: AppLocalizations.of(context)!
                                      .announcement)),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                //ServingTurnPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ServingTurnPage();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.peopleCarryBox,
                                  label: AppLocalizations.of(context)!
                                      .servingTurn)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                //New Message Page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            MessageListScreen())).then(
                                  (onValue) {
                                    updateMessageCounter();
                                  },
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconMsgContent(
                                cardIcon: FontAwesomeIcons.message,
                                label: AppLocalizations.of(context)!.newMessage,
                                msg_widget: displayMsgCounter(),
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                //BibleTextPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SundayBibleTextScreen();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.bookBible,
                                  label:
                                      AppLocalizations.of(context)!.bibleText)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                //DailyBibleTextPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DailyBibleTextScreen();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.calendarDays,
                                  label: AppLocalizations.of(context)!
                                      .dailyBible)),
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
                                //BibleTextPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return OfferingScreen();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.handHoldingHeart,
                                  label:
                                  AppLocalizations.of(context)!.offering)),
                        ),
                        Expanded(
                          child: ReusableCard2(
                              onPress: () {
                                //DailyBibleTextPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BibleSearchScreen();
                                    },
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.surface,
                              cardChild: IconContent(
                                  cardIcon: FontAwesomeIcons.magnifyingGlass,
                                  label: AppLocalizations.of(context)!
                                      .bible_search)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )));
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
