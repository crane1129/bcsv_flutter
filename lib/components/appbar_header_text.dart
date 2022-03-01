import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';


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
        Text(text1, style: kAppBarTextStyle),
        SizedBox(width: text2.isEmpty? 0 : 5.0),
        Text(text2, style: kAppBarTextStyleSmall),
      ],
    );
  }
}
