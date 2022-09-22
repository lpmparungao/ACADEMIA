import 'package:flutter/material.dart';

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = Color(0xFF2D2F41);
  static Color menuBackgroundColor = Color(0xFF242634);

  static Color clockBG = Color(0xFF444974);
  static Color clockOutline = Color(0xFFEAECFF);
  static Color secHandColor = Colors.orange[300];
  static Color minHandStatColor = Color(0xFF748EF6);
  static Color minHandEndColor = Color(0xFF77DDFF);
  static Color hourHandStatColor = Color(0xFFC279FB);
  static Color hourHandEndColor = Color(0xFFEA74AB);
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  static List<Color> retro = [Color(0xFFFDBB2D), Color(0xFF22C1C3)];
  static List<Color> fresco = [Color(0xFFFDBB2D), Color(0xFF3A1C71)];
  static List<Color> ooey = [Color(0xFF0700b8), Color(0xFF00ff88)];
  static List<Color> moss = [Color(0xFF9ebd13), Color(0xFF008552)];
  static List<Color> swamp = [Color(0xFFd9e7ff), Color(0xFF008552)];
  static List<Color> cucumber = [Color(0xFFe3ffe7), Color(0xFFd9e7ff)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.retro),
    GradientColors(GradientColors.fresco),
    GradientColors(GradientColors.ooey),
    GradientColors(GradientColors.moss),
    GradientColors(GradientColors.swamp),
    GradientColors(GradientColors.cucumber),
  ];
}
