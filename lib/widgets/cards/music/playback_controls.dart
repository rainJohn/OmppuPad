import 'package:flutter/material.dart';

import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/music_player.dart';
import 'package:omppu_pad/providers/music_player_provider.dart';
import 'package:omppu_pad/widgets/cards/music/play_button.dart';
import 'package:omppu_pad/widgets/cards/music/repeat_button.dart';
import 'package:omppu_pad/widgets/cards/music/shuffle_button.dart';

class PlaybackControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ShuffleButton(),
        SkipButton(direction: TrackSkip.previous),
        PlayButton(),
        SkipButton(direction: TrackSkip.next),
        RepeatButton()
      ],
    );
  }
}

class SkipButton extends StatelessWidget {
  final TrackSkip direction;

  SkipButton({this.direction});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20.0,
      icon: Icon(
        direction == TrackSkip.next
          ? AppIcons.nextSong
          : AppIcons.previousSong,
        color: Theme.of(context).textTheme.body2.color
      ),
      onPressed: () => MusicPlayerProvider.of(context).onSkipTrack.add(direction)
    );
  }

  
}