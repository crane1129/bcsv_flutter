import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class SundayBibleTextScreen extends StatelessWidget {
  const SundayBibleTextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: LocaleText('bcsv.org'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kMainAppBarColor,
                      Colors.deepPurple,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Sunday Bible Text Screen', style: kBodyTextStyle)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
