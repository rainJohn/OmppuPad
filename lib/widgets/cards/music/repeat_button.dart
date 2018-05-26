import 'package:flutter/material.dart';
import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/music_player.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';
import 'package:omppu_pad/styles.dart';

class RepeatButton extends StatelessWidget {
  final double iconSize = 22.0;

  Widget getRepeatMarker() {
    return new Positioned(
      top: 35.0,
      right: 22.5,
      child: new Container(
        width: 4.0,
        height: 4.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle, color: Palette.musicGreen),
      ),
    );
  }

  Widget getRepeatTrackOverlay() {
    return new Positioned(
      top: 20.0,
      right: 18.0,
      child: new Container(
        height: 8.0,
        width: 8.0,
        child: new Text(
          '1',
          style: new TextStyle(
            color: Palette.musicGreen,
            fontSize: 6.0,
            fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TrackRepeat getNextRepeatMode(TrackRepeat current) {
    if (current == TrackRepeat.context) return TrackRepeat.track;
    if (current == TrackRepeat.track) return TrackRepeat.off;
    return TrackRepeat.context;
  }

  @override
  Widget build(BuildContext context) {

    var musicPlayerProvider = MusicPlayerProvider.of(context);
    return StreamBuilder(
      stream: musicPlayerProvider.repeatMode,
      initialData: TrackRepeat.off,
      builder: (context, snapshot) {
        TrackRepeat repeatMode = snapshot.data;
        Color color = repeatMode != TrackRepeat.off
          ? Palette.musicGreen
          : Theme.of(context).iconTheme.color;

        IconButton button = IconButton(
          iconSize: iconSize,
          icon: Icon(AppIcons.repeat, color: color),
          onPressed: () => musicPlayerProvider.onRepeatModeChanged.add(
            getNextRepeatMode(repeatMode)
          ),
        );

        if (repeatMode == TrackRepeat.off) return button;

        List<Widget> children = new List<Widget>();
        children.add(button);
        children.add(getRepeatMarker());
        if (repeatMode == TrackRepeat.track) children.add(getRepeatTrackOverlay());
        return new Stack(
          children: children
        );
      }
    );
  }
}