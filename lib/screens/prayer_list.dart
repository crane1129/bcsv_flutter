import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class PrayerListScreen extends StatefulWidget {
  const PrayerListScreen({Key? key}) : super(key: key);

  @override
  _PrayerListScreenState createState() => _PrayerListScreenState();
}

class _PrayerListScreenState extends State<PrayerListScreen> {
  bool isLoading = false;
  var prayerListTiles = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrayerListFromGoogleSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'New Message', text2: ''),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: prayerListTiles,
              ),
            ),
    );
  }

  void getPrayerListFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;
    var messageCounter = 0;
    var todayDate = DateTime.now();

    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['MESSAGE'],
      tag: '',
      cacheFileName: kPrayerListData,
      getSharedReference: UserSharedPreferences.getPrayerListTextCache,
      setSharedReference: UserSharedPreferences.setPrayerListTextCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _prayerList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_prayerList) as List;

    List<dynamic> prayerList =
        jsonObj.map((tagJson) => PrayerList.fromJson(tagJson)).toList();

    setState(() {
      for (PrayerList myPrayerItem in prayerList) {
        DateTime givenDate = DateTime.parse(myPrayerItem.expireDate);
        if (todayDate.isAfter(givenDate)) {
          //This is expired item
          continue;
        } else {
          prayerListTiles.add(
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.event, color: kActiveIconColor),
                      title: Text(
                        myPrayerItem.message,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        myPrayerItem.message,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    myPrayerItem.imageLink.isEmpty
                        ? Image.asset('assets/images/mountain1.jpg')
                        : Image.network(myPrayerItem.imageLink),
                  ],
                ),
              ),
            ),
          );

          messageCounter++;
        }
      }

      UserSharedPreferences.setPrayerListCounter(messageCounter);
      isLoading = false;
    });
  }
}
