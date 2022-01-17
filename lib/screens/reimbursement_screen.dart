import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';


class ReimbursementScreen extends StatelessWidget {
  ReimbursementScreen({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'Reimbursement', text2: ''),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/mountain1.jpg'),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.add_shopping_cart_rounded, color: kActiveIconColor),
                        title: LocaleText("Church Reimbursement"),
                        subtitle: LocaleText("Please submit your expense for church events"),
                      ),
                      Padding(padding: EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              if (await canLaunch(url)){
                                await launch(url);
                              }
                            },
                            icon: Icon(Icons.volunteer_activism),
                            label: Text('Open Form'),),
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
