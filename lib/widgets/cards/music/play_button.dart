import 'package:flutter/material.dart';
import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';

class PlayButton extends StatelessWidget {

  Widget getIcon(Color color, bool isPlaying) {
    if (isPlaying) {
      return Icon(AppIcons.pause, size: 25.0, color: color);
    }
    return Padding(
      padding: EdgeInsets.only(left: 4.0),
      child: Icon(AppIcons.play, size: 25.0, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    var musicPlayerBloc = MusicPlayerProvider.of(context);
    Color color = Theme.of(context).textTheme.body2.color;
    return StreamBuilder(
        stream: musicPlayerBloc.isPlaying,
        initialData: false,
        builder: (context, snapshot) {
          bool isPlaying = snapshot.data;
          return IconButton(
            iconSize: 45.0,
            onPressed: () => musicPlayerBloc.onIsPlaying(isPlaying),
            icon: Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 1.0,
                ),
              ),
              child: getIcon(color, isPlaying),
            ),
          );
        }
    );
  }
}