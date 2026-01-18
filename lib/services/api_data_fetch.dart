import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';


class ApiGoogleDocContent {
  final ModelParam modelParam;
  final Map body;
  final bool isBodyRequired;
  
  // Timeout configuration
  static const Duration _defaultTimeout = Duration(seconds: 15);

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

    try {
      if(isBodyRequired) {
        response = await http.post(
            modelParam.apiEndpoint,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body)).timeout(
          _defaultTimeout,
          onTimeout: () => throw TimeoutException('Google Doc fetch timeout', _defaultTimeout),
        );
      }else{
        final Uri updatedEndpoint = modelParam.apiEndpoint.replace(
          queryParameters: {
            ...modelParam.apiEndpoint.queryParameters,
            'year': DateTime.now().year.toString(),
          },
        );

        response = await http.get(
            updatedEndpoint,
            headers: {"Content-Type": "application/json"},
        ).timeout(
          _defaultTimeout,
          onTimeout: () => throw TimeoutException('Google Doc fetch timeout', _defaultTimeout),
        );
      }

      if (response.statusCode == 200) {
        String data = response.body;
        return data;
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching Google Doc content: $e');
    }

    return "";
  }
}
