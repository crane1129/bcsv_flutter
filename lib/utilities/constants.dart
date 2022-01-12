import 'dart:ui';

import 'package:flutter/material.dart';

const String kAnnouncementData = 'announcement.json';
const String kBibleTextData = 'bible_text.json';
const String kServingTurnData = 'serving_turn.json';
const String kDailyBibleData = 'daily_bible.json';
const String kBibleReviewData = 'bible_review.json';

const String kBaseUrl = "https://bcsv.org";
const String kOfferingUrl =
    "https://my.cheddarup.com/c/bridgeway-church-of-silicon-valley-2022";
const String kYoutubeLiveUrl =
    "https://www.youtube.com/channel/UCbCCXtoBmuJ6kYqHFrzPSxg";
const kActiveCardColor = Color(0xFF1D1E33);
const kActiveIconColor = Colors.indigo;
const kInactiveIconColor = Colors.blueGrey;
const kCardIconColor = Colors.white54;
const kMainAppBarColor = Color(0xFF0A0E21);

const kAppBarTextStyle = TextStyle(
    fontSize: 45.0, fontWeight: FontWeight.normal, fontFamily: 'Dongle-Bold');

const kAppBarTextStyleSmall = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Dongle-Regular',
    color: Colors.green);

const kBodyTextStyle = TextStyle(
    fontSize: 25.0, color: Colors.white, fontFamily: 'Dongle-Regular');

const kLabelTextStyle = TextStyle(
    fontSize: 18.0, color: Colors.white70, fontFamily: 'Dongle-Regular');

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kRegularButtonTextStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
    fontSize: 100.0,
    color: Colors.white70,
    fontFamily: 'Dongle-Regular',
    letterSpacing: 1.0,
    height: 0.0);

const kSubTitleTextStyle = TextStyle(
    fontSize: 50.0,
    color: Colors.lightGreen,
    fontFamily: 'Dongle-Regular',
    textBaseline: TextBaseline.alphabetic);
