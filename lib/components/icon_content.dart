import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_locales/flutter_locales.dart';


class IconContent extends StatelessWidget {
  IconContent({required this.cardIcon, required this.label});

  final IconData cardIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Icon(
              cardIcon,
              size: 40.0,
              color: kCardIconColor,
            ),
          ),
          const SizedBox(height: 15.0),
          LocaleText(label,
              style: kLabelTextStyle,
              )
        ]);
  }
}