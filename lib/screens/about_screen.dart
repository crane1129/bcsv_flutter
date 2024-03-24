import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final String this_year = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: 'About',
            text2: AppLocalizations.of(context)!.appInformation),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName:
                    Text(AppLocalizations.of(context)!.missionStatement),
                accountEmail: Text(AppLocalizations.of(context)!.missionVerse,
                    style: TextStyle(fontSize: 10)),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: kActiveCardColor,
                  backgroundImage: AssetImage('assets/images/app.png'),
                ),
                decoration: BoxDecoration(
                    color: kMainAppBarColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/mountain1.jpg'),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height: 20.0),
              _infoTile('App name', PackageInformation.packageInfo.appName),
              _infoTile(
                  'Package name', PackageInformation.packageInfo.packageName),
              _infoTile('App version', PackageInformation.packageInfo.version),
              _infoTile(
                  'Build number', PackageInformation.packageInfo.buildNumber),
              // _infoTile('Build signature',
              //     PackageInformation.packageInfo.buildSignature),
              _infoTile('Developer',
                  'Daniel Kim (dankim0822@gmail.com)\nHaksoo Kim(crane1129@gmail.com)'),
              _infoTile('\n© ' + this_year + ' Bridgeway Baptist Church',
                  '     2490 Middlefield. Palo Alto, CA 94301'),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: kBodyTextStyle, textAlign: TextAlign.center),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle,
          style: kBodyTextSmallStyle, textAlign: TextAlign.center,),
    );
  }
}
