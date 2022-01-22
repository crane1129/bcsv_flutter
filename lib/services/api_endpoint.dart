import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/screens/home_screen.dart';

const String kEndpointAPI =
    "https://script.google.com/macros/s/AKfycbwW_u3urSmxnQrIFsPxwVVzvbNnAtscBZGvxcRfYzJXuLQEWMNB/exec";

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

      print('Endpoint bind is complete');
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
}
