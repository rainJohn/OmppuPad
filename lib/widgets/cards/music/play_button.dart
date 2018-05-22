import 'package:flutter/material.dart';
import 'package:omppu_pad/api/spotify.dart';
import 'package:omppu_pad/app_icons.dart';

class PlayButton extends StatefulWidget {
  final bool isPlaying;

  PlayButton({this.isPlaying}) {
    print('PlayButton: $isPlaying');
  }

    @override
  State<StatefulWidget> createState() => new _PlayButtonState(isPlaying: isPlaying);
}

class _PlayButtonState extends State<PlayButton> {
  bool isPlaying;

  _PlayButtonState({this.isPlaying});

  Widget getIcon(Color color) {
    if (isPlaying) {
      return new Icon(AppIcons.pause, size: 25.0, color: color);
    }
    return new Padding(
      padding: EdgeInsets.only(left: 4.0),
      child: new Icon(AppIcons.play, size: 25.0, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('PlayButtonState: $isPlaying');
    var color = Theme.of(context).textTheme.body2.color;
    return new IconButton(
      iconSize: 45.0,
      onPressed: () async {
        print('onPressed: $isPlaying');
        var handler = isPlaying ? SpotifyAPI.pausePlayback : SpotifyAPI.resumePlayback;
        this.setState(() => this.isPlaying = !this.isPlaying);
        bool isPlayingAfterHandler = await handler();
        if (isPlayingAfterHandler != this.isPlaying) {
          this.setState(() => this.isPlaying = isPlayingAfterHandler);
        }
      },
      icon: new Container(
        height: 45.0,
        width: 45.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(
            color: color,
            width: 1.0,
          ),
        ),
        child: getIcon(color),
      ),
    );
  }
}