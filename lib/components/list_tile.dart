import 'package:flutter/material.dart';

class ContentListTile {
  final IconData icon;
  final Widget headerText;
  final List<Widget> contents;
  bool isExpanded;

  ContentListTile(
      {required this.headerText,
      this.contents = const [],
      this.isExpanded = false,
      required this.icon});
}
