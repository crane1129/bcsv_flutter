import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: LocaleText('Settings'),

        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.blue,
                shadowColor: Colors.black,
              ),
              onPressed: () async {
                LocaleNotifier.of(context)!.change('en');
                await UserSharedPreferences.setLanguageOption('en');
              },
              child: const Text('English', style: kRegularButtonTextStyle),
            ),
            const SizedBox(height: 30),
            Divider(),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                backgroundColor: Colors.blue,
                shadowColor: Colors.black,
              ),
              onPressed: () async {
                LocaleNotifier.of(context)!.change('ko');
                await UserSharedPreferences.setLanguageOption('ko');
              },
              child: const Text('한국어', style: kRegularButtonTextStyle),
            ),
          ],
        )
    );
  }
}
