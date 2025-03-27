import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import '../components/webview/webview_screen.dart';
import '../services/api_endpoint.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            color: kActiveCardColor,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/offering_background.png'),

                ListTile(
                  leading:
                      Icon(Icons.volunteer_activism, color: kActiveIconColor),
                  title: Text(AppLocalizations.of(context)!.offering,
                      style: kTitleTextStyle),
                  subtitle: Text(AppLocalizations.of(context)!.offeringVerse,
                      style: kBodyTextStyle),
                ),
                Card(
                  color: kInactiveIconColor,
                  borderOnForeground: true,
                  elevation: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.favorite,
                            color: Colors.green),
                        title: Text(
                            AppLocalizations.of(context)!.sundayOffering,
                            style: kListTitleStyleBlack),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${offering_account}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.copy),
                              onPressed: () async {
                                showMessage(offering_account);
                                Clipboard.setData(
                                    ClipboardData(text: "${offering_account}"));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: kInactiveIconColor,
                  borderOnForeground: true,
                  elevation: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.favorite,
                            color: Colors.green),
                        title: Text(
                            AppLocalizations.of(context)!.benevolenceOffering,
                            style: kListTitleStyleBlack),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${benevolence_account}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.copy),
                              onPressed: () async {
                                showMessage(benevolence_account);
                                Clipboard.setData(
                                    ClipboardData(text: "${benevolence_account}"));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: kInactiveIconColor,
                  borderOnForeground: true,
                  elevation: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.info,
                            color: Colors.red),
                        title: Text(
                            AppLocalizations.of(context)!.offering_direction,
                            style: kListTitleStyleBlack),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${AppLocalizations.of(context)!.offering_direction_text}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.openButtonText),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WebViewApp(
                                          url: ApiEndpoint
                                              .apiMap['ONLINE_OFFERING_DIRECTION'] ??
                                              kBaseUrl,
                                          title1: AppLocalizations.of(context)!
                                              .offering_direction,
                                          title2: '');
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
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
