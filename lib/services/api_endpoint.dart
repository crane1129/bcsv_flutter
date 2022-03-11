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
        apiMap[e.endpoint] = e.url;
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
    http.Response response = await http.get(Uri.parse(apiMap['MESSAGE']));
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/${kPrayerListData}");

    int messageCounter = 0;

    if (response.statusCode == 200) {

      var downloadedJsonObjMsg = jsonDecode(response.body) as List;
      var storedJsonObjMsg = [];

      try{
        storedJsonObjMsg = jsonDecode(file.readAsStringSync()) as List;
      } on Exception catch(FileSystemException){
        stdout.writeln("File not found: ${file}");
      }

      if (storedJsonObjMsg.length > 0){
        //Need to generate messageID list from the stored message object
        //And count how many new messages are there in the downloaded message obj

        //1. Generate messageID list
        var messageIdList =[];
        for(dynamic message in storedJsonObjMsg){
          messageIdList.add(message['MessageID']);
        }

        for(dynamic message in downloadedJsonObjMsg){
          if (!messageIdList.contains(message['MessageID'])){
            messageCounter++;
          }
        }

        UserSharedPreferences.setMessageListCounter(messageCounter);

      }else{
        //Just count the number of messages in response.body
        var jsonObj = jsonDecode(response.body) as List;
        UserSharedPreferences.setMessageListCounter(jsonObj.length);
      }

      //Save data to cache
      file.writeAsStringSync(response.body,
          flush: true, mode: FileMode.write);

      UserSharedPreferences.setMessageListTextCache(true);
      stdout.writeln("Message stored.");

    } else {
      stdout.writeln(response.statusCode);
    }
  }
}
