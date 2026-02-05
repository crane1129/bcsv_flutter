/// Repository interface for app settings (theme, locale, card visibility, etc.)
abstract class SettingsRepository {
  // Theme settings
  Future<int> getThemeIndex();
  Future<void> setThemeIndex(int index);

  // Locale settings
  Future<String?> getLanguageOption();
  Future<void> setLanguageOption(String languageCode);

  // Card visibility settings
  Future<bool> getShowAnnouncementCard();
  Future<void> setShowAnnouncementCard(bool show);

  Future<bool> getShowMessageCard();
  Future<void> setShowMessageCard(bool show);

  Future<bool> getShowServingTurnCard();
  Future<void> setShowServingTurnCard(bool show);

  Future<bool> getShowOfferingCard();
  Future<void> setShowOfferingCard(bool show);

  Future<bool> getShowBibleTextCard();
  Future<void> setShowBibleTextCard(bool show);

  Future<bool> getShowDailyBibleCard();
  Future<void> setShowDailyBibleCard(bool show);

  Future<bool> getShowBibleSearchCard();
  Future<void> setShowBibleSearchCard(bool show);

  Future<bool> getShowKeywordSearchCard();
  Future<void> setShowKeywordSearchCard(bool show);

  // Staff mode
  Future<bool> isStaffModeEnabled();
  Future<void> setStaffMode(bool enabled);
}
