import 'package:flutter/material.dart';
import 'package:omppu_pad/styles.dart';

class AppTheme {
  static final ThemeData lightTheme = buildTheme();
  static final ThemeData darkTheme = buildTheme(true);

  AppTheme();

  void updateBySunsetAndSunrise() async {
    // TODO
  }

  ThemeData theme = darkTheme;
  Map<Colorable, Color> palette = Palette.dark;
}

ThemeData buildTheme([bool dark = false]) {
  var palette = dark ? Palette.dark : Palette.light;

  return ThemeData(
    brightness: dark ? Brightness.dark : Brightness.light,
    primaryColor: palette[Colorable.background],
    primaryColorBrightness: dark ? Brightness.dark : Brightness.light,
    primaryColorDark: palette[Colorable.selectedCard],
    accentColor: palette[Colorable.text],
    accentColorBrightness: dark ? Brightness.dark : Brightness.light,
    selectedRowColor: palette[Colorable.selectedCard],
    textTheme: TextTheme(
      title: TextStyle(
        fontSize: FontSize.titleText,
        color: palette[Colorable.titleText]
      ),
      subhead: TextStyle(
        fontSize: FontSize.subheadText,
        color: palette[Colorable.subheadText],
      ),
      body2: TextStyle(
        fontSize: FontSize.text,
        color: palette[Colorable.accentText]
      ),
      body1: TextStyle(
        fontSize: FontSize.text,
        color: palette[Colorable.text],
        decoration: TextDecoration.none,
      ),
    ),
    iconTheme: IconThemeData(
      color: palette[Colorable.icon],
      opacity: 1.0,
      size: FontSize.icon
    ),
  );
}