import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko')
  ];

  /// description
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// description
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get korean;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sunday Sermons'**
  String get sundaySermons;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sermon Archives'**
  String get sermonArchives;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Youtube Live'**
  String get youtubeLive;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Serving Turn'**
  String get servingTurn;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sunday Bulletin'**
  String get announcement;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Bible Text'**
  String get bibleText;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sermon Text'**
  String get sermonBibleText;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sermon Review'**
  String get sermonReview;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Daily Bible'**
  String get dailyBible;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Offering'**
  String get offering;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Upcoming Event'**
  String get upcomingEvent;

  /// description
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Bridgeway'**
  String get bridgeway;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Baptist Church'**
  String get baptistChurch;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Reimbursement'**
  String get reimbursement;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Sunday Serving Turn'**
  String get sundayServingTurn;

  /// description
  ///
  /// In en, this message translates to:
  /// **'No Internet connection. Please check the network connection.'**
  String get noInternetConnectionPleaseCheckTheNetworkConnection;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Opinion'**
  String get opinion;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Bridgeway Opinion'**
  String get bridgewayOpinion;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Please send us your opinion'**
  String get pleaseSendUsYourOpinion;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get thankYou;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Your opinion has successfully submitted'**
  String get yourOpinionHasSuccessfullySubmitted;

  /// description
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get newMessage;

  /// description
  ///
  /// In en, this message translates to:
  /// **'app information'**
  String get appInformation;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Language Setting'**
  String get languageSetting;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Church Reimbursement'**
  String get churchReimbursement;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Please submit your expense for church events'**
  String get pleaseSubmitYourExpenseForChurchEvents;

  /// description
  ///
  /// In en, this message translates to:
  /// **'Your submission is made anonymously'**
  String get yourSubmissionIsMadeAnonymously;

  /// description
  ///
  /// In en, this message translates to:
  /// **'The text is empty. Please enter your opinion.'**
  String get pleaseEnterYourOpinion;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get openPdf;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Each man should give what he has decided\nin his heart to give,\nnot reluctantly or under compulsion,\nfor God loves a cheerful giver.\n(2 Corinthians 9:7)'**
  String get offeringVerse;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Please send us your opinion\nto Bridgeway church'**
  String get opinionTitle;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Your submission is made anonymously'**
  String get opinionSubTitle;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openButtonText;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Please submit your expense for church events'**
  String get reimbursementDesc;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Mission Statement'**
  String get missionStatement;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'John 13: 34-35'**
  String get missionVerse;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Reset Messages'**
  String get initMessage;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Execute'**
  String get runButton;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get noticeTitle;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'The app is now closing.'**
  String get restartNotice;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Sunday Offering Account'**
  String get sundayOffering;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Benevolence Offering Account'**
  String get benevolenceOffering;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get prayer;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Food Prep'**
  String get foodPrep;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday_worship;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Offering Direction'**
  String get offering_direction;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'See detail information'**
  String get offering_direction_text;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Bible Reading Plan'**
  String get bible_reading_plan;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Bible Search'**
  String get bible_search;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Old Testament'**
  String get bible_old_testament;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'New Testament'**
  String get bible_new_testament;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Staff Only Menu'**
  String get staff_only_mode;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Unconfirmed Requests'**
  String get unconfirmed_opinion;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Start Chapter'**
  String get start_chapter;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Start Verse (optional)'**
  String get start_verse;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'End Chapter (optional)'**
  String get end_chapter;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'End Verse (optional)'**
  String get end_verse;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'Key Verse'**
  String get key_verse;

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'A new command I give you: Love one another. As I have loved you, so you must love one another.\nBy this all men will know that you are my disciples, if you love one another.'**
  String get mission_statement_verse;

  /// Error message displayed when there is no internet connection
  ///
  /// In en, this message translates to:
  /// **'No Internet connection. Please check your network connection.'**
  String get networkErrorMessage;

  /// Message explaining automatic reconnection on disconnect screen
  ///
  /// In en, this message translates to:
  /// **'We\'ll automatically connect when your network is available, or you can try again.'**
  String get retryNetworkMessage;

  /// Loading message when checking network connection
  ///
  /// In en, this message translates to:
  /// **'Checking connection...'**
  String get checkingConnection;

  /// Button text to retry network connection
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Info message that automatic retry is enabled
  ///
  /// In en, this message translates to:
  /// **'Auto-retry active'**
  String get autoRetryMessage;

  /// Info message that automatic retry is enabled
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get dataLoading;

  /// Title for card visibility settings section
  ///
  /// In en, this message translates to:
  /// **'Card Visibility Settings'**
  String get cardVisibilitySettings;

  /// Subtitle for card visibility settings section
  ///
  /// In en, this message translates to:
  /// **'Show/Hide cards on home screen'**
  String get cardVisibilitySubtitle;

  /// Title for restart required dialog
  ///
  /// In en, this message translates to:
  /// **'Restart Required'**
  String get restartRequiredTitle;

  /// Message for restart required dialog
  ///
  /// In en, this message translates to:
  /// **'Please restart the app to apply home screen layout changes.'**
  String get restartRequiredMessage;

  /// Button text to restart the app immediately
  ///
  /// In en, this message translates to:
  /// **'Restart Now'**
  String get restartNow;

  /// Button text to restart the app later
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get restartLater;

  /// Bible Keyword Search Button Text
  ///
  /// In en, this message translates to:
  /// **'Bible Keyword'**
  String get keywordSearch;

  /// Key Verse Text
  ///
  /// In en, this message translates to:
  /// **'Key Verse'**
  String get keyVerse;

  /// vision and direction
  ///
  /// In en, this message translates to:
  /// **'The Vision and Direction of Our Church'**
  String get vision_direction;

  /// description
  ///
  /// In en, this message translates to:
  /// **'• Mnistry centered on the Word and disciple training\n• Evangelization of youth in Silicon Valley/campuses\n• A community that shares life together\n• Encouragement of personal faith growth and commitment'**
  String get vision_direction_content;

  /// Title for message upload screen
  ///
  /// In en, this message translates to:
  /// **'Upload Message'**
  String get uploadMessage;

  /// Header title for message upload form
  ///
  /// In en, this message translates to:
  /// **'Upload New Message'**
  String get uploadMessageTitle;

  /// Subtitle for message upload form
  ///
  /// In en, this message translates to:
  /// **'Post announcements and news for the church.'**
  String get uploadMessageSubtitle;

  /// Label for message title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get messageTitle;

  /// Label for message content field
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get messageContent;

  /// Label for category dropdown
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// Label for start date picker
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDateLabel;

  /// Label for end date picker
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDateLabel;

  /// Label for external link field
  ///
  /// In en, this message translates to:
  /// **'External Link'**
  String get externalLinkLabel;

  /// Success message after upload
  ///
  /// In en, this message translates to:
  /// **'Message uploaded successfully'**
  String get uploadSuccess;

  /// Status text when image is attached
  ///
  /// In en, this message translates to:
  /// **'Image attached'**
  String get imageAttached;

  /// Placeholder text for image attachment
  ///
  /// In en, this message translates to:
  /// **'Attach Image (optional)'**
  String get attachImageOptional;

  /// Title for message management screen
  ///
  /// In en, this message translates to:
  /// **'Manage Messages'**
  String get manageMessages;

  /// Title for edit message form
  ///
  /// In en, this message translates to:
  /// **'Edit Message'**
  String get editMessage;

  /// Update button label
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Success message after updating
  ///
  /// In en, this message translates to:
  /// **'Update Successful'**
  String get updateSuccess;

  /// Empty state message for message management
  ///
  /// In en, this message translates to:
  /// **'Select a message to edit'**
  String get selectMessageToEdit;

  /// Header title for staff options card in settings
  ///
  /// In en, this message translates to:
  /// **'Staff Options'**
  String get staffOptions;

  /// Subtitle for staff options card header
  ///
  /// In en, this message translates to:
  /// **'Staff authentication required'**
  String get staffOptionsSubtitle;

  /// Title for staff message management toggle
  ///
  /// In en, this message translates to:
  /// **'Message Management'**
  String get staffMessageManagement;

  /// Subtitle for staff message management toggle
  ///
  /// In en, this message translates to:
  /// **'Upload & manage church messages'**
  String get staffMessageManagementSubtitle;

  /// Title for staff opinion review toggle
  ///
  /// In en, this message translates to:
  /// **'Opinion Review'**
  String get staffOpinionReview;

  /// Subtitle for staff opinion review toggle
  ///
  /// In en, this message translates to:
  /// **'View & confirm submitted opinions'**
  String get staffOpinionReviewSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
