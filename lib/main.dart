import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/screens/loading_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  kNotificationDuration = const Duration(milliseconds: 2000);
  kNotificationSlideDuration = const Duration(milliseconds: 500);
  await UserSharedPreferences.init();

  runApp(MyBCSVApp());
}

class MyBCSVApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.fallback().copyWith(
            scaffoldBackgroundColor: kMainThemeColor,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
          ),
          home: const LoadingScreen(),
        ),
      );
  }
}
