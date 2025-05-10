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
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utilities/theme_notifier.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _groupValue;
  bool isStaffModeEnabled = false;
  Dialogs dialog = new Dialogs();

  @override
  void initState() {
    super.initState();
    _loadLanguageSetting();
    _loadStaffModeSetting();
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

  void _loadStaffModeSetting() async {
    bool enabled = await UserSharedPreferences.isStaffModeEnabled();
    setState(() => isStaffModeEnabled = enabled);
  }

  void _promptForPassword() async {
    String inputPassword = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enter Staff Password"),
        content: TextField(
          obscureText: true,
          onChanged: (val) => inputPassword = val,
          decoration: InputDecoration(labelText: "Password"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final res = await http.post(
                Uri.https('www.bridgeway.online', '/_functions/verifyStaffPassword'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({ 'password': inputPassword }),
              );
              if (res.statusCode == 200 && res.body.contains('true')) {
                await UserSharedPreferences.setStaffMode(true);
                await UserSharedPreferences.setStaffPassword(inputPassword);
                setState(() => isStaffModeEnabled = true);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Incorrect password")),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SwitchListTile(
                title: Text('Turn on Staff Mode', style: kLargeButtonTextStyle(context)),
                value: isStaffModeEnabled,
                onChanged: (val) {
                  if (val) {
                    _promptForPassword();
                  } else {
                    UserSharedPreferences.setStaffMode(false);
                    setState(() => isStaffModeEnabled = false);
                  }
                },
                secondary: Icon(Icons.lock_outline, color: kActiveIconColor(context)),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.wifi_protected_setup_outlined, color: kActiveIconColor(context)),
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
                          await dialog.confirm(context,
                              AppLocalizations.of(context)!.noticeTitle,
                              AppLocalizations.of(context)!.restartNotice);
                          if (dialog.isPressedConfirm) {
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

  void resetCache(String targetFile) async {
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$targetFile");
    file.writeAsStringSync("", flush: true, mode: FileMode.write);
    log("Reset Message cache file successfully.");

    // ✅ Clear staff mode and password from shared preferences
    await UserSharedPreferences.setStaffMode(false);
    await UserSharedPreferences.setStaffPassword("");
    log("Cleared staff mode and password from preferences.");
  }
}
