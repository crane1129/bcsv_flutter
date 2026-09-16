import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/utilities/locale_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../utilities/theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _groupValue;

  @override
  void initState() {
    super.initState();
    _loadLanguageSetting();
  }

  void _loadLanguageSetting() {
    setState(() {
      if (UserSharedPreferences.getLanguageOption() == 'ko') {
        _groupValue = 1;
      } else {
        _groupValue = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withAlpha(25),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.settings,
          text2: '',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.language_outlined, color: kActiveIconColor(context)),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.color_lens_outlined, color: kActiveIconColor(context)),
                    title: Text('Theme', style: kLargeButtonTextStyle(context)),
                  ),
                  Consumer<ThemeNotifier>(
                    builder: (context, themeNotifier, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<int>(
                            title: Text('Light'),
                            value: 0,
                            groupValue: themeNotifier.currentIndex,
                            onChanged: (val) => themeNotifier.setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: Text('Dark'),
                            value: 1,
                            groupValue: themeNotifier.currentIndex,
                            onChanged: (val) => themeNotifier.setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: Text('Sepia'),
                            value: 2,
                            groupValue: themeNotifier.currentIndex,
                            onChanged: (val) => themeNotifier.setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: Text('Midnight Blue'),
                            value: 3,
                            groupValue: themeNotifier.currentIndex,
                            onChanged: (val) => themeNotifier.setThemeByIndex(val!),
                          ),
                        ],
                      );
                    },
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
