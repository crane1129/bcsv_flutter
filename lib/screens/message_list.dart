import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/globals.dart' as globals;

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
    
    // Reset counter when user actually opens the message screen
    UserSharedPreferences.setMessageListCounter(0);
    globals.messageCnt = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.newMessage, text2: ''),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: SpinKitFadingCube(
                    itemBuilder: (BuildContext context, int index) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey,
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
      ),
    );
  }

  void getMessageListFromGoogleSheet() async {
    //Show loading spinner
    setState(() {
      isLoading = true;
    });

    // Check if MESSAGE endpoint is available
    final messageEndpoint = ApiEndpoint.apiMap['MESSAGE'];
    if (messageEndpoint == null) {
      // Handle case where endpoint is not available
      setState(() {
        isLoading = false;
        prayerListTiles.clear();
        // Add an error message card
        prayerListTiles.add(
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_off,
                      size: 48,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.networkErrorMessage,
                      style: kCardTitleStyle(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.retryNetworkMessage,
                      style: kBodyTextStyle(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
      return;
    }

    ModelParam modelParam = ModelParam(
      apiEndpoint: messageEndpoint,
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
        // DateTime givenDate = DateTime.parse(myMessageItem.expireDate);
        // if (todayDate.isAfter(givenDate)) {
        //   //This is expired item
        //   continue;
        // } else {
        //
        // }
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
                      ? Image.asset('assets/images/bridgeway.png',
                          height: 100, width: 200, fit: BoxFit.fitWidth)
                      : Image.network(
                          myMessageItem.imageLink,
                        ),
                  ListTile(
                    leading:
                        Icon(Icons.event, color: kActiveIconColor(context)),
                    title: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        myMessageItem.title,
                        overflow: TextOverflow.ellipsis,
                        style: kCardTitleStyle(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SelectableText(
                      myMessageItem.message,
                      style: kBodyTextStyle(context),
                    ),
                  ),
                  myMessageItem.externalLink.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              if (await canLaunchUrl(
                                  Uri.parse(myMessageItem.externalLink))) {
                                await launchUrl(
                                    Uri.parse(myMessageItem.externalLink));
                              }
                            },
                            icon: Icon(Icons.link),
                            label: Text('Link'),
                          ))
                      : SizedBox(height: 1.0),
                ],
              ),
            ),
          ),
        );
      }
      // Don't reset counter here - only reset when user actually views messages
      // UserSharedPreferences.setMessageListCounter(0);
      // globals.messageCnt = 0;
      isLoading = false;
    });

    // Update the "viewed" field and save to file
    for (var i = 0; i < jsonObj.length; i++) {
      jsonObj[i]['viewed'] = true;
    }

    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/${kPrayerListData}");
    file.writeAsStringSync(jsonEncode(jsonObj),
        flush: true, mode: FileMode.write);
  }
}
