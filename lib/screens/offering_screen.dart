import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';


class OfferingScreen extends StatelessWidget {
  final String url;

  OfferingScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'Offering', text2: ''),
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
                      Image.asset('assets/images/offering_background.png'),
                      SizedBox(height: 20.0),
                      ListTile(
                        leading: Icon(Icons.add_shopping_cart_rounded, color: kActiveIconColor),
                        title: Text("Offering"),
                        subtitle: Text("각각 그 마음에 정한 대로 할 것이요\n인색함으로나 억지로 하지 말지니\n하나님은 즐겨 내는 자를 사랑 하시느니라.\n(고후9:7)"),
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
