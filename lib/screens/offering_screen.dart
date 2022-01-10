import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/components/reusable_card.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class OfferingScreen extends StatelessWidget {
  final String url;

  OfferingScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: LocaleText('Offering'),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/offering_background.png'),
            const Padding(
              padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
              child: Text(
                "각각 그 마음에 정한 대로 할 것이요\n인색함으로나 억지로 하지 말지니\n하나님은 즐겨 내는 자를 사랑 하시느니라.\n(고후9:7)",
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ReusableCard(
                  color: kActiveCardColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Offering',
                        style: kLargeButtonTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  onPress: () async {
                    final url = kOfferingUrl;
                    if (await canLaunch(url)){
                      await launch(url);
                    }
                  }),
            ),
            SizedBox(height: 100)
          ],
        )));
  }
}
