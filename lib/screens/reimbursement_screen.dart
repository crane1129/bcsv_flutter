import 'package:flutter/material.dart';
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
        title: AppBarHeaderText(text1: 'Serving Turn', text2: ''),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/mountain1.jpeg'),
                  ListTile(
                    leading: Icon(Icons.add_shopping_cart_rounded, color: kActiveIconColor),
                    title: Text("Chruch Reimbursement"),
                    subtitle: Text("Please submit your expense for church events"),
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        if (await canLaunch(url)){
                          await launch(url);
                        }
                      },
                      icon: Icon(Icons.volunteer_activism),
                      label: Text('Open Form')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
