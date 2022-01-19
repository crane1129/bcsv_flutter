import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({Key? key}) : super(key: key);

  @override
  _MessageListScreenState createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  bool isLoading = false;
  var prayerListTiles = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessageListFromGoogleSheet();
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

  void getMessageListFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;
    var messageCounter = 0;
    var todayDate = DateTime.now();

    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['MESSAGE'],
      tag: '',
      cacheFileName: kPrayerListData,
      getSharedReference: UserSharedPreferences.getMessageListTextCache,
      setSharedReference: UserSharedPreferences.setMessageListTextCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _messageList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_messageList) as List;

    List<dynamic> messageList =
        jsonObj.map((tagJson) => MessageList.fromJson(tagJson)).toList();

    setState(() {
      for (MessageList myMessageItem in messageList) {
        DateTime givenDate = DateTime.parse(myMessageItem.expireDate);
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
                    myMessageItem.imageLink.isEmpty
                        ? Image.asset(
                      'assets/images/mountain1.jpg',
                    )
                        : Image.network(
                      myMessageItem.imageLink,
                    ),
                    ListTile(
                      leading: Icon(Icons.event, color: kActiveIconColor),
                      title: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          myMessageItem.title,
                          overflow: TextOverflow.ellipsis,
                          style: kCardTitleStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SelectableText(
                        myMessageItem.message,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    myMessageItem.externalLink.isNotEmpty
                        ? OutlinedButton.icon(
                            onPressed: () async {
                              if (await canLaunch(myMessageItem.externalLink)) {
                                await launch(myMessageItem.externalLink);
                              }
                            },
                            icon: Icon(Icons.link),
                            label: Text('Link'),
                          )
                        : SizedBox(height: 1.0),
                  ],
                ),
              ),
            ),
          );

          messageCounter++;
        }
      }

      UserSharedPreferences.setMessageListCounter(messageCounter);
      isLoading = false;
    });
  }
}
