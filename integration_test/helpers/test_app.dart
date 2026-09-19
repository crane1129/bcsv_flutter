import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:bcsv_flutter_project/l10n/l10n.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/presentation/providers/theme_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/locale_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/keyverse_provider.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/core/storage/local_storage.dart';
import 'package:bcsv_flutter_project/utilities/package_information.dart';
import 'package:bcsv_flutter_project/screens/splash_screen.dart';

import 'mock_repositories.dart';

/// Initialize platform dependencies for integration tests.
/// Call once in setUpAll before any test runs.
Future<void> initializeTestDependencies() async {
  await UserSharedPreferences.init();
  await LocalStorage.init();
  try {
    PackageInformation.packageInfo = await PackageInfo.fromPlatform();
  } catch (_) {
    // PackageInfo may not be available in all test environments
  }
}

/// Build the full test app starting from [startScreen] (defaults to SplashScreen).
///
/// Riverpod providers for repositories are overridden with fakes so tests
/// don't depend on network. Each call creates fresh fake instances.
Widget buildTestApp({Widget? startScreen}) {
  return ProviderScope(
    overrides: [
      keyVerseRepositoryProvider.overrideWithValue(FakeKeyVerseRepository()),
      messageRepositoryProvider.overrideWithValue(FakeMessageRepository()),
      settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
    ],
    child: _TestApp(startScreen: startScreen),
  );
}

/// Build a minimal test harness for an individual screen.
///
/// Wraps [screen] in MaterialApp with localization and Riverpod but
/// without HomeScreen's BackgroundService initialization, so these tests
/// don't require network connectivity.
Widget buildScreenTest(Widget screen) {
  return ProviderScope(
    overrides: [
      keyVerseRepositoryProvider.overrideWithValue(FakeKeyVerseRepository()),
      messageRepositoryProvider.overrideWithValue(FakeMessageRepository()),
      settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
    ],
    child: _ScreenTestWrapper(screen: screen),
  );
}

class _TestApp extends ConsumerStatefulWidget {
  final Widget? startScreen;
  const _TestApp({this.startScreen});

  @override
  ConsumerState<_TestApp> createState() => _TestAppState();
}

class _TestAppState extends ConsumerState<_TestApp> {
  @override
  void initState() {
    super.initState();
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
        home: widget.startScreen ?? const SplashScreen(),
      ),
    );
  }
}

class _ScreenTestWrapper extends ConsumerStatefulWidget {
  final Widget screen;
  const _ScreenTestWrapper({required this.screen});

  @override
  ConsumerState<_ScreenTestWrapper> createState() =>
      _ScreenTestWrapperState();
}

class _ScreenTestWrapperState extends ConsumerState<_ScreenTestWrapper> {
  @override
  void initState() {
    super.initState();
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
        home: widget.screen,
      ),
    );
  }
}
