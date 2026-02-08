# Diagnostic Logging Guide

## Overview

Enhanced logging has been added to all migrated screens and providers to help diagnose runtime issues. The logs use emoji prefixes for easy scanning in the console.

## Log Emoji Guide

| Emoji | Meaning | Usage |
|-------|---------|-------|
| 🎯 | Method Entry | Shows when a method is called with parameters |
| 🟢 | Screen Event | Screen lifecycle events (initState, build) |
| 🔵 | State Change | Provider state updates |
| 🌐 | Network Operation | Data fetching from repository/API |
| 📊 | Data Stats | Data received (count, size, etc.) |
| 📦 | Cache Status | Whether data came from cache or network |
| 🕐 | Timestamp | Last updated time |
| ✅ | Success | Operation completed successfully |
| ⚠️ | Warning | Non-critical issue or empty data |
| ❌ | Error | Error occurred |
| 🔴 | Error State | State set to error |
| 📍 | Stack Trace | Error stack trace (first 5 lines) |

## How to Use

### 1. Run the App with Console Logs

```bash
flutter run
```

The console will show detailed logs as you navigate the app.

### 2. Filter Logs by Component

Use grep to filter logs for specific components:

```bash
# Watch only ServingTurn logs
flutter run | grep "\[ServingTurn\]"

# Watch only DailyBible logs
flutter run | grep "\[DailyBible\]"

# Watch only KeyVerse logs
flutter run | grep "\[KeyVerse\]"

# Watch only HomeScreen logs
flutter run | grep "\[HomeScreen\]"

# Watch only errors
flutter run | grep "❌\|🔴"

# Watch only warnings
flutter run | grep "⚠️"
```

### 3. Common Log Sequences

#### Normal Screen Load (ServingTurn Example)

```
🟢 [ServingTurnScreen] initState called
🟢 [ServingTurnScreen] Post-frame callback - initiating loadServingTurns
🎯 [ServingTurn] loadServingTurns called (forceRefresh: false, currentState: ServingTurnStatus.initial)
🔵 [ServingTurn] Setting state to loading
🌐 [ServingTurn] Fetching from repository...
📊 [ServingTurn] Received 12 items
📦 [ServingTurn] Has cache: true
🕐 [ServingTurn] Last updated: 2025-02-06 10:30:00
🎯 [ServingTurn] Current turn: 2025-02-10
✅ [ServingTurn] State updated successfully
📅 [ServingTurn] Current turn: 2025-02-10 - John Doe
🔵 [ServingTurnScreen] build called - status: ServingTurnStatus.loaded, count: 12, isEmpty: false
```

#### Error Scenario

```
🟢 [DailyBibleScreen] initState called
🟢 [DailyBibleScreen] Post-frame callback - initiating loadToday
🎯 [DailyBible] loadDailyBible called (date: 2025-02-06, forceRefresh: false, currentState: DailyBibleStatus.initial)
🔵 [DailyBible] Setting state to loading
🌐 [DailyBible] Fetching from repository...
❌ [DailyBible] Error loading: Network error
📍 [DailyBible] Stack: NetworkException at line 123...
🔴 [DailyBible] State set to error
🔵 [DailyBibleScreen] build called - status: DailyBibleStatus.error, hasData: false, isEmpty: false
```

#### Cache Hit

```
🎯 [KeyVerse] loadKeyVerse called (year: 2025, forceRefresh: false, currentState: KeyVerseStatus.initial)
🔵 [KeyVerse] Setting state to loading
🌐 [KeyVerse] Fetching from repository...
📊 [KeyVerse] Received: data
📦 [KeyVerse] Source: CACHE
🕐 [KeyVerse] Last updated: 2025-02-06 09:00:00
✅ [KeyVerse] Loaded: 사랑의 교회 (창 1:1)
🔵 [KeyVerse] State updated successfully
```

#### No Data / Empty State

```
🎯 [ServingTurn] loadServingTurns called (forceRefresh: false, currentState: ServingTurnStatus.initial)
🔵 [ServingTurn] Setting state to loading
🌐 [ServingTurn] Fetching from repository...
📊 [ServingTurn] Received 0 items
📦 [ServingTurn] Has cache: false
🕐 [ServingTurn] Last updated: never
✅ [ServingTurn] State updated successfully
⚠️ [ServingTurn] WARNING: No serving turns in result
🔵 [ServingTurnScreen] build called - status: ServingTurnStatus.loaded, count: 0, isEmpty: true
```

## Troubleshooting Common Issues

### Issue: Screen shows empty state

**Look for:**
```
📊 [ComponentName] Received 0 items
⚠️ [ComponentName] WARNING: No data in result
```

**Possible causes:**
1. No cached data and network request failed
2. API returned empty array
3. Cache expired and refresh failed

**Solution:** Check network logs, verify API is returning data

---

### Issue: Screen shows loading forever

**Look for:**
```
🔵 [ComponentName] Setting state to loading
(no subsequent logs)
```

**Possible causes:**
1. Network request hanging
2. Exception not caught
3. Repository method not returning

**Solution:** Check for timeout errors, verify repository implementation

---

### Issue: Data shows but is old

**Look for:**
```
📦 [ComponentName] Source: CACHE
🕐 [ComponentName] Last updated: [old date]
```

**Possible causes:**
1. forceRefresh is false
2. Network unavailable, falling back to cache
3. Cache not expired yet

**Solution:** Use pull-to-refresh to force update

---

### Issue: Frequent re-renders

**Look for:**
```
🔵 [ScreenName] build called - ...
🔵 [ScreenName] build called - ...
🔵 [ScreenName] build called - ...
```

**Possible causes:**
1. Provider state changing unnecessarily
2. Widget rebuilding on parent change
3. Animation triggering rebuilds

**Solution:** Check provider state changes, optimize widget tree

---

## Components with Enhanced Logging

### Providers
- ✅ `serving_turn_provider.dart`
- ✅ `daily_bible_provider.dart`
- ✅ `keyverse_provider.dart`
- ✅ `sunday_bible_text_provider.dart` (existing logging preserved)

### Screens
- ✅ `serving_turn_screen.dart`
- ✅ `daily_bible_text_screen.dart`
- ✅ `home_screen.dart` (keyverse section)
- ✅ `sunday_bible_text_screen.dart` (existing logging preserved)

## Important Changes Made

### Cache-First Loading

All screens now use `forceRefresh: false` on initial load for faster startup:
- ✅ `serving_turn_screen.dart` - Changed from `true` to `false`
- ✅ `daily_bible_text_screen.dart` - Already set to `false`
- ✅ `home_screen.dart` - Already set to `false`

This means:
1. App loads cached data immediately if available
2. Shows data instantly instead of waiting for network
3. User can pull-to-refresh to force fresh data

## Next Steps

1. **Run the app**: `flutter run`
2. **Navigate to each screen** and watch the console logs
3. **Identify the issue** using the log patterns above
4. **Share the logs** that show the problem for further diagnosis

## Example: Capturing Logs for Support

To capture logs for sharing:

```bash
# Capture all logs to file
flutter run > app_logs.txt 2>&1

# Or capture only errors
flutter run 2>&1 | grep "❌\|🔴" > errors.txt

# Or capture specific component
flutter run 2>&1 | grep "\[DailyBible\]" > daily_bible_logs.txt
```

Then share the relevant log file showing the issue.
