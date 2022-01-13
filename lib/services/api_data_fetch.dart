import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';

class ApiGoogleDocContent {
  final ModelParam modelParam;
  final Map body;
  final bool isBodyRequired;

  ApiGoogleDocContent(
      {required this.modelParam,
      required this.body,
      required this.isBodyRequired});

  Future<String> getContent() async {
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/${modelParam.cacheFileName}");
    String googleSheetContents;

    if (modelParam.getSharedReference()) {
      //Cache exists. Load data from cache.
      googleSheetContents = file.readAsStringSync();
      print('Fetch data from local cache');
    } else {
      //Cache doesn't exist. Load data from Google Doc.
      googleSheetContents = await _getContents();

      //Save data to cache
      file.writeAsStringSync(googleSheetContents,
          flush: true, mode: FileMode.write);
      modelParam.setSharedReference(true);
      print('Fetch data from web');
    }

    return googleSheetContents;
  }

  Future<String> _getContents() async {

    http.Response response;

    if(isBodyRequired) {
      response = await http.post(
          Uri.parse(modelParam.apiEndpoint),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));
    }else{
      response = await http.get(
          Uri.parse(modelParam.apiEndpoint),
          headers: {"Content-Type": "application/json"},
      );
    }

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }

    return "";
  }
}
