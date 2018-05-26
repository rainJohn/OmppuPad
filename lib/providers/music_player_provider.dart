import 'package:flutter/material.dart';

import 'package:omppu_pad/blocs/music_player_bloc.dart';

class MusicPlayerProvider extends InheritedWidget {
  final MusicPlayerBloc musicPlayerBloc;

  MusicPlayerProvider({
    Key key,
    MusicPlayerBloc musicPlayerBloc,
    Widget child
  }) : musicPlayerBloc = musicPlayerBloc ?? MusicPlayerBloc(),
        super(key: key, child: child);
          
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MusicPlayerBloc of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(MusicPlayerProvider) as MusicPlayerProvider).musicPlayerBloc;
}