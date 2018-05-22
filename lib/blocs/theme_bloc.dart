import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omppu_pad/models/app_theme.dart';
import 'package:omppu_pad/styles.dart';
import 'package:rxdart/subjects.dart';

class ThemeBloc {
  static final AppTheme _appTheme = AppTheme();
  
  // Attribute flows definition
  final _currentTheme = BehaviorSubject<ThemeData>(seedValue: _appTheme.theme);
  final _currentPalette = BehaviorSubject<Map<Colorable, Color>>(seedValue: _appTheme.palette);
  final _themeToggle = StreamController<bool>();

  ThemeBloc() {
    _themeToggle.stream.listen((usingDarkTheme) {
      // update model
      _appTheme.theme = usingDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
      _appTheme.palette = usingDarkTheme ? Palette.dark : Palette.light;
      // update streams
      _currentTheme.add(_appTheme.theme);
      _currentPalette.add(_appTheme.palette);
    });
  }

  // Sink/Stream accessors
  Sink<bool> get toggleTheme => _themeToggle.sink;
  Stream<Map<Colorable, Color>> get palette => _currentPalette.stream;
  Stream<ThemeData> get theme => _currentTheme.stream;

  bool get isDarkThemeToggled => _appTheme.theme == AppTheme.darkTheme;

  void dispose() {
    _currentPalette.close();
    _currentTheme.close();
    _themeToggle.close();
  }
}