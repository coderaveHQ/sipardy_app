import 'package:flutter/material.dart';

/// Some utils for the player
class PlayerUtils {

  /// A list of pantone colors to be used as a background color of the players chip
  static const List<Color> pantoneColors = <Color>[
    Color(0xFF6F4E37), // Coffee Brown
    Color(0xFF00AEEF), // Sky Blue
    Color(0xFFFFA177), // Coral Peach
    Color(0xFF004B87), // Royal Blue
    Color(0xFF007A33), // Forest Green
    Color(0xFFE87722), // Pumpkin Orange
    Color(0xFFC8102E), // Crimson Red
    Color(0xFF8BC53F), // Bright Lime
    Color(0xFF6E3FA3), // Amethyst Purple
    Color(0xFFE03C31), // Tomato Red
    Color(0xFF005EB8), // Cobalt Blue
    Color(0xFFF7EA48), // Goldenrod Yellow
    Color(0xFF6DCFF6), // Aqua
    Color(0xFFA2AAAD), // Soft Gray
    Color(0xFF00B398), // Teal Green
    Color(0xFF1E22AA), // Indigo Blue
    Color(0xFF693F23), // Dark Chestnut
    Color(0xFF00BFB3), // Turquoise Green
    Color(0xFF582C83), // Deep Violet
    Color(0xFFD22630), // Fire Engine Red
  ];

  /// Gets the color based on the players index in a list
  static Color getColorForIndex(int index) => pantoneColors[index];

  /// Gets the color based on the players position in a room
  static Color getColorForPosition(int position) => pantoneColors[position - 1];
}