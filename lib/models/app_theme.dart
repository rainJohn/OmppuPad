import 'package:flutter/material.dart';
import 'package:omppu_pad/styles.dart';

class AppTheme {
  static final ThemeData lightTheme = buildTheme();
  static final ThemeData darkTheme = buildTheme(true);

  AppTheme();

  ThemeData theme = darkTheme;
  Map<Colorable, Color> palette = Palette.dark;
}

// Generates a ThemeData Widget using the correct color palette (light/dark).
// It also employs all the helper classes below to set margins, sizes, etc.
ThemeData buildTheme([bool dark = false]) {
  var palette = dark ? Palette.dark : Palette.light;

  return new ThemeData(
    brightness: dark ? Brightness.dark : Brightness.light,
    primaryColor: palette[Colorable.background],
    primaryColorBrightness: dark ? Brightness.dark : Brightness.light,
    primaryColorDark: palette[Colorable.selectedCard],
    accentColor: palette[Colorable.text],
    accentColorBrightness: dark ? Brightness.dark : Brightness.light,
    selectedRowColor: palette[Colorable.selectedCard],
    textTheme: new TextTheme(
      title: new TextStyle(
        fontSize: FontSize.titleText,
        color: palette[Colorable.titleText]
      ),
      subhead: new TextStyle(
        fontSize: FontSize.subheadText,
        color: palette[Colorable.subheadText],
      ),
      body2: new TextStyle(
        fontSize: FontSize.text,
        color: palette[Colorable.accentText]
      ),
      body1: new TextStyle(
        fontSize: FontSize.text,
        color: palette[Colorable.text],
        decoration: TextDecoration.none,
      ),
    ),
    iconTheme: new IconThemeData(
      color: palette[Colorable.icon],
      opacity: 1.0,
      size: FontSize.icon
    )
  );
}