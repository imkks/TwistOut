import 'package:flutter/material.dart';

/// Twist Out color palette and typography tokens from docs/UI_UX.md.
class GameColors {
  GameColors._();

  static const Color ink = Color(0xFF2B2118);
  static const Color paper = Color(0xFFFFF8EC);
  static const Color ctaPrimary = Color(0xFF178F5F);
  static const Color ctaPrimaryPressed = Color(0xFF11724C);
  static const Color ctaSecondary = Color(0xFF3E63DD);
  static const Color danger = Color(0xFFD64545);
  static const Color coinGold = Color(0xFFFFC53D);
  static const Color scrim = Color(0x8C140E08);

  // World 1 Wood Shop gradient
  static const Color world1BgStart = Color(0xFFF2D9AE);
  static const Color world1BgEnd = Color(0xFFD9A86C);

  // Plate wood materials
  static const Color plateWoodLight = Color(0xFFDEB887);
  static const Color plateWoodDark = Color(0xFFC49A6C);
  static const Color plateBorder = Color(0xFF6B4226);

  // 8 Colorblind-safe screw colors (UI_UX.md Section 2.2)
  static const List<Color> screwColors = [
    Color(0xFFE5484D), // 0: Red
    Color(0xFFF76B15), // 1: Orange
    Color(0xFFFFC53D), // 2: Yellow
    Color(0xFF30A46C), // 3: Green
    Color(0xFF12A594), // 4: Teal
    Color(0xFF3E63DD), // 5: Blue
    Color(0xFF8E4EC6), // 6: Purple
    Color(0xFFE93D82), // 7: Pink
  ];

  static const List<String> screwSymbols = [
    '+', // 0: Cross
    '—', // 1: Slot
    '⬡', // 2: Hexagon
    '★', // 3: Star
    '■', // 4: Square
    '●', // 5: Ring
    '▲', // 6: Triangle
    '◆', // 7: Diamond
  ];

  static Color getScrewColor(int index) {
    if (index >= 0 && index < screwColors.length) {
      return screwColors[index];
    }
    return ink;
  }

  static String getScrewSymbol(int index) {
    if (index >= 0 && index < screwSymbols.length) {
      return screwSymbols[index];
    }
    return '●';
  }
}

/// App theme definition.
class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: GameColors.world1BgStart,
      colorScheme: ColorScheme.fromSeed(
        seedColor: GameColors.ctaPrimary,
        primary: GameColors.ctaPrimary,
        surface: GameColors.paper,
        onSurface: GameColors.ink,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: GameColors.ink,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: GameColors.ink,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: GameColors.ink,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
