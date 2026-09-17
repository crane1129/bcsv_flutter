import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bcsv_flutter_project/screens/home_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/l10n/l10n.dart';
import 'package:bcsv_flutter_project/utilities/locale_provider.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:flutter_animate/flutter_animate.dart';

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
    _initPackageInfo();
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
            SizedBox(height: 250),
            Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.bridgeway,
                          style: kMainTitleTextStyle(context))
                      .animate()
                      .fadeIn() // uses `Animate.defaultDuration`
                      .scale() // inherits duration from fadeIn
                      .move(delay: 300.ms, duration: 600.ms),
                ]),
            SizedBox(height: 50),
            Text(AppLocalizations.of(context)!.baptistChurch,
                    style: kSubTitleTextStyle(context))
                .animate()
                .fadeIn(duration: 1000.ms)
                .slideY(end: -1),
            SizedBox(height: 50),
            SpinKitFadingCube(
              color: Theme.of(context).colorScheme.onSurface,
              size: 100.0,
            ),
            SizedBox(height: 50),
            Text(
                PackageInformation.packageInfo.version +
                    " (${PackageInformation.packageInfo.buildNumber})",
                style: kListTitleStyleWhite(context)),
          ],
        ),
      ),
    );
  }

  void loadSettings() async {
    //언어옵션 Default: 기기 시스템 언어가 지원되면 그 언어, 아니면 한국어
    final systemLanguageCode =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final supportedLanguageCodes = L10n.all.map((locale) => locale.languageCode);
    final defaultLanguageOption = supportedLanguageCodes.contains(systemLanguageCode)
        ? systemLanguageCode
        : 'ko';
    String languageOption =
        UserSharedPreferences.getLanguageOption() ?? defaultLanguageOption;
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(Locale.fromSubtags(languageCode: languageOption));
    log('Language: $languageOption');
  }

  void checkNetworkConnection() async {
    bool hasInternet =
        await await InternetConnectionChecker.instance.hasConnection;
    String message = hasInternet ? 'Internet' : 'No Internet';

    if (!hasInternet) {
      showSimpleNotification(
          Text(
            "$message connection. Please check the network connection.",
          ),
          leading: Icon(Icons.network_check),
          background: Colors.red,
          elevation: 5);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DisconnectScreen(),
        ),
      );
    } else {
      //스크린에 위젯 바인딩이 모두 끝나고나서 세팅을 로드해야 정상으로 반영됨.
      WidgetsBinding.instance.addPostFrameCallback(
        (context) {
          loadSettings();
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MyHomePage(),
        ),
      );
    }
  }
}
