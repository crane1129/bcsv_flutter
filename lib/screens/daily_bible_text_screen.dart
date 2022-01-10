import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';


class DailyBibleTextScreen extends StatelessWidget {
  const DailyBibleTextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            title: AppBarHeaderText(text1: 'Bridgeway', text2: 'Baptist Church'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kMainAppBarColor,
                      Colors.black54,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Daily Bible Text Screen', style: kBodyTextStyle)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
