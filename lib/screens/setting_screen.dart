import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/utilities/locale_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/dialog/dialog.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  var _groupValue;
  Dialogs dialog = new Dialogs();
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      if (UserSharedPreferences.getLanguageOption() == 'ko') {
        _groupValue = 1;
      } else {
        _groupValue = 2;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.settings, text2: ''),
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
                    title: Text(AppLocalizations.of(context)!.languageSetting,
                        style: kCardTitleStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _groupValue,
                        onChanged: (value) async {
                          _groupValue = value;
                          await UserSharedPreferences.setLanguageOption('ko');
                          log('Language option: $_groupValue');
                          setState(() {
                            final provider = Provider.of<LocaleProvider>(context, listen: false);
                            provider.setLocale(Locale.fromSubtags(languageCode: 'ko'));
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
                          await UserSharedPreferences.setLanguageOption('en');
                          log('Language option: $_groupValue');
                          setState(() {
                            final provider = Provider.of<LocaleProvider>(context, listen: false);
                            provider.setLocale(Locale.fromSubtags(languageCode: 'en'));
                          });
                        },
                      ),
                      Text('English', style: kBodyTextStyle),
                    ],
                  ),
                  ListTile(
                    leading:
                    Icon(Icons.wifi_protected_setup_outlined, color: kActiveIconColor),
                    title: Text(AppLocalizations.of(context)!.initMessage,
                        style: kCardTitleStyle),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      OutlinedButton(
                        child: Text(AppLocalizations.of(context)!.runButton,
                            style: kCardTitleStyle),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        onPressed: () async {
                          resetCache(kPrayerListData);
                          await dialog.confirm(context, AppLocalizations.of(context)!.noticeTitle, AppLocalizations.of(context)!.restartNotice);
                          if (dialog.isPressedConfirm){
                            //Terminate app
                            exit(0);
                          }
                        },
                      ),
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

  void resetCache(String target_file) async{
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/${target_file}");

    file.writeAsStringSync("",
        flush: true, mode: FileMode.write);

    log("Reset Message cache file successfully.");
  }
}

