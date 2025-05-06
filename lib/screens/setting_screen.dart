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

import '../utilities/theme_notifier.dart';
import '../utilities/themes.dart';


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
        backgroundColor: Colors.transparent.withValues(alpha:0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.settings, text2: ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              //color: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        Icon(Icons.language_outlined, color: kActiveIconColor(context)),
                    title: Text(AppLocalizations.of(context)!.languageSetting,
                        style: kLargeButtonTextStyle(context)),
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
                      Text('한국어', style: kBodyTextStyle(context)),
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
                      Text('English', style: kBodyTextStyle(context)),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              //color: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.color_lens_outlined, color: kActiveIconColor(context)),
                    title: Text('Theme',
                        style: kLargeButtonTextStyle(context)),
                  ),
                  Consumer<ThemeNotifier>(
                    builder: (context, themeNotifier, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<String>(
                            title: Text('Light'),
                            value: 'light',
                            groupValue: themeNotifier.themeName,
                            onChanged: (val) => themeNotifier.setTheme('light', lightTheme),
                          ),
                          RadioListTile<String>(
                            title: Text('Dark'),
                            value: 'dark',
                            groupValue: themeNotifier.themeName,
                            onChanged: (val) => themeNotifier.setTheme('dark', darkTheme),
                          ),
                          RadioListTile<String>(
                            title: Text('Bible'),
                            value: 'bible',
                            groupValue: themeNotifier.themeName,
                            onChanged: (val) => themeNotifier.setTheme('bible', bibleTheme),
                          ),
                          RadioListTile<String>(
                            title: Text('Sepia'),
                            value: 'sepia',
                            groupValue: themeNotifier.themeName,
                            onChanged: (val) => themeNotifier.setTheme('sepia', sepiaTheme),
                          ),
                          RadioListTile<String>(
                            title: Text('Midnight Blue'),
                            value: 'midnight',
                            groupValue: themeNotifier.themeName,
                            onChanged: (val) => themeNotifier.setTheme('midnight', midnightBlueTheme),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            Card(
              //color: Theme.of(context).colorScheme.onSurface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                    Icon(Icons.wifi_protected_setup_outlined, color: kActiveIconColor(context)),
                    title: Text(AppLocalizations.of(context)!.initMessage,
                        style: kLargeButtonTextStyle(context)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      OutlinedButton(
                        child: Text(AppLocalizations.of(context)!.runButton,
                            style: kLargeButtonTextStyle(context)),
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
            )
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

