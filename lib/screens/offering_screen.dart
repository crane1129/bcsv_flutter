import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

class OfferingScreen extends StatelessWidget {
  final benevolence_account = "benevolence@bridgeway.online";
  final offering_account = "offering@bridgeway.online";

  OfferingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha:0.5),
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
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/offering_background.png'),

                ListTile(
                  //tileColor: Theme.of(context).colorScheme.onSurface,
                  leading:
                      Icon(Icons.volunteer_activism, color: kActiveIconColor(context)),
                  title: Text(AppLocalizations.of(context)!.offering,
                      style: kTitleTextStyle(context)),
                  subtitle: Text(AppLocalizations.of(context)!.offeringVerse,
                      style: kBodyTextStyle(context)),
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 1.5),
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
                            style: kListTitleStyleBlack(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${offering_account}",
                                style: kListTitleStyleBlack(context)),
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
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 1.5),
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
                            style: kListTitleStyleBlack(context)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${benevolence_account}",
                                style: kListTitleStyleBlack(context)),
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
