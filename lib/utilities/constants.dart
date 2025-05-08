
import 'package:flutter/material.dart';

const String kAnnouncementData = 'announcement.json';
const String kBibleTextData = 'bible_text.json';
const String kServingTurnData = 'serving_turn.json';
const String kDailyBible1Data = 'daily_bible1.json';
const String kDailyBible2Data = 'daily_bible2.json';
const String kBibleReviewData = 'bible_review.json';
const String kPrayerListData = 'prayer_list.json';
const String kBaseUrl = "https://bridgeway.online";
const String kEndpointAPI =
    "https://script.google.com/macros/s/AKfycbwW_u3urSmxnQrIFsPxwVVzvbNnAtscBZGvxcRfYzJXuLQEWMNB/exec";
const String kOfferingUrl =
    "https://my.cheddarup.com/c/bridgeway-church-of-silicon-valley-2022";
const String kYoutubeLiveUrl =
    "https://www.youtube.com/channel/UCbCCXtoBmuJ6kYqHFrzPSxg";
const kOpinionCardColor = Color(0xFF54636B);
//const kActiveCardColor = Color(0x84042B3F);
const kNavBackButtonColor = Color(0xFFFF9C02);
const kInactiveIconColor = Color(0xFFB7C7CE);
const kCardIconColor = Color(0xFFF9AA33);
const kMainAppBarColor = Color(0xFF232F34);
const kMainThemeColor = Color(0xFF0C1B21);
//const kDrawerBackgroundColor = Color(0xFF223841);
const kSystemWideFont = 'PoorStory';
const kSystemWideFont2 = 'Dongle-Light';

Color kActiveIconColor(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

TextStyle kAppBarTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontSize: 30.0,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.primary, // or custom override
  );
}

TextStyle kAppBarTextStyleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 20.0,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.secondary,
  );
}

TextStyle kBodyTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 15,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle kBodyTextSmallStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    fontFamily: kSystemWideFont,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kDialogBodyTextSmallStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    fontFamily: kSystemWideFont,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kListTitleStyle(BuildContext context, {bool dark = true}) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    fontFamily: kSystemWideFont,
    color: dark
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.w700,
  );
}

TextStyle kListSubtitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
  );
}

TextStyle kCardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: kSystemWideFont,
  );
}

TextStyle kBodyCardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: kSystemWideFont2,
  );
}

TextStyle kLabelTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 20.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: kSystemWideFont,
  );
}

TextStyle kLargeButtonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: kSystemWideFont,
    fontWeight: FontWeight.w400,
  );
}

TextStyle kRegularButtonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelSmall!.copyWith(
    fontSize: 12.0,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle kMainTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.displaySmall!.copyWith(
    fontSize: 70.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    fontFamily: kSystemWideFont,
    letterSpacing: 1.0,
    height: 0.0,
  );
}

TextStyle kTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onPrimary,
    fontFamily: kSystemWideFont,
    letterSpacing: 1.0,
    height: 0.0,
  );
}

TextStyle kSubTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 25.0,
    color: Colors.lightGreen, // You can replace this with a colorScheme value if needed
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic,
  );
}

TextStyle kDrawerTitleMenuTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 20.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic,
  );
}

TextStyle kListTitleStyleBlack(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
  );
}

TextStyle kListTitleStyleWhite(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    fontFamily: kSystemWideFont,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle kDrawerMenuTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 18.0,
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
  );
}

InputDecoration kTextFieldInputDecoration(BuildContext context) {
  return InputDecoration(
    filled: true,
    fillColor: Theme.of(context).colorScheme.surface,
    hintText: "Enter your opinion here...",
    hintStyle: TextStyle(color: Theme.of(context).hintColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    ),
  );
}
