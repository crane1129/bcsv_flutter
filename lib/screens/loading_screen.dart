import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //bindEndpoints 작업이 마치면 그 안에서 메인페이지로 이동함.
    ApiEndpoint.bindEndpoints(context);

    _initPackageInfo();

    //스크린에 위젯 바인딩이 모두 끝나고나서 세팅을 로드해야 정상으로 반영됨.
    WidgetsBinding.instance!.addPostFrameCallback((context) {
      loadSettings();
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      PackageInformation.packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300),
            Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                Text('Bridgeway', style: kTitleTextStyle),
                ]),
            Text('Baptist Church', style: kSubTitleTextStyle),
            SizedBox(height: 50),
            SpinKitFadingCube(
              color: Colors.white,
              size: 100.0,
            ),
          ],
        ),
      ),
    );
  }

  void loadSettings() {
    //언어옵션 Default: Korean
    String languageOption = UserSharedPreferences.getLanguageOption() ?? 'ko';
    String announcement = UserSharedPreferences.getAnnouncementContent() ?? '';

    print('Language: $languageOption');
    print('Announcement: $announcement');

    //Settings
    UserSharedPreferences.setAnnouncementContent('');
  }
}
