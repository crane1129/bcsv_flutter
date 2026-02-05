import 'package:bcsv_flutter_project/domain/repositories/settings_repository.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';

/// Implementation of SettingsRepository using SharedPreferences
class SettingsRepositoryImpl implements SettingsRepository {
  // Theme settings
  @override
  Future<int> getThemeIndex() async {
    return UserSharedPreferences.getAppThemeSetting() ?? 0;
  }

  @override
  Future<void> setThemeIndex(int index) async {
    await UserSharedPreferences.setAppThemeSetting(index);
  }

  // Locale settings
  @override
  Future<String?> getLanguageOption() async {
    return UserSharedPreferences.getLanguageOption();
  }

  @override
  Future<void> setLanguageOption(String languageCode) async {
    await UserSharedPreferences.setLanguageOption(languageCode);
  }

  // Card visibility settings
  @override
  Future<bool> getShowAnnouncementCard() async {
    return UserSharedPreferences.getShowAnnouncementCard();
  }

  @override
  Future<void> setShowAnnouncementCard(bool show) async {
    await UserSharedPreferences.setShowAnnouncementCard(show);
  }

  @override
  Future<bool> getShowMessageCard() async {
    return UserSharedPreferences.getShowMessageCard();
  }

  @override
  Future<void> setShowMessageCard(bool show) async {
    await UserSharedPreferences.setShowMessageCard(show);
  }

  @override
  Future<bool> getShowServingTurnCard() async {
    return UserSharedPreferences.getShowServingTurnCard();
  }

  @override
  Future<void> setShowServingTurnCard(bool show) async {
    await UserSharedPreferences.setShowServingTurnCard(show);
  }

  @override
  Future<bool> getShowOfferingCard() async {
    return UserSharedPreferences.getShowOfferingCard();
  }

  @override
  Future<void> setShowOfferingCard(bool show) async {
    await UserSharedPreferences.setShowOfferingCard(show);
  }

  @override
  Future<bool> getShowBibleTextCard() async {
    return UserSharedPreferences.getShowBibleTextCard();
  }

  @override
  Future<void> setShowBibleTextCard(bool show) async {
    await UserSharedPreferences.setShowBibleTextCard(show);
  }

  @override
  Future<bool> getShowDailyBibleCard() async {
    return UserSharedPreferences.getShowDailyBibleCard();
  }

  @override
  Future<void> setShowDailyBibleCard(bool show) async {
    await UserSharedPreferences.setShowDailyBibleCard(show);
  }

  @override
  Future<bool> getShowBibleSearchCard() async {
    return UserSharedPreferences.getShowBibleSearchCard();
  }

  @override
  Future<void> setShowBibleSearchCard(bool show) async {
    await UserSharedPreferences.setShowBibleSearchCard(show);
  }

  @override
  Future<bool> getShowKeywordSearchCard() async {
    return UserSharedPreferences.getShowKeywordSearchCard();
  }

  @override
  Future<void> setShowKeywordSearchCard(bool show) async {
    await UserSharedPreferences.setShowKeywordSearchCard(show);
  }

  // Staff mode
  @override
  Future<bool> isStaffModeEnabled() async {
    return await UserSharedPreferences.isStaffModeEnabled();
  }

  @override
  Future<void> setStaffMode(bool enabled) async {
    await UserSharedPreferences.setStaffMode(enabled);
  }
}
