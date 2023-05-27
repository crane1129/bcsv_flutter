import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:overlay_support/overlay_support.dart';

class OfferingScreen extends StatelessWidget {
  final Uri url;
  final benevolence_account = "benevolence@bridgeway.online";
  final offering_account = "offering@bridgeway.online";

  OfferingScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.offering, text2: ''),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/offering_background.png'),
                SizedBox(height: 20.0),
                ListTile(
                  leading:
                      Icon(Icons.volunteer_activism, color: kActiveIconColor),
                  title: Text(AppLocalizations.of(context)!.offering),
                  subtitle: Text(AppLocalizations.of(context)!.offeringVerse),
                ),
                SizedBox(height: 20.0),
                Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.verified_user_outlined,
                            color: Colors.green),
                        title: Text(
                            AppLocalizations.of(context)!.sundayOffering,
                            style: TextStyle(color: Colors.black)),
                        subtitle: Text(
                          "${offering_account}",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Copy'),
                            onPressed: () async {
                              showMessage(offering_account);
                              Clipboard.setData(
                                  ClipboardData(text: "${offering_account}"));
                            },
                          ),
                          TextButton(
                            child: const Text('Open Zelle'),
                            onPressed: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.zellepay.zelle',
                                iosUrlScheme: 'zelle://',
                                appStoreLink:
                                    'itms-apps://apps.apple.com/us/app/zelle/id1260755201',
                                // openStore: false
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.verified_user_outlined,
                            color: Colors.green),
                        title: Text(
                            AppLocalizations.of(context)!.benevolenceOffering,
                            style: TextStyle(color: Colors.black)),
                        subtitle: Text(
                          "${benevolence_account}",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Copy'),
                            onPressed: () async {
                              showMessage(benevolence_account);
                              Clipboard.setData(
                                  ClipboardData(text: "${benevolence_account}"));
                            },
                          ),
                          TextButton(
                            child: const Text('Open Zelle'),
                            onPressed: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.zellepay.zelle',
                                iosUrlScheme: 'zelle://',
                                appStoreLink:
                                    'itms-apps://apps.apple.com/us/app/zelle/id1260755201',
                                // openStore: false
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.verified_user_outlined),
                        title: Text(
                            AppLocalizations.of(context)!.sundayOffering,
                            style: TextStyle(color: Colors.black)),
                        subtitle: Text(
                          "Cheddar Up을 통한 헌금",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Open Cheddar Up'),
                            onPressed: () async {
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMessage(email) {
    showSimpleNotification(
        Text(
          email + " copied to clipboard",
        ),
        leading: Icon(Icons.content_paste_outlined),
        background: Colors.blueAccent,
        elevation: 5);
  }
}
