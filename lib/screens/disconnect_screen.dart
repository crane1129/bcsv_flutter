import 'package:flutter/material.dart';

class DisconnectScreen extends StatelessWidget {
  const DisconnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: double.infinity,
        child: Image(
            image: AssetImage('assets/images/disconnect.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}
