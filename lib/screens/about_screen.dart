import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'About', text2: 'app information'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _infoTile('App name', PackageInformation.packageInfo.appName),
              _infoTile(
                  'Package name', PackageInformation.packageInfo.packageName),
              _infoTile('App version', PackageInformation.packageInfo.version),
              _infoTile(
                  'Build number', PackageInformation.packageInfo.buildNumber),
              _infoTile('Build signature',
                  PackageInformation.packageInfo.buildSignature),
              _infoTile('Developer',
                  'Haksoo Kim, Daniel Kim'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: kBodyTextStyle),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }
}
