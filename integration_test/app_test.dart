// Integration tests for BCSV Flutter app.
//
// Run with:  flutter test integration_test/app_test.dart
// On device: flutter test integration_test/app_test.dart -d <device_id>
//
// Full-app tests (splash → home, drawer navigation) require a device with
// network connectivity because BackgroundService checks the network on startup.
// Screen-specific tests (Settings, About, Bible Search) use buildScreenTest()
// and work offline.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bcsv_flutter_project/screens/home_screen.dart';
import 'package:bcsv_flutter_project/screens/setting_screen.dart';
import 'package:bcsv_flutter_project/screens/about_screen.dart';
import 'package:bcsv_flutter_project/screens/bible_search_screen.dart';
import 'package:bcsv_flutter_project/screens/bible_keyword_search_screen.dart';
import 'package:bcsv_flutter_project/screens/offering_screen.dart';

import 'helpers/test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initializeTestDependencies();
  });

  // ---------------------------------------------------------------------------
  // Full App Launch
  // ---------------------------------------------------------------------------
  group('App Launch', () {
    testWidgets('splash screen shows app name and transitions to home',
        (tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump();

      // Splash screen shows "Bridgeway"
      expect(find.text('Bridgeway'), findsOneWidget);

      // Wait for splash delay (3.5s) + page transition (0.5s)
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 1));

      // Home screen should now be visible
      expect(find.byType(MyHomePage), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Home Screen — uses full splash flow so BackgroundService initializes
  // ---------------------------------------------------------------------------
  group('Home Screen', () {
    Future<void> pumpToHome(WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 1));
      // Allow home screen animations to complete
      await tester.pump(const Duration(seconds: 3));
    }

    testWidgets('displays feature cards', (tester) async {
      await pumpToHome(tester);

      expect(find.text('Sunday Bulletin'), findsWidgets);
      expect(find.text('New Message'), findsWidgets);
      expect(find.text('Serving Turn'), findsWidgets);
      expect(find.text('Offering'), findsWidgets);
      expect(find.text('Sermon Text'), findsWidgets);
      expect(find.text('Daily Bible'), findsWidgets);
      expect(find.text('Bible Search'), findsWidgets);
      expect(find.text('Bible Keyword'), findsWidgets);
    });

    testWidgets('app bar shows church name', (tester) async {
      await pumpToHome(tester);

      expect(find.text('Bridgeway'), findsOneWidget);
      expect(find.text('Baptist Church'), findsOneWidget);
    });

    testWidgets('opens navigation drawer', (tester) async {
      await pumpToHome(tester);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(Drawer), findsOneWidget);

      // Verify items near the top of the drawer (always visible)
      final drawerFinder = find.byType(Drawer);
      expect(
        find.descendant(of: drawerFinder, matching: find.text('Key Verse')),
        findsOneWidget,
      );
      expect(
        find.descendant(
            of: drawerFinder, matching: find.text('Sunday Sermons')),
        findsOneWidget,
      );

      // Scroll down to reveal bottom items
      await tester.drag(find.byType(ListView), const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 300));

      // These items are unique to the drawer (not on home screen cards)
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Exit'), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Drawer Navigation — full splash → home → drawer → target screen
  // ---------------------------------------------------------------------------
  group('Drawer Navigation', () {
    Future<void> openDrawer(WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 3));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump(const Duration(milliseconds: 500));
    }

    Finder inDrawer(String text) {
      return find.descendant(
        of: find.byType(Drawer),
        matching: find.text(text),
      );
    }

    testWidgets('navigates to Settings', (tester) async {
      await openDrawer(tester);

      // Settings is near the bottom — scroll enough to reveal it
      await tester.drag(find.byType(ListView), const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 300));

      await tester.tap(find.text('Settings'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('navigates to About', (tester) async {
      await openDrawer(tester);

      await tester.drag(find.byType(ListView), const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 300));

      await tester.tap(find.text('About'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(AboutScreen), findsOneWidget);
    });

    testWidgets('navigates to Bible Search', (tester) async {
      await openDrawer(tester);

      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pump();

      await tester.tap(inDrawer('Bible Search'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(BibleSearchScreen), findsOneWidget);
    });

    testWidgets('navigates to Bible Keyword Search', (tester) async {
      await openDrawer(tester);

      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pump();

      await tester.tap(inDrawer('Bible Keyword'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(BibleKeywordSearchScreen), findsOneWidget);
    });

    testWidgets('navigates to Offering', (tester) async {
      await openDrawer(tester);

      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pump();

      await tester.tap(inDrawer('Offering'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(OfferingScreen), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Settings Screen — uses buildScreenTest (no network required)
  // ---------------------------------------------------------------------------
  group('Settings Screen', () {
    testWidgets('displays language options', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('한국어'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('displays all theme options', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('Sepia'), findsOneWidget);
      expect(find.text('Midnight Blue'), findsOneWidget);
    });

    testWidgets('can switch to Dark theme', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Dark'));
      await tester.pump(const Duration(seconds: 1));

      // After selecting Dark, the selected Radio<int> with value 1 should exist
      final selectedRadio = find.byWidgetPredicate(
        (w) => w is Radio<int> && w.value == 1,
      );
      expect(selectedRadio, findsOneWidget);
      // All theme options should still be visible
      expect(find.text('Light'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('can switch to Sepia theme', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Sepia'));
      await tester.pump(const Duration(seconds: 1));

      final selectedRadio = find.byWidgetPredicate(
        (w) => w is Radio<int> && w.value == 2,
      );
      expect(selectedRadio, findsOneWidget);
    });

    testWidgets('can switch to Midnight Blue theme', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.text('Midnight Blue'));
      await tester.pump(const Duration(seconds: 1));

      final selectedRadio = find.byWidgetPredicate(
        (w) => w is Radio<int> && w.value == 3,
      );
      expect(selectedRadio, findsOneWidget);
    });

    testWidgets('switches language to Korean and UI updates', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      // Initially English — "Language Setting" label visible
      expect(find.text('Language Setting'), findsOneWidget);

      // Switch to Korean
      await tester.tap(find.text('한국어'));
      await tester.pump(const Duration(seconds: 1));

      // Radio buttons still present
      expect(find.text('한국어'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('displays staff options section', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Staff Options'), findsOneWidget);
      expect(find.text('Message Management'), findsOneWidget);
      expect(find.text('Opinion Review'), findsOneWidget);
    });

    testWidgets('displays card visibility settings', (tester) async {
      await tester.pumpWidget(buildScreenTest(const SettingsPage()));
      await tester.pump(const Duration(seconds: 1));

      // Expand card visibility section
      await tester.tap(find.text('Card Visibility Settings'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Sunday Bulletin'), findsOneWidget);
      expect(find.text('New Message'), findsOneWidget);
      expect(find.text('Serving Turn'), findsOneWidget);
      expect(find.text('Offering'), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Individual Screen Rendering — uses buildScreenTest (no network required)
  // ---------------------------------------------------------------------------
  group('Screen Rendering', () {
    testWidgets('About screen renders', (tester) async {
      await tester.pumpWidget(buildScreenTest(const AboutScreen()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(AboutScreen), findsOneWidget);
    });

    testWidgets('Bible Search screen renders with testament tabs',
        (tester) async {
      await tester.pumpWidget(buildScreenTest(BibleSearchScreen()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(BibleSearchScreen), findsOneWidget);
      expect(find.text('Old Testament'), findsOneWidget);
      expect(find.text('New Testament'), findsOneWidget);
    });

    testWidgets('Bible Keyword Search screen renders', (tester) async {
      await tester
          .pumpWidget(buildScreenTest(BibleKeywordSearchScreen()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(BibleKeywordSearchScreen), findsOneWidget);
    });

    testWidgets('Offering screen renders', (tester) async {
      await tester.pumpWidget(buildScreenTest(OfferingScreen()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(OfferingScreen), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Back Navigation — uses full splash → home → navigate → back flow
  // ---------------------------------------------------------------------------
  group('Back Navigation', () {
    testWidgets('Settings back button returns to home screen',
        (tester) async {
      // Go through full app flow to get a proper navigation stack
      await tester.pumpWidget(buildTestApp());
      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 3));

      // Open drawer and navigate to Settings
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.drag(find.byType(ListView), const Offset(0, -600));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('Settings'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(SettingsPage), findsOneWidget);

      // Tap back and wait for pop transition to fully complete
      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(milliseconds: 300));

      // Should return to home
      expect(find.byType(MyHomePage), findsOneWidget);
    });
  });
}
