import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';

class ApiEndpoint {
  static var apiMap = {};

  static Future<bool> bindEndpoints() async {
    try {
      String endpointList = await _getApiEndpoints();
      var jsonObj = jsonDecode(endpointList)['endpoints'] as List;
      List<Endpoint> endpointObjs =
          jsonObj.map((tagJson) => Endpoint.fromJson(tagJson)).toList();

      for (Endpoint e in endpointObjs) {
        apiMap[e.endpoint] = Uri.parse(e.url);
      }

      stdout.writeln('Endpoint bind is complete');
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static Future<String> _getApiEndpoints() async {
    http.Response response = await http.get(Uri.parse(kEndpointAPI));

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      stdout.writeln(response.statusCode);
    }

    return "";
  }

  static Future<void> checkNewMessage() async {
    // Get messages from the google doc
    http.Response response = await http.get(apiMap['MESSAGE']);
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/${kPrayerListData}");

    int messageCounter = 0;

    if (response.statusCode == 200) {
      var new_msg_id = [];

      var downloadedJsonObjMsg = jsonDecode(response.body) as List;
      var storedJsonObjMsg = [];

      try {
        storedJsonObjMsg = jsonDecode(file.readAsStringSync()) as List;
      } on Exception {
        stdout.writeln("File not found: ${file}");
      }

      var messages = jsonDecode(response.body) as List;
      if (storedJsonObjMsg.length > 0) {
        //Need to generate messageID list from the stored message object
        //And count how many new messages are there in the downloaded message obj

        //1. Generate messageID list from the file
        var messageIdList = [];
        var messageIdList_plus_viewed = [];
        for (dynamic message in storedJsonObjMsg) {
          messageIdList.add(message['MessageID']);
          messageIdList_plus_viewed
              .add([message['MessageID'], message['viewed']]);
        }

        for (dynamic message in downloadedJsonObjMsg) {
          if (!messageIdList.contains(message['MessageID'])) {
            // The message id does not exist. Which means it is a new message.
            // Therefore increment the counter.
            new_msg_id.add(message['MessageID']);
            messageCounter++;
          } else {
            for (var i = 0; i < messageIdList_plus_viewed.length; i++) {
              if (messageIdList_plus_viewed[i][0] == message['MessageID'] &&
                  messageIdList_plus_viewed[i][1] == false) {
                // The message ID exists in stored message list
                // but never been viewed
                new_msg_id.add(message['MessageID']);
                messageCounter++;
              }
            }
          }
        }

        UserSharedPreferences.setMessageListCounter(messageCounter);

        //Add 'viewed' element in message and save data to cache
        for (var i = 0; i < messages.length; i++) {
          if (new_msg_id.contains(messages[i]['MessageID']))
            messages[i]['viewed'] = false;
          else
            messages[i]['viewed'] = true;
        }
      } else {
        // This block is executed at the first time
        // when the app is installed and launched.

        //Just count the number of messages in response.body
        //Add 'viewed' element in message and save data to cache

        UserSharedPreferences.setMessageListCounter(messages.length);
        for (var i = 0; i < messages.length; i++) {
            messages[i]['viewed'] = false;
        }
      }

      file.writeAsStringSync(jsonEncode(messages),
          flush: true, mode: FileMode.write);

      UserSharedPreferences.setMessageListTextCache(true);
      stdout.writeln("Message stored.");
    } else {
      stdout.writeln(response.statusCode);
    }
  }
}
