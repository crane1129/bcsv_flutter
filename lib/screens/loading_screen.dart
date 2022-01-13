import 'package:overlay_support/overlay_support.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:flutter_locales/flutter_locales.dart';


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
    checkNetworkConnection();
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

  void loadSettings() async {
    //언어옵션 Default: Korean
    String languageOption = UserSharedPreferences.getLanguageOption() ?? 'ko';
    print('Language: $languageOption');

    //Settings
    UserSharedPreferences.setAnnouncementCache(false);
    UserSharedPreferences.setBibleReviewCache(false);
    UserSharedPreferences.setBibleTextCache(false);
    UserSharedPreferences.setServingTurnCache(false);
    UserSharedPreferences.setDailyBibleText1Cache(false);
    UserSharedPreferences.setDailyBibleText2Cache(false);
  }

  void checkNetworkConnection() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    String message = hasInternet ? 'Internet' : 'No Internet';

    if (!hasInternet) {
      showSimpleNotification(
          LocaleText(
            "$message connection. Please check the network connection.",
          ),
          leading: Icon(Icons.network_check),
          background: Colors.red);
    }else{
      //bindEndpoints 작업을 마치면 bindEndpoints 안에서 메인페이지로 이동함.
      ApiEndpoint.bindEndpoints(context);

      _initPackageInfo();

      //스크린에 위젯 바인딩이 모두 끝나고나서 세팅을 로드해야 정상으로 반영됨.
      WidgetsBinding.instance!.addPostFrameCallback((context) {
        loadSettings();
      });
    }
  }
}
