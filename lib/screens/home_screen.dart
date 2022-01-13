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


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: kMainAppBarColor,
          title: AppBarHeaderText(text1: 'Bridgeway', text2: 'Baptist Church'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 100),
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
                                return WebviewScreen(url: ApiEndpoint.apiMap['SERMON_YOUTUBE'] ?? kBaseUrl,
                                    title1: '', title2: '');
                              },
                            ),
                          );
                        },
                        color: kActiveCardColor,
                        cardChild: IconContent(
                            cardIcon: FontAwesomeIcons.solidFileVideo,
                            label: 'Archives')),
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
                            label: 'Announcement')),
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
                            label: 'Serving Turn')),
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
                                return SundayBibleTextScreen();
                              },
                            ),
                          );
                        },
                        color: kActiveCardColor,
                        cardChild: IconContent(
                            cardIcon: FontAwesomeIcons.bible,
                            label: 'Bible Text')),
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
                            label: 'Daily Bible')),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ));
  }
}