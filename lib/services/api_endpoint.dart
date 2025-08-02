import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';

class ApiEndpoint {
  static final ApiEndpoint _instance = ApiEndpoint._internal();
  factory ApiEndpoint() => _instance;
  ApiEndpoint._internal();

  static final Map<String, Uri> apiMap = {};
  
  // Timeout configuration
  static const Duration _defaultTimeout = Duration(seconds: 10);
  static const Duration _messageTimeout = Duration(seconds: 15);

  Future<bool> bindEndpoints() async {
    try {
      final data = await fetchEndpoints(); // your HTTP call

      List<Endpoint> endpointObjs =
      data.map((e) => Endpoint.fromJson(e)).toList();

      for (Endpoint e in endpointObjs) {
        apiMap[e.endpoint] = Uri.parse(e.url);
      }

      print('✅ Endpoint bind is complete');
      return true;
    } catch (e) {
      print("❌ bindEndpoints error: $e");
      return false;
    }
  }

  Uri? get(String key) => apiMap[key];

  Future<List<Map<String, dynamic>>> fetchEndpoints() async {
    final uri = Uri.https('www.bridgeway.online', '/_functions/endpoints');

    try {
      final response = await http.get(uri).timeout(
        _defaultTimeout,
        onTimeout: () => throw TimeoutException('Endpoint fetch timeout', _defaultTimeout),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> items = json['results'];
        return items.cast<Map<String, dynamic>>();
      } else {
        throw Exception("Failed to load endpoints: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error fetching endpoints: $e");
      return [];
    }
  }

  Future<void> checkNewMessage() async {
    try {
      // Get messages from the google doc
      http.Response response = await http.get(apiMap['MESSAGE']!).timeout(
        _messageTimeout,
        onTimeout: () => throw TimeoutException('Message fetch timeout', _messageTimeout),
      );
      
      var dir = await getTemporaryDirectory();
      File file = File("${dir.path}/${kPrayerListData}");

      int messageCounter = 0;

      if (response.statusCode == 200) {
        var new_msg_id = <String>[];
        var downloadedJsonObjMsg = jsonDecode(response.body) as List;
        var storedJsonObjMsg = <dynamic>[];

        try {
          storedJsonObjMsg = jsonDecode(file.readAsStringSync()) as List;
        } on Exception {
          stdout.writeln("File not found: ${file}");
        }

        var messages = jsonDecode(response.body) as List;
        if (storedJsonObjMsg.length > 0) {
          // Optimize: Use Set for faster lookups instead of List.contains
          var messageIdSet = <String>{};
          var messageIdWithViewStatus = <String, bool>{};
          
          for (dynamic message in storedJsonObjMsg) {
            final messageId = message['MessageID'] as String;
            messageIdSet.add(messageId);
            messageIdWithViewStatus[messageId] = message['viewed'] ?? false;
          }

          for (dynamic message in downloadedJsonObjMsg) {
            final messageId = message['MessageID'] as String;
            if (!messageIdSet.contains(messageId)) {
              // New message
              new_msg_id.add(messageId);
              messageCounter++;
            } else {
              // Existing message, check if viewed
              if (messageIdWithViewStatus[messageId] == false) {
                new_msg_id.add(messageId);
                messageCounter++;
              }
            }
          }

          UserSharedPreferences.setMessageListCounter(messageCounter);

          //Add 'viewed' element in message and save data to cache
          for (var i = 0; i < messages.length; i++) {
            final messageId = messages[i]['MessageID'] as String;
            messages[i]['viewed'] = !new_msg_id.contains(messageId);
          }
        } else {
          // This block is executed at the first time
          // when the app is installed and launched.
          UserSharedPreferences.setMessageListCounter(messages.length);
          for (var i = 0; i < messages.length; i++) {
              messages[i]['viewed'] = false;
          }
        }

        await file.writeAsString(jsonEncode(messages), flush: true, mode: FileMode.write);
        UserSharedPreferences.setMessageListTextCache(true);
        stdout.writeln("Message stored.");
      } else {
        stdout.writeln(response.statusCode);
      }
    } catch (e) {
      print("❌ Error checking messages: $e");
      // Don't block app startup if message check fails
    }
  }
}
