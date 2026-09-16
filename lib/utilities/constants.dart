
import 'package:flutter/material.dart';

// Bridgeway homepage (Next.js) — the app now mirrors this site's live pages
// instead of the old Wix `_functions` backend, which no longer exists.
const String kHomepageBaseUrl = "https://bridgeway.online";
final Uri kHomepageHomeUrl = Uri.parse(kHomepageBaseUrl);
final Uri kHomepageChurchUrl = Uri.parse("$kHomepageBaseUrl/church");
final Uri kHomepageMinistriesUrl = Uri.parse("$kHomepageBaseUrl/ministries");
final Uri kHomepageSermonsUrl = Uri.parse("$kHomepageBaseUrl/sermons");
// The homepage's own /links route is an empty placeholder; the real
// "links" destination is the hub site linked from its nav dropdown.
final Uri kBridgewayHubUrl = Uri.parse("https://hub.bridgeway.online/");
const String kContactApiUrl = "$kHomepageBaseUrl/api/contact";

const String kOfferingUrl =
    "https://my.cheddarup.com/c/bridgeway-church-of-silicon-valley-2022";
const kNavBackButtonColor = Color(0xFF2E5AA8);
const kMainAppBarColor = Color(0xFF17212B);

Color kActiveIconColor(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

TextStyle kAppBarTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall!.copyWith(
    fontSize: 30.0,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    color: Theme.of(context).colorScheme.primary, // or custom override
  );
}

TextStyle kAppBarTextStyleSmall(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    color: Theme.of(context).colorScheme.secondary,
  );
}

TextStyle kBodyTextStyle(BuildContext context, {double? fontSize}) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: fontSize ?? 16.0,
    height: 1.65,
    color: Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle kBodyTextSmallStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    fontWeight: FontWeight.w400,
    height: 1.65,
  );
}

TextStyle kDialogBodyTextSmallStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    fontWeight: FontWeight.w400,
    height: 1.65,
  );
}

TextStyle kListTitleStyle(BuildContext context, {bool dark = true}) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    color: dark
        ? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
}

TextStyle kListSubtitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
    fontSize: 15.0,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
  );
}

TextStyle kCardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
}

TextStyle kBodyCardTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kLabelTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 20.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );
}

TextStyle kLargeButtonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onSurface,
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
    fontWeight: FontWeight.w800,
    letterSpacing: -2.0,
    height: 0.0,
  );
}

TextStyle kTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    height: 0.0,
  );
}

TextStyle kSubTitleTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 25.0,
    color: Theme.of(context).colorScheme.primary,
    textBaseline: TextBaseline.alphabetic,
  );
}

TextStyle kDrawerTitleMenuTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 20.0,
    color: Theme.of(context).colorScheme.onSurface,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    textBaseline: TextBaseline.alphabetic,
  );
}

TextStyle kListTitleStyleBlack(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
  );
}

TextStyle kListTitleStyleWhite(BuildContext context) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle kDrawerMenuTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
    fontSize: 18.0,
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
