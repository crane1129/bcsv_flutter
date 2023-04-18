import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {required this.color, required this.cardChild, required this.onPress});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          child: cardChild,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ));
  }
}

class ReusableCard2 extends StatelessWidget {
  ReusableCard2(
      {required this.color, required this.cardChild, required this.onPress});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Padding(padding: EdgeInsets.all(2),
          child: Card(
              elevation: 2,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: color,
              clipBehavior: Clip.antiAlias,
              child: cardChild),
        ));
  }
}

class ReusableCard3 extends StatelessWidget {
  // Designed for message count in main screen
  ReusableCard3(
      {required this.color, required this.cardChild, required this.onPress, msg_widget});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Padding(padding: EdgeInsets.all(2),
          child: Card(
              elevation: 2,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: color,
              clipBehavior: Clip.antiAlias,
              child: cardChild),
        ));
  }
}
