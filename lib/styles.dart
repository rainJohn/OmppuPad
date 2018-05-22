import 'package:flutter/material.dart';

// Colorable entities (by ThemeData) in the UI
enum Colorable {
  accentText,
  background,
  card,
  divider,
  icon,
  selectedCard,
  text,
  titleText,
  subheadText
}

class Palette {
  Palette._();

  // Light (default) color palette
  static const Map<Colorable, Color> light = const <Colorable, Color> {
    Colorable.accentText: const Color(0xFF303030),
    Colorable.background: const Color(0xFFE6E6E6),
    Colorable.card: Colors.white,
    Colorable.divider: const Color(0xFFA4A4A4),
    Colorable.icon: const Color(0xFFA4A4A4),
    Colorable.selectedCard: const Color(0xFFF7F7F7),
    Colorable.text: const Color(0xFFA4A4A4),
    Colorable.titleText: const Color(0xFF303030),
    Colorable.subheadText: const Color(0xFFA4A4A4),
  };

  // Dark color palette
  static const Map<Colorable, Color> dark = const <Colorable, Color> {
    Colorable.accentText: Colors.white,
    Colorable.background: const Color(0xFF22242A),
    Colorable.card: const Color(0xFF32353E),
    Colorable.divider: const Color(0xFFA4A4A4),
    Colorable.icon: const Color(0xFFA4A4A4),
    Colorable.selectedCard: const Color(0xFF474747),
    Colorable.text: const Color(0xFFA4A4A4),
    Colorable.titleText: Colors.white,
    Colorable.subheadText: const Color(0xFFA4A4A4),
  };

  static const musicGreen = const Color(0xFF1DB954);
}

class Spacing {
  Spacing._();

  static final double gutterMicro = 8.0;
  static final double gutterMini = 16.0;
  static final double gutter = 32.0;
}

class FontSize {
  FontSize._();

  static final smallText = 14.0;
  static final text = 16.0;
  static final titleText = 24.0;
  static final subheadText = 20.0;
  static final icon = 24.0;
}
