import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

import '../services/api_endpoint.dart';

Future<void> checkForUpdate(BuildContext context) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  try {
    final response = await http.get(ApiEndpoint.apiMap['APP_VERSION']);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final latestVersion = Platform.isAndroid ? data['android'] : data['ios'];

      if (_isNewVersionAvailable(currentVersion, latestVersion)) {
        _showUpdateDialog(context, latestVersion);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You have the latest version.'),
        ));
      }
    }
  } catch (e) {
    print("Error checking version: $e");
  }
}

bool _isNewVersionAvailable(String current, String latest) {
  final currentParts = current.split('.').map(int.parse).toList();
  final latestParts = latest.split('.').map(int.parse).toList();

  for (int i = 0; i < latestParts.length; i++) {
    if (i >= currentParts.length || latestParts[i] > currentParts[i]) return true;
    if (latestParts[i] < currentParts[i]) return false;
  }
  return false;
}

void _showUpdateDialog(BuildContext context, String latestVersion) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Update Available"),
      content: Text("A new version ($latestVersion) is available. Please update your app."),
      actions: [
        TextButton(
          child: Text("Update"),
          onPressed: () async{
            final url = Platform.isAndroid
                ? "https://play.google.com/store/apps/details?id=com.bcsv.mobile"
                : "https://apps.apple.com/us/app/bridgeway-palo-alto/id1479258458";

            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Unable to open the App Store."),
              ));
            }
          },
        ),
        TextButton(
          child: Text("Later"),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
