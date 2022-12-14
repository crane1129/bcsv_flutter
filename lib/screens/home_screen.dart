import 'package:bcsv_flutter_project/screens/message_list.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/nav_bar.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/components/reusable_card.dart';
import 'package:bcsv_flutter_project/components/icon_content.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/globals.dart' as globals;


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget emptyString = Text('');
  late int messageCounter;

  @override
  void initState() {
    //refresh the page here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.transparent.withOpacity(0.5),
          title: AppBarHeaderText(
              text1: AppLocalizations.of(context)!.bridgeway,
              text2: AppLocalizations.of(context)!.baptistChurch),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
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
                                  return WebviewScreen(
                                      url: ApiEndpoint
                                              .apiMap['SERMON_YOUTUBE'] ??
                                          kBaseUrl,
                                      title1: AppLocalizations.of(context)!
                                          .archives,
                                      title2: '');
                                },
                              ),
                            );
                          },
                          color: kActiveCardColor,
                          cardChild: IconContent(
                              cardIcon: FontAwesomeIcons.solidFileVideo,
                              label: AppLocalizations.of(context)!.archives)),
                    ),
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
                          color: kActiveCardColor,
                          cardChild: IconContent(
                              cardIcon: FontAwesomeIcons.bullhorn,
                              label:
                                  AppLocalizations.of(context)!.announcement)),
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
                          color: kActiveCardColor,
                          cardChild: IconContent(
                              cardIcon: FontAwesomeIcons.peopleCarry,
                              label:
                                  AppLocalizations.of(context)!.servingTurn)),
                    ),
                    Expanded(
                      child: ReusableCard3(
                          onPress: () {
                            //New Message Page
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MessageListScreen())).then(
                                  (onValue) {
                                updateMessageCounter();
                              },
                            );
                          },
                          color: kActiveCardColor,
                          cardChild: IconMsgContent(
                            cardIcon: FontAwesomeIcons.facebookMessenger,
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
                          color: kActiveCardColor,
                          cardChild: IconContent(
                              cardIcon: FontAwesomeIcons.bible,
                              label: AppLocalizations.of(context)!.bibleText)),
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
                          color: kActiveCardColor,
                          cardChild: IconContent(
                              cardIcon: FontAwesomeIcons.cross,
                              label: AppLocalizations.of(context)!.dailyBible)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
