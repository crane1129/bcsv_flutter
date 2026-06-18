import 'package:bcsv_flutter_project/core/storage/local_storage.dart';
import 'package:bcsv_flutter_project/core/storage/credential_migration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/screens/splash_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/services.dart';
import 'package:bcsv_flutter_project/l10n/l10n.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/locale_provider.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  kNotificationDuration = const Duration(milliseconds: 2000);
  kNotificationSlideDuration = const Duration(milliseconds: 500);

  // Initialize storage systems
  await UserSharedPreferences.init();
  await LocalStorage.init();

  // Migrate credentials to secure storage (one-time operation)
  await CredentialMigration.migrateIfNeeded();

  // Initialize package info immediately (lightweight)
  try {
    final info = await PackageInfo.fromPlatform();
    PackageInformation.packageInfo = info;
    log('Package info loaded in main()');
  } catch (e) {
    log('Error loading package info: $e');
  }

  runApp(
    // ProviderScope for Riverpod state management
    const ProviderScope(
      child: MyBCSVApp(),
    ),
  );
}

class MyBCSVApp extends ConsumerStatefulWidget {
  const MyBCSVApp({super.key});

  @override
  ConsumerState<MyBCSVApp> createState() => _MyBCSVAppState();
}

class _MyBCSVAppState extends ConsumerState<MyBCSVApp> {
  @override
  void initState() {
    super.initState();
    // Initialize theme and locale from persisted settings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(themeNotifierProvider.notifier).initialize();
      ref.read(localeNotifierProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeDataProvider);
    final locale = ref.watch(localeProvider);

    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        locale: locale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashScreen(),
      ),
    );
  }
}
