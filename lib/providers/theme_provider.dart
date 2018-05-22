import 'package:flutter/material.dart';

import 'package:omppu_pad/blocs/theme_bloc.dart';

/*
  This Widget will enable any child down the subtree to gain access to themeBloc and 
  its internal streams in order to access its sinks and streams.
*/
class ThemeProvider extends InheritedWidget {
  final ThemeBloc themeBloc;

  ThemeProvider({
    Key key,
    @required ThemeBloc themeBloc,
    Widget child
  }) : themeBloc = themeBloc ?? ThemeBloc(),
        super(key: key, child: child);

          
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ThemeBloc of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(ThemeProvider) as ThemeProvider).themeBloc;
}