import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {super.key, required this.color, required this.cardChild, required this.onPress});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: cardChild,
        ));
  }
}

class ReusableCard2 extends StatelessWidget {
  const ReusableCard2(
      {super.key, required this.color, required this.cardChild, required this.onPress});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: color,
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white10,
                      Colors.black12,
                    ],
                  ),
                ),
                child: cardChild,
              )),
        ));
  }
}

class ReusableCard3 extends StatelessWidget {
  // Designed for message count in main screen
  const ReusableCard3(
      {super.key, required this.color,
      required this.cardChild,
      required this.onPress,
      msg_widget});

  final Color color;
  final Widget cardChild;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: color,
              clipBehavior: Clip.antiAlias,
              child: cardChild),
        ));
  }
}
