import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/locale_provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  var _groupValue;
  bool isStaffModeEnabled = false;
  
  // Card visibility states
  bool showAnnouncementCard = true;
  bool showMessageCard = true;
  bool showServingTurnCard = true;
  bool showOfferingCard = true;
  bool showBibleTextCard = true;
  bool showDailyBibleCard = true;
  bool showBibleSearchCard = true;
  bool showKeywordSearchCard = true;

  @override
  void initState() {
    super.initState();
    _loadLanguageSetting();
    _loadStaffModeSetting();
    _loadCardVisibilitySettings();
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
  
  void _loadCardVisibilitySettings() {
    setState(() {
      showAnnouncementCard = UserSharedPreferences.getShowAnnouncementCard();
      showMessageCard = UserSharedPreferences.getShowMessageCard();
      showServingTurnCard = UserSharedPreferences.getShowServingTurnCard();
      showOfferingCard = UserSharedPreferences.getShowOfferingCard();
      showBibleTextCard = UserSharedPreferences.getShowBibleTextCard();
      showDailyBibleCard = UserSharedPreferences.getShowDailyBibleCard();
      showBibleSearchCard = UserSharedPreferences.getShowBibleSearchCard();
      showKeywordSearchCard = UserSharedPreferences.getShowKeywordSearchCard();
    });
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

  void _showRestartDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.restart_alt, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.restartRequiredTitle),
          ],
        ),
        content: Text(
          AppLocalizations.of(context)!.restartRequiredMessage,
          style: kBodyTextStyle(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(context)!.restartLater,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Restart the app
              exit(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text(AppLocalizations.of(context)!.restartNow),
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
                          log('Language option: $_groupValue');
                          await ref.read(localeNotifierProvider.notifier).setLocale(
                            const Locale.fromSubtags(languageCode: 'ko'),
                          );
                          setState(() {});
                        },
                      ),
                      Text('한국어', style: kBodyTextStyle(context)),
                      SizedBox(width: 60.0),
                      Radio(
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (value) async {
                          _groupValue = value;
                          log('Language option: $_groupValue');
                          await ref.read(localeNotifierProvider.notifier).setLocale(
                            const Locale.fromSubtags(languageCode: 'en'),
                          );
                          setState(() {});
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
                  Consumer(
                    builder: (context, ref, _) {
                      final themeIndex = ref.watch(themeIndexProvider);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<int>(
                            title: const Text('Light'),
                            value: 0,
                            groupValue: themeIndex,
                            onChanged: (val) => ref.read(themeNotifierProvider.notifier).setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: const Text('Dark'),
                            value: 1,
                            groupValue: themeIndex,
                            onChanged: (val) => ref.read(themeNotifierProvider.notifier).setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: const Text('Sepia'),
                            value: 2,
                            groupValue: themeIndex,
                            onChanged: (val) => ref.read(themeNotifierProvider.notifier).setThemeByIndex(val!),
                          ),
                          RadioListTile<int>(
                            title: const Text('Midnight Blue'),
                            value: 3,
                            groupValue: themeIndex,
                            onChanged: (val) => ref.read(themeNotifierProvider.notifier).setThemeByIndex(val!),
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
              child: ExpansionTile(
                leading: Icon(Icons.visibility_outlined, color: kActiveIconColor(context)),
                title: Text(AppLocalizations.of(context)!.cardVisibilitySettings, style: kLargeButtonTextStyle(context)),
                subtitle: Text(AppLocalizations.of(context)!.cardVisibilitySubtitle, style: kBodyTextStyle(context)),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.announcement, style: kBodyTextStyle(context)),
                          value: showAnnouncementCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowAnnouncementCard(val);
                            setState(() => showAnnouncementCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.newMessage, style: kBodyTextStyle(context)),
                          value: showMessageCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowMessageCard(val);
                            setState(() => showMessageCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.servingTurn, style: kBodyTextStyle(context)),
                          value: showServingTurnCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowServingTurnCard(val);
                            setState(() => showServingTurnCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.offering, style: kBodyTextStyle(context)),
                          value: showOfferingCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowOfferingCard(val);
                            setState(() => showOfferingCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.bibleText, style: kBodyTextStyle(context)),
                          value: showBibleTextCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowBibleTextCard(val);
                            setState(() => showBibleTextCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.dailyBible, style: kBodyTextStyle(context)),
                          value: showDailyBibleCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowDailyBibleCard(val);
                            setState(() => showDailyBibleCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)!.bible_search, style: kBodyTextStyle(context)),
                          value: showBibleSearchCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowBibleSearchCard(val);
                            setState(() => showBibleSearchCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                        SwitchListTile(
                          title: Text('Bible Keyword Search', style: kBodyTextStyle(context)),
                          value: showKeywordSearchCard,
                          onChanged: (val) async {
                            await UserSharedPreferences.setShowKeywordSearchCard(val);
                            setState(() => showKeywordSearchCard = val);
                            _showRestartDialog();
                          },
                          dense: true,
                        ),
                      ],
                    ),
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
