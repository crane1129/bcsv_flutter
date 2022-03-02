import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfferingScreen extends StatelessWidget {
  final String url;

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
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          icon: Icon(Icons.volunteer_activism),
                          label: Text(
                              AppLocalizations.of(context)!.openButtonText),
                        ),
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
