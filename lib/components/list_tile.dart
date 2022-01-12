import 'package:flutter/material.dart';

class AnnounceListTile {
  final IconData icon;
  final String headerText;
  final List<Widget> contents;
  bool isExpanded;

  AnnounceListTile(
      {required this.headerText,
      this.contents = const [],
      this.isExpanded = false,
      required this.icon});
}
