import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omppu_pad/api/spotify.dart';
import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/music_player.dart';
import 'package:omppu_pad/widgets/cards/music/play_button.dart';
import 'package:omppu_pad/widgets/cards/music/repeat_button.dart';
import 'package:omppu_pad/widgets/cards/music/shuffle_button.dart';

class ProgressBar extends StatefulWidget {
  final double durationSeconds;
  final double progressSeconds;
  final bool isPlaying;

  ProgressBar({this.durationSeconds, this.progressSeconds, this.isPlaying});

  @override
  State<StatefulWidget> createState() => new _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double progress;

  Timer timer;
  @override
  void initState() {
    super.initState();
    progress = widget.progressSeconds;
    instantiateTimer();
  }

  instantiateTimer() {
    timer = Timer.periodic(new Duration(seconds: 1), updateProgress);
  }

  updateProgress(Timer timer) {
    if (widget.isPlaying && ((progress + 1) < widget.durationSeconds)) {
      return this.setState(() => progress++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Slider(
      activeColor: Theme.of(context).textTheme.body2.color,
      max: widget.durationSeconds,
      value: this.progress,
      divisions: widget.durationSeconds.toInt(),
      onChanged: (value) {
        timer.cancel();
        print('about to change slider value');
        this.setState(() => progress = value);
        //call API to update playback
        instantiateTimer();
      }
    );
  }
}

class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final Function triggerReload;

  PlaybackControls({this.isPlaying, this.triggerReload});

  @override
  Widget build(BuildContext context) {
    print('playbackControls: $isPlaying');
    var color = Theme.of(context).textTheme.body2.color;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new ShuffleButton(
            isEnabled: true, onPressed: () => print('todo shuffle')),
        new IconButton(
            iconSize: 20.0,
            icon: new Icon(AppIcons.prevSong, color: color),
            onPressed: () {
              SpotifyAPI.skipPlayback(Skip.previous).then(triggerReload());
            }),
        new PlayButton(isPlaying: isPlaying),
        new IconButton(
            iconSize: 20.0,
            icon: new Icon(AppIcons.nextSong, color: color),
            onPressed: () {
              SpotifyAPI.skipPlayback(Skip.next).then(triggerReload());
            }),
        new RepeatButton(
            repeatMode: Repeat.off, onPressed: () => print('todo repeat'))
      ],
    );
  }
}