import 'package:flutter/material.dart';

import 'package:omppu_pad/blocs/time_bloc.dart';

class TimeProvider extends InheritedWidget {
  final TimeBloc timeBloc;

  TimeProvider({
    Key key,
    @required TimeBloc timeBloc,
    Widget child
  }) : timeBloc = timeBloc ?? TimeBloc(),
        super(key: key, child: child);
          
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TimeBloc of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(TimeProvider) as TimeProvider).timeBloc;
}