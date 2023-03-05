import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class OfferingScreen extends StatelessWidget {
  final Uri url;

  OfferingScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.offering, text2: ''),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/offering_background.png'),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.volunteer_activism,
                            color: kActiveIconColor),
                        title: Text(AppLocalizations.of(context)!.offering),
                        subtitle:
                            Text(AppLocalizations.of(context)!.offeringVerse),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(10.0),
                      //   child: ElevatedButton.icon(
                      //     onPressed: () async {
                      //       if (await canLaunchUrl(url)) {
                      //         await launchUrl(url);
                      //       }
                      //     },
                      //     icon: Icon(Icons.volunteer_activism),
                      //     label: Text(
                      //         AppLocalizations.of(context)!.openButtonText),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.zellepay.zelle',
                                iosUrlScheme: 'zelle://',
                                appStoreLink: 'itms-apps://apps.apple.com/us/app/zelle/id1260755201',
                                // openStore: false
                              );

                              // Enter the package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                              // The `openStore` argument decides whether the app redirects to PlayStore or AppStore.
                              // For testing purpose you can enter com.instagram.android
                            },
                            child: Container(
                                child: Center(
                                  child: Text("Open",
                                    textAlign: TextAlign.center,
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
