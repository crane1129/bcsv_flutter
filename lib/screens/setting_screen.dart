import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
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
  bool isStaffMessageModeEnabled = false;
  bool isStaffOpinionModeEnabled = false;
  
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
    final messageEnabled = await UserSharedPreferences.isStaffMessageModeEnabled();
    final opinionEnabled = await UserSharedPreferences.isStaffOpinionModeEnabled();
    setState(() {
      isStaffMessageModeEnabled = messageEnabled;
      isStaffOpinionModeEnabled = opinionEnabled;
    });
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

  Future<void> _promptForPassword({
    required String role,
    required Future<void> Function() onSuccess,
  }) async {
    String password = '';
    bool obscurePassword = true;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Staff Password"),
          content: TextField(
            obscureText: obscurePassword,
            onChanged: (val) => password = val,
            decoration: InputDecoration(
              labelText: "Password",
              suffixIcon: IconButton(
                icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setDialogState(() => obscurePassword = !obscurePassword),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                const expectedHashes = {
                  'opinion': '17595cbb88e5634223b377253be9039189a4d9e496c851e5041c73cc8c7cad27',
                  'message': '08093ad1adfc5a2b2f1a12e5f552343145709bf57ad4d6c7679a5e81f666cb7c',
                };
                final inputHash = sha256.convert(utf8.encode(password)).toString();
                if (inputHash == expectedHashes[role]) {
                  await onSuccess();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Access denied")),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        ),
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
                side: BorderSide(
                  color: kActiveIconColorAdmin(context).withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.manage_accounts_outlined, color: kActiveIconColorAdmin(context)),
                    title: Text(AppLocalizations.of(context)!.staffOptions, style: kLargeButtonTextStyle(context)),
                    subtitle: Text(AppLocalizations.of(context)!.staffOptionsSubtitle, style: kBodyTextStyle(context)),
                  ),
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.staffMessageManagement, style: kLargeButtonTextStyle(context)),
                    subtitle: Text(AppLocalizations.of(context)!.staffMessageManagementSubtitle, style: kBodyTextStyle(context)),
                    value: isStaffMessageModeEnabled,
                    onChanged: (val) {
                      if (val) {
                        _promptForPassword(
                          role: 'message',
                          onSuccess: () async {
                            await UserSharedPreferences.setStaffMessageMode(true);
                            setState(() => isStaffMessageModeEnabled = true);
                          },
                        );
                      } else {
                        UserSharedPreferences.setStaffMessageMode(false);
                        setState(() => isStaffMessageModeEnabled = false);
                      }
                    },
                    secondary: Icon(Icons.cloud_upload_outlined, color: kActiveIconColorAdmin(context)),
                  ),
                  SwitchListTile(
                    title: Text(AppLocalizations.of(context)!.staffOpinionReview, style: kLargeButtonTextStyle(context)),
                    subtitle: Text(AppLocalizations.of(context)!.staffOpinionReviewSubtitle, style: kBodyTextStyle(context)),
                    value: isStaffOpinionModeEnabled,
                    onChanged: (val) {
                      if (val) {
                        _promptForPassword(
                          role: 'opinion',
                          onSuccess: () async {
                            await UserSharedPreferences.setStaffOpinionMode(true);
                            setState(() => isStaffOpinionModeEnabled = true);
                          },
                        );
                      } else {
                        UserSharedPreferences.setStaffOpinionMode(false);
                        setState(() => isStaffOpinionModeEnabled = false);
                      }
                    },
                    secondary: Icon(Icons.admin_panel_settings_outlined, color: kActiveIconColorAdmin(context)),
                  ),
                ],
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
