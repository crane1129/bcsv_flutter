import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_locales/flutter_locales.dart';


class AppBarHeaderText extends StatelessWidget {

  AppBarHeaderText({required this.text1, required this.text2});
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: <Widget>[
        LocaleText(text1, style: kAppBarTextStyle),
        SizedBox(width: 5.0),
        LocaleText(text2, style: kAppBarTextStyleSmall),
      ],
    );
  }
}
