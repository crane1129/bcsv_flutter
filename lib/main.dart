import 'package:bcsv_flutter_project/utilities/locale_provider.dart';
import 'package:bcsv_flutter_project/utilities/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/screens/splash_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/services.dart';
import 'package:bcsv_flutter_project/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  kNotificationDuration = const Duration(milliseconds: 2000);
  kNotificationSlideDuration = const Duration(milliseconds: 500);
  await UserSharedPreferences.init();

  // Initialize package info immediately (lightweight)
  try {
    final info = await PackageInfo.fromPlatform();
    PackageInformation.packageInfo = info;
    log('✅ Package info loaded in main()');
  } catch (e) {
    log('❌ Error loading package info: $e');
  }

  // Load saved theme setting
  int themeIndex = await UserSharedPreferences.getAppThemeSetting() ?? 0;
  ThemeData initialTheme = ThemeNotifier.getThemeByIndex(themeIndex);

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(initialTheme, themeIndex),
      child: MyBCSVApp(),
    ),
  );
}

class MyBCSVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return OverlaySupport.global(
          child: MaterialApp(
            color: Theme.of(context).colorScheme.surface,
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.currentTheme,
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
