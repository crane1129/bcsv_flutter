# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BCSV Flutter is a mobile app for Bridgeway Baptist Church with Korean/English localization support. It provides church-related features like announcements, Bible search, offering information, and serving schedules.

## Build Commands

```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Build for iOS (without codesigning for debug)
flutter build ios --debug --no-codesign

# Build for Android
flutter build apk

# Run tests
flutter test

# Run single test file
flutter test test/widget_test.dart

# Analyze code for issues
flutter analyze

# Clean build artifacts (useful for resolving build errors)
flutter clean && flutter pub get

# Generate app icons (after updating assets/images/app.png)
flutter pub run flutter_launcher_icons
```

## Architecture

### State Management
- **Provider** pattern with `ThemeNotifier` and `LocaleProvider` for global state
- `SharedPreferences` via `UserSharedPreferences` class for persistent storage
- Local state uses standard `setState()` in StatefulWidgets

### Key Entry Points
- `lib/main.dart` - App initialization, theme setup, localization configuration
- `lib/screens/home_screen.dart` - Main dashboard with feature navigation
- `lib/screens/splash_screen.dart` - Initial loading screen

### Service Layer (lib/services/)
- `background_service.dart` - Singleton for heavy initialization (Google Sheets, APIs)
- `api_endpoint.dart` - HTTP communication with timeouts
- `gsheet_access.dart` - Google Sheets integration
- `api_data_fetch.dart` - Google Docs content fetching

Services use the singleton pattern and `Future.wait()` for parallel operations.

### Directory Structure
- `lib/screens/` - Screen widgets (named `*_screen.dart`)
- `lib/components/` - Reusable UI components
- `lib/services/` - Business logic and API calls
- `lib/utilities/` - Constants, themes, shared preferences
- `lib/l10n/` - Localization files (app_ko.arb, app_en.arb)
- `lib/data_models/` - Data structures

## Internationalization

**All user-facing text must use localization:**
```dart
AppLocalizations.of(context)!.keyName
```

Add new strings to both `lib/l10n/app_ko.arb` (Korean) and `lib/l10n/app_en.arb` (English). Never hardcode Korean or English text.

## Theming

Always use theme colors instead of hardcoded values:
```dart
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
Theme.of(context).textTheme.bodyMedium
```

Custom fonts available: Dongle, Sunflower, PoorStory, SingleDay

## Logging Convention

Use `dart:developer` log with emoji prefixes:
```dart
log('✅ Success message');
log('❌ Error message: $e');
log('🔄 Loading...');
log('⚠️ Warning message');
```

## Common Build Fixes

- **Gradle/Android errors**: `flutter clean && flutter pub get`
- **iOS storyboard errors**: iOS launch screens cannot contain user-defined runtime attributes
- **Package conflicts**: Check `pubspec.lock` for version conflicts
