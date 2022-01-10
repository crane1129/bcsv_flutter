import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bcsv_flutter_project/data_models/endpoint_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';


class ApiGoogleDocContent{
  final api_endpoint;
  final tag;
  ApiGoogleDocContent({this.api_endpoint, this.tag});

  Future<List> getContent() async {

    String googleSheetContents = UserSharedPreferences.getAnnouncementContent() ?? '';
    if (googleSheetContents.isEmpty){
      googleSheetContents = await _getContents();
      UserSharedPreferences.setAnnouncementContent(googleSheetContents);
    }

    var jsonObj = jsonDecode(googleSheetContents)[tag] as List;
    List<dynamic> dataObjs = jsonObj.map((tagJson) => Announcement.fromJson(tagJson)).toList();

    return dataObjs;

  }

  Future <String> _getContents() async{

    http.Response response = await http.get(Uri.parse(api_endpoint));

    if (response.statusCode == 200){
      String data = response.body;
      return data;
    }else{
      print(response.statusCode);
    }

    return "";
  }
}