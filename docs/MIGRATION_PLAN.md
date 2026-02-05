# BCSV Flutter App: Complete Rewrite Plan

## Overview
Incremental rewrite from Provider to Riverpod with UI redesign and offline support.
App remains functional throughout migration.

## Session Status
**Last Updated:** 2026-02-04
**Next Phase:** Phase 5 - Bible Features
**Resume Command:** `flutter test` to verify state (30 tests), then continue with Phase 5

### Recent Fixes (2026-02-04)

#### Fix 1: Announcement Screen Network Errors
**Issue:** Announcement screen showing network error popups on iOS simulator
**Solution:** Migrated `announcement_screen.dart` to use new `announcementNotifierProvider` with offline support
**Changes:**
- Changed from StatefulWidget to ConsumerStatefulWidget
- Removed legacy API calls (getAnnouncementFromGoogleSheet)
- Added proper loading/error/empty states using Riverpod
- Added offline indicator (cloud icon) in app bar when using cached data
- Added pull-to-refresh functionality

#### Fix 2: Message List Screen File Not Found Error
**Issue:** Message list screen crashing with `PathNotFoundException` when cache file doesn't exist
```
Cannot open file, path = '.../message_list.json' (OS Error: No such file or directory, errno = 2)
```
**Solution:** Migrated `message_list.dart` to use new `messageNotifierProvider` with proper offline/error handling
**Changes:**
- Changed from StatefulWidget to ConsumerStatefulWidget
- Removed legacy API calls (getMessageListFromGoogleSheet)
- Removed manual file operations (now handled by repository)
- Uses `markAllAsRead()` method instead of manual counter reset
- Added proper loading/error/empty states using Riverpod
- Added offline indicator and pull-to-refresh
- Better error handling with fallback to default images

**Verification:** All 30 tests passing, both screens work properly on simulator with proper offline support

#### Fix 3: Message Remote Datasource Parsing Error
**Issue:** Type error when fetching messages: `type 'String' is not a subtype of type 'int' of 'index'`
**Root Cause:** Message API returns a direct JSON array, but remote datasource was expecting an object with 'messages' key
**Solution:** Updated `message_remote_datasource.dart` to parse direct JSON array format
**Changes:**
- Changed parsing from `jsonData['messages']` to direct array parsing
- Added type checking for response format
- Matches the format used by legacy `ApiEndpoint.checkNewMessage()` method

**Note:** If you still see the Announcement endpoint URL in message logs, the MESSAGE endpoint may not be configured correctly in the backend. Check that the endpoint returns the correct URL for messages.

#### Fix 4: Incorrect Offline Indicator on Both Screens
**Issue:** Both announcement and message list screens showing cloud icon (offline indicator) even when data fetched successfully from network
**Root Cause:** Provider logic incorrectly determined offline status based on `!forceRefresh && hasCached` instead of checking actual data source
**Solution:** Added `wasLastFetchFromCache()` method to repositories to track actual data source
**Changes:**
- Added `wasLastFetchFromCache()` to repository interfaces
- Added `_lastFetchWasFromCache` tracking field to repository implementations
- Updated repositories to set flag based on actual fetch path (network vs cache)
- Updated providers to use `wasLastFetchFromCache()` instead of incorrect logic
- Offline indicator now only shows when actually using cached data

**Result:** Offline indicator now correctly shows only when data comes from cache due to network failure or offline mode, not just because cache exists.

---

## Fix: Stale IDE Analysis for "Undefined name 'globals'"

### Issue
IDE shows "Undefined name 'globals'" error, but the codebase is clean:
- `flutter analyze` passes with no errors
- `flutter build apk` succeeds
- No `globals` references exist in codebase
- `globals.dart` was deleted in Phase 4 migration

### Solution
Refresh IDE analysis cache:
```bash
flutter clean && flutter pub get
```
Then restart IDE or reload the project window.

### Verification
After running above commands, the error should disappear.

---

## Progress Tracking

| Phase | Status | Completed Date | Notes |
|-------|--------|----------------|-------|
| Phase 0: Foundation & Security | ✅ COMPLETE | 2026-02-03 | SDK updated, credentials secured, core infra created |
| Phase 1: Settings & Theme Migration | ✅ COMPLETE | 2026-02-03 | Riverpod providers created, tests passing |
| Phase 2: Offline Infrastructure | ✅ COMPLETE | 2026-02-04 | Connectivity provider, cache reset removed |
| Phase 3: Announcement Feature | ✅ COMPLETE | 2026-02-04 | Domain/data layers, Riverpod provider, 16 tests passing |
| Phase 4: Messages & Serving Turn | ✅ COMPLETE | 2026-02-04 | Message/ServingTurn entities, providers, globals.dart deleted, 30 tests passing |
| Phase 5: Bible Features | 🔲 Not Started | - | - |
| Phase 6: UI Redesign | 🔲 Not Started | - | - |
| Phase 7: Cleanup | 🔲 Not Started | - | - |
| Phase 8: Advanced Offline | 🔲 Not Started | - | - |

### Phase 0 Completed Items:
- [x] Updated SDK to `>=3.0.0 <4.0.0`
- [x] Added Riverpod, Freezed, connectivity_plus, flutter_secure_storage
- [x] Created `lib/core/` infrastructure (config, error, network, storage)
- [x] Extracted hardcoded credentials to secure storage
- [x] Added ProviderScope wrapper to main.dart
- [x] Fixed widget_test.dart with working tests
- [x] Verified: `flutter analyze` (no errors), `flutter test` (3 passing), `flutter build apk` (success)

### Phase 1 Completed Items:
- [x] Create theme_provider.dart (Riverpod) - `lib/presentation/providers/theme_provider.dart`
- [x] Create locale_provider.dart (Riverpod) - `lib/presentation/providers/locale_provider.dart`
- [x] Create settings repository interface - `lib/domain/repositories/settings_repository.dart`
- [x] Create settings repository implementation - `lib/data/repositories/settings_repository_impl.dart`
- [x] Add tests for Riverpod providers (6 tests passing)
- [ ] Create settings_screen_v2.dart (deferred to later - existing UI works with new providers)
- [x] Verified: `flutter analyze` (no errors), `flutter test` (6 passing)

### Phase 2 Completed Items:
- [x] Create connectivity provider - `lib/presentation/providers/connectivity_provider.dart`
- [x] Remove cache reset on launch in `background_service.dart` (lines 368-377)
- [x] Add intelligent cache validation methods (`checkCacheValidity`, `invalidateAllCaches`)
- [x] Add connectivity tests (3 new tests)
- [x] Verified: `flutter analyze` (no errors), `flutter test` (9 passing)

### Phase 3 Completed Items:
- [x] Create AnnouncementEntity with @freezed - `lib/domain/entities/announcement.dart`
- [x] Create AnnouncementModel with JSON serialization - `lib/data/models/announcement_model.dart`
- [x] Create AnnouncementRepository interface - `lib/domain/repositories/announcement_repository.dart`
- [x] Create AnnouncementRemoteDatasource - `lib/data/datasources/remote/announcement_remote_datasource.dart`
- [x] Create AnnouncementLocalDatasource - `lib/data/datasources/local/announcement_local_datasource.dart`
- [x] Create AnnouncementRepositoryImpl with offline support - `lib/data/repositories/announcement_repository_impl.dart`
- [x] Create AnnouncementNotifier and providers - `lib/presentation/providers/announcement_provider.dart`
- [x] Add json_annotation dependency for JSON serialization
- [x] Run build_runner to generate freezed/json files
- [x] Add announcement tests (7 new tests)
- [x] Verified: `flutter analyze` (no errors), `flutter test` (16 passing)

### Phase 4 Completed Items:
- [x] Create MessageEntity with @freezed - `lib/domain/entities/message.dart`
- [x] Create MessageModel with JSON serialization - `lib/data/models/message_model.dart`
- [x] Create MessageRepository interface - `lib/domain/repositories/message_repository.dart`
- [x] Create MessageRemoteDatasource - `lib/data/datasources/remote/message_remote_datasource.dart`
- [x] Create MessageLocalDatasource - `lib/data/datasources/local/message_local_datasource.dart`
- [x] Create MessageRepositoryImpl with offline support - `lib/data/repositories/message_repository_impl.dart`
- [x] Create MessageNotifier and providers (with unread count) - `lib/presentation/providers/message_provider.dart`
- [x] Create ServingTurnEntity with @freezed - `lib/domain/entities/serving_turn.dart`
- [x] Create ServingTurnModel with JSON serialization - `lib/data/models/serving_turn_model.dart`
- [x] Create ServingTurnRepository interface - `lib/domain/repositories/serving_turn_repository.dart`
- [x] Create ServingTurnRemoteDatasource - `lib/data/datasources/remote/serving_turn_remote_datasource.dart`
- [x] Create ServingTurnLocalDatasource - `lib/data/datasources/local/serving_turn_local_datasource.dart`
- [x] Create ServingTurnRepositoryImpl with offline support - `lib/data/repositories/serving_turn_repository_impl.dart`
- [x] Create ServingTurnNotifier and providers - `lib/presentation/providers/serving_turn_provider.dart`
- [x] Delete globals.dart - replaced messageCnt with unreadMessageCountProvider
- [x] Update home_screen.dart, nav_bar.dart, message_list.dart to use local state
- [x] Run build_runner to generate freezed/json files
- [x] Add message and serving turn tests (14 new tests)
- [x] Verified: `flutter analyze` (no errors), `flutter test` (30 passing), `flutter build apk` (success)

---

## Phase 0: Foundation & Security (Week 1) - ✅ COMPLETE

### 0.1 Update SDK & Dependencies
**File:** `pubspec.yaml`

```yaml
environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  freezed_annotation: ^2.4.1
  connectivity_plus: ^5.0.0
  flutter_secure_storage: ^9.0.0
  # Keep existing provider temporarily for gradual migration

dev_dependencies:
  flutter_lints: ^5.0.0
  riverpod_generator: ^2.4.0
  freezed: ^2.4.7
  build_runner: ^2.4.8
```

### 0.2 CRITICAL: Extract Hardcoded Credentials
**File:** `lib/services/gsheet_access.dart` (lines 9-22)

Google service account credentials are hardcoded in source. Extract to:
- `lib/core/storage/secure_storage.dart` - FlutterSecureStorage wrapper
- First-run migration to move credentials

### 0.3 Create Core Infrastructure
```
lib/core/
  config/app_config.dart
  error/app_exception.dart
  network/network_info.dart
  storage/local_storage.dart
  storage/secure_storage.dart
  storage/cache_manager.dart
```

### 0.4 Wrap App with ProviderScope
**File:** `lib/main.dart` - Add ProviderScope around existing Provider setup

**Verification:** `flutter run` works, existing app unchanged

---

## Phase 1: Settings & Theme Migration (Week 2) - ✅ COMPLETE

### 1.1 Create Riverpod Providers
```
lib/presentation/providers/
  theme_provider.dart      # Replace utilities/theme_notifier.dart
  locale_provider.dart     # Replace utilities/locale_provider.dart
  settings_provider.dart   # New unified settings state
```

### 1.2 Create Settings Repository
```
lib/domain/repositories/settings_repository.dart
lib/data/repositories/settings_repository_impl.dart
```

### 1.3 Migrate Settings Screen
- Create `lib/presentation/screens/settings/settings_screen_v2.dart`
- Use ConsumerStatefulWidget
- Keep existing UI, new state management

**Verification:** Theme/language changes persist, both old and new code works

---

## Phase 2: Offline Infrastructure (Week 3) - ✅ COMPLETE

### 2.1 Create Cache Layer
```
lib/core/storage/cache_manager.dart   # Unified cache with TTL
lib/data/datasources/local/           # Local datasource implementations
```

### 2.2 Create Connectivity Provider
**File:** `lib/presentation/providers/connectivity_provider.dart`

### 2.3 CRITICAL: Remove Cache Reset on Launch
**File:** `lib/services/background_service.dart` (lines 369-377)

Remove these lines that reset all caches on every launch:
```dart
// DELETE THESE:
UserSharedPreferences.setAnnouncementCache(false);
UserSharedPreferences.setBibleReviewCache(false);
// ... etc
```

Replace with intelligent cache validation (check timestamps, not binary flags).

**Verification:** App launches with cached data, refreshes when online

---

## Phase 3: Announcement Feature (Week 4) - ✅ COMPLETE

### 3.1 Create Domain Layer
```
lib/domain/entities/announcement.dart           # @freezed
lib/domain/repositories/announcement_repository.dart
```

### 3.2 Create Data Layer
```
lib/data/models/announcement_model.dart         # @freezed with fromJson/toJson
lib/data/datasources/remote/announcement_remote_datasource.dart
lib/data/datasources/local/announcement_local_datasource.dart
lib/data/repositories/announcement_repository_impl.dart
```

### 3.3 Create Provider
**File:** `lib/presentation/providers/announcement_provider.dart`

### 3.4 Create New Screen
**File:** `lib/presentation/screens/announcements/announcement_screen_v2.dart`

### 3.5 Feature Flag
**File:** `lib/core/config/feature_flags.dart` - Toggle old/new screens

**Verification:** New screen identical behavior, offline shows cached data

---

## Phase 4: Messages & Serving Turn (Week 5) - ✅ COMPLETE

### 4.1 Delete Global State
**DELETE:** `lib/globals.dart` (messageCnt global variable)

### 4.2 Create Message Feature
Same pattern as Announcement:
- Domain entities, repository
- Local/remote datasources
- `message_provider.dart` with unread count
- `message_screen_v2.dart`

### 4.3 Create Serving Turn Feature
Same pattern, includes offline support

**Verification:** Home screen badge works, all cards functional

---

## Phase 5: Bible Features (Week 6)

### 5.1 Bible Text Feature
- `BibleTextRepository` with offline caching
- `bibleTextProvider`
- `sunday_bible_text_screen_v2.dart`

### 5.2 Daily Bible Feature
- `DailyBibleRepository`
- `daily_bible_provider.dart`
- `daily_bible_screen_v2.dart`

### 5.3 Key Verse Feature
- Refactor `KeyVerseService` to repository
- `keyverse_provider.dart`
- Update home screen display

**Verification:** All Bible features work online/offline

---

## Phase 6: UI Redesign (Week 7)

### 6.1 Design System
```
lib/presentation/shared/theme/
  app_colors.dart
  app_typography.dart
  app_spacing.dart
  app_theme.dart
```

### 6.2 Shared Widgets
```
lib/presentation/shared/widgets/
  app_card.dart           # Unified card (replace 3 ReusableCard variants)
  loading_shimmer.dart    # Replace SpinKitFadingCube
  empty_state.dart        # Consistent empty states
  error_state.dart        # Consistent error handling
  offline_banner.dart     # Network status indicator
```

### 6.3 Apply to All Screens
- Consistent loading/error/empty states
- Consistent animations
- Improved accessibility

**Verification:** All screens consistent, performant animations

---

## Phase 7: Cleanup (Week 8)

### 7.1 Remove Provider Package
**File:** `pubspec.yaml` - Remove `provider: ^6.1.5`

### 7.2 Delete Legacy Files
```
DELETE:
  lib/utilities/theme_notifier.dart
  lib/utilities/locale_provider.dart
  lib/globals.dart (already deleted in Phase 4)
  lib/services/background_service.dart
  lib/services/api_endpoint.dart (static map)
  lib/services/api_data_fetch.dart
  lib/services/keyverse_service.dart

  Old screens (after v2 verified):
  lib/screens/announcement_screen.dart
  lib/screens/message_list.dart
  ... etc
```

### 7.3 Rewrite Tests
**File:** `test/widget_test.dart` - Replace broken counter test with actual tests

**Verification:** No Provider imports, all tests pass

---

## Phase 8: Advanced Offline (Week 9)

### 8.1 Background Sync
- Periodic background data refresh
- Sync when connectivity restored

### 8.2 Offline Write Queue
- Queue opinion submissions when offline
- Show pending indicator
- Sync when online

### 8.3 Cache Management UI
- Clear cache option in settings
- Show cache size

---

## Target Folder Structure

```
lib/
  main.dart
  app.dart
  core/
    config/
    constants/
    error/
    network/
    storage/
  data/
    models/
    datasources/
      remote/
      local/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    providers/
    screens/
      home/
      announcements/
      messages/
      bible/
      settings/
    shared/
      widgets/
      theme/
    navigation/
  l10n/
```

---

## Critical Files to Modify

| File | Action | Priority |
|------|--------|----------|
| `pubspec.yaml` | Update SDK, add Riverpod deps | Phase 0 ✅ |
| `lib/services/gsheet_access.dart` | Extract credentials (SECURITY) | Phase 0 ✅ |
| `lib/main.dart` | Add ProviderScope | Phase 0 ✅ |
| `lib/services/background_service.dart` | Remove cache reset | Phase 2 ✅ |
| `lib/utilities/shared_preference.dart` | Wrap with LocalStorage | Phase 1 ✅ |
| `lib/screens/home_screen.dart` | Migrate to ConsumerWidget | Phase 4 ✅ |
| `lib/globals.dart` | DELETE | Phase 4 ✅ |

---

## Verification Strategy

After each phase:
1. `flutter analyze` - No errors
2. `flutter test` - All tests pass
3. Manual testing - Both languages (KO/EN)
4. Offline test - Kill network, verify cached data
5. Feature flag toggle - Old/new screens work

---

## Risk Mitigation

- **Feature flags** for gradual rollout
- **Parallel implementations** (old + new) until verified
- **Git branches** per phase
- **Backup SharedPreferences** before cache migration
- **Rotate credentials** after security fix

---

## Pause Points

Each phase produces working app:
- After Phase 0: Foundation ready ✅
- After Phase 1: Settings migrated ✅
- After Phase 2: Offline works ✅
- After Phase 3: Announcement template complete ✅
- After Phase 4: Messages & Serving Turn complete ✅
- After Phase 7: Migration complete
