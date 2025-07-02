import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReimbursementScreen extends StatelessWidget {
  ReimbursementScreen({required this.url});

  final Uri url;

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
            text1: AppLocalizations.of(context)!.reimbursement, text2: ''),
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
                      Image.asset('assets/images/reimbursement.png'),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.add_shopping_cart_rounded,
                            color: kActiveIconColor(context)),
                        title: Text(
                            AppLocalizations.of(context)!.churchReimbursement),
                        subtitle: Text(
                            AppLocalizations.of(context)!.reimbursementDesc),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                          icon: Icon(Icons.add_shopping_cart_rounded),
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
