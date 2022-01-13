import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/screens/home_screen.dart';

const String kEndpointAPI =
    "https://script.google.com/macros/s/AKfycbwW_u3urSmxnQrIFsPxwVVzvbNnAtscBZGvxcRfYzJXuLQEWMNB/exec";

class ApiEndpoint {
  static var apiMap = {};

  static void bindEndpoints(BuildContext context) async {
    try {
      String endpointList = await _getApiEndpoints();
      var jsonObj = jsonDecode(endpointList)['endpoints'] as List;
      List<Endpoint> endpointObjs =
          jsonObj.map((tagJson) => Endpoint.fromJson(tagJson)).toList();

      for (Endpoint e in endpointObjs) {
        apiMap[e.endpoint] = e.url;
      }

      print('Endpoint bind is complete');

      //Navigate to Home screen and destroy the loading screen.
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        },
      ), (e) => false);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String> _getApiEndpoints() async {
    http.Response response = await http.get(Uri.parse(kEndpointAPI));

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }

    return "";
  }
}
