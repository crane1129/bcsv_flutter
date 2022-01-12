import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bcsv_flutter_project/data_models/endpoint_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:path_provider/path_provider.dart';

class ApiGoogleDocContent {
  final String api_endpoint;
  final String tag;
  final String cacheFileName;

  ApiGoogleDocContent(
      {required this.api_endpoint,
      required this.tag,
      required this.cacheFileName});

  Future<List> getContent() async {
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$cacheFileName}");
    String googleSheetContents;

    if (UserSharedPreferences.getAnnouncementCache()) {
      //Cache exists. Load data from cache.
      googleSheetContents = file.readAsStringSync();
    } else {
      //Cache doesn't exist. Load data from Google Doc.
      googleSheetContents = await _getContents();

      //Save data to cache
      file.writeAsStringSync(googleSheetContents,
          flush: true, mode: FileMode.write);
      UserSharedPreferences.setAnnouncementCache(true);
    }

    var jsonObj = jsonDecode(googleSheetContents)[tag] as List;
    List<dynamic> dataObjs =
        jsonObj.map((tagJson) => Announcement.fromJson(tagJson)).toList();

    return dataObjs;
  }

  Future<String> _getContents() async {
    http.Response response = await http.get(Uri.parse(api_endpoint));

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }

    return "";
  }
}
