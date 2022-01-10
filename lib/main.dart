import 'package:bcsv_flutter_project/screens/loading_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ko']);

  await UserSharedPreferences.init();
  runApp(MyBCSVApp());
}

class MyBCSVApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kMainAppBarColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
        ),
        home: const LoadingScreen(),
      ),
    );
  }
}

