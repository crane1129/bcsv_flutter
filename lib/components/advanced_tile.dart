import 'package:flutter/material.dart';

class AdvancedTile {
  final Text title;
  final IconData icon;
  final List<AdvancedTile> tiles;
  bool isExpanded;

  AdvancedTile({
    required this.title,
    required this.icon,
    this.tiles = const [],
    this.isExpanded = false,
  });
}
