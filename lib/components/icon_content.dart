import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
            ).animate().fade(end: 1).scaleXY(end: 1.2, duration: 500.ms),
          ),
          const SizedBox(height: 15.0),
          Text(
            label,
            style: kLabelTextStyle,
          )
        ]);
  }
}

class IconMsgContent extends StatelessWidget {
  IconMsgContent(
      {required this.cardIcon, required this.label, required this.msg_widget});

  final IconData cardIcon;
  final String label;
  final Widget msg_widget;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: kLabelTextStyle,
              ),
              const SizedBox(width: 5.0),
              msg_widget
            ],
          )
        ]);
  }
}
