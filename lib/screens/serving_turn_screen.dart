import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class ServingTurnPage extends StatefulWidget {
  const ServingTurnPage({Key? key}) : super(key: key);

  @override
  _ServingTurnPageState createState() => _ServingTurnPageState();
}

class _ServingTurnPageState extends State<ServingTurnPage> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServingTurnFromGoogleSheet();
  }

  var servingTurnTiles = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'Serving Turn', text2: ''),
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
                children: servingTurnTiles,
              ),
            ),
    );
  }

  void getServingTurnFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;
    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['SERVING_TURN'],
      tag: 'servingTurns',
      cacheFileName: kServingTurnData,
      getSharedReference: UserSharedPreferences.getServingTurnCache,
      setSharedReference: UserSharedPreferences.setServingTurnCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _servingTurntList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_servingTurntList)[modelParam.tag] as List;

    List<dynamic> servingTurnList =
        jsonObj.map((tagJson) => ServingTurn.fromJson(tagJson)).toList();

    setState(
      () {
        for (ServingTurn content in servingTurnList) {
          servingTurnTiles.add(
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white10,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ServingTurnTile(
                      content: content.date,
                      leadingText: Icon(Icons.accessibility_new_outlined,
                          color: kActiveIconColor)),
                  ServingTurnTile(
                      content: content.prayer,
                      leadingText: const Text('기도', style: kBodyTextStyle)),
                  ServingTurnTile(
                      content: content.food,
                      leadingText: const Text('음식준비', style: kBodyTextStyle)),
                  ListTile(
                    leading: Text('화요 기도회', style: kBodyTextStyle),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          content.tuesdayPrayMeeting,
                          style: kBodyTextStyle,
                        ),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        content.babysitter.isEmpty
                            ? Text('N/A')
                            : Text(content.babysitter, style: kBodyTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
  }
}

class ServingTurnTile extends StatelessWidget {
  const ServingTurnTile(
      {Key? key, required this.content, required this.leadingText})
      : super(key: key);

  final Widget leadingText;
  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          content.isEmpty ? Text('N/A') : Text(content, style: kBodyTextStyle),
        ],
      ),
    );
  }
}
