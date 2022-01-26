import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

}


class _SettingsPageState extends State<SettingsPage> {
  @override
  var _groupValue;

  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      if (UserSharedPreferences.getLanguageOption() == 'ko'){
        _groupValue = 1;
      }else{
        _groupValue = 2;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'Offering', text2: ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: kActiveCardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        Icon(Icons.language_outlined, color: kActiveIconColor),
                    title: LocaleText('Language Setting', style: kTitleTextStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _groupValue,
                        onChanged: (value) async {
                          _groupValue = value;
                          LocaleNotifier.of(context)!.change('ko');
                          await UserSharedPreferences.setLanguageOption('ko');
                          print(_groupValue);
                          setState(() {

                          });
                        },
                      ),
                      Text('한국어', style: kBodyTextStyle),
                      SizedBox(width: 60.0),
                      Radio(
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (value) async {
                          _groupValue = value;
                          LocaleNotifier.of(context)!.change('en');
                          await UserSharedPreferences.setLanguageOption('en');
                          print(_groupValue);
                          setState(() {

                          });
                        },
                      ),
                      Text('English', style: kBodyTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
