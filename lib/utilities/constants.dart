import 'dart:ui';

import 'package:flutter/material.dart';

const String kAnnouncementData = 'announcement.json';
const String kBibleTextData = 'bible_text.json';
const String kServingTurnData = 'serving_turn.json';
const String kDailyBible1Data = 'daily_bible1.json';
const String kDailyBible2Data = 'daily_bible2.json';
const String kBibleReviewData = 'bible_review.json';
const String kPrayerListData = 'prayer_list.json';
const String kMissionStatement = 'Mission Statement';
const String kMissionVerse = 'John 13: 34~35';
const String kBaseUrl = "https://bcsv.org";
const String kOfferingUrl =
    "https://my.cheddarup.com/c/bridgeway-church-of-silicon-valley-2022";
const String kYoutubeLiveUrl =
    "https://www.youtube.com/channel/UCbCCXtoBmuJ6kYqHFrzPSxg";
const kActiveCardColor = Color(0x35232F34);
const kActiveIconColor = Color(0xFFF9AA33);
const kInactiveIconColor = Colors.blueGrey;
const kCardIconColor = Color(0xFFF9AA33);
const kMainAppBarColor = Color(0xFF232F34);
const kMainThemeColor = Color(0xFF344955);
const kDrawerBackgroundColor = Color(0xFF232F34);
const kSystemWideFont = 'PoorStory';
const kAppBarTextStyle = TextStyle(
    fontSize: 30.0, fontFamily: kSystemWideFont);

const kAppBarTextStyleSmall = TextStyle(
  fontSize: 20.0,
  fontFamily: kSystemWideFont,
  color: Color(0xFFF9AA33),
);

const kBodyTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: kSystemWideFont, fontWeight: FontWeight.w400);

const kListTitleStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontFamily: kSystemWideFont, fontWeight: FontWeight.w700);

const kListSubtitleStyle = TextStyle(
    fontSize: 15.0,
    color: Colors.white,
    fontFamily: kSystemWideFont);

const kCardTitleStyle = TextStyle(
    fontSize: 25.0,
    color: Colors.black,
    fontFamily: kSystemWideFont);

const kLabelTextStyle =
    TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: kSystemWideFont);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  color: Colors.white
);

const kRegularButtonTextStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white
);

const kMainTitleTextStyle = TextStyle(
    fontSize: 70.0,
    color: Colors.white70,
    fontFamily: kSystemWideFont,
    letterSpacing: 1.0,
    height: 0.0);

const kTitleTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.white,
    fontFamily: kSystemWideFont,
    letterSpacing: 1.0,
    height: 0.0);

const kSubTitleTextStyle = TextStyle(
    fontSize: 30.0,
    color: Colors.lightGreen,
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic);

const kDrawerTitleMenuTextStyle = TextStyle(
    fontSize: 20.0,
    color: Colors.white,
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic);

const kDrawerMenuTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white70,
    fontFamily: kSystemWideFont,
    textBaseline: TextBaseline.alphabetic);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  counterStyle: kBodyTextStyle,
  //icon: Icon(Icons.question_answer, color: Colors.white),
  hintText: "Enter your opinion here...",
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
