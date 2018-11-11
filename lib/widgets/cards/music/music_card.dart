import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/providers/music_player_provider.dart';
import 'package:omppu_pad/widgets/cards/music/header_controls.dart';
import 'package:omppu_pad/widgets/cards/music/playback_controls.dart';
import 'package:omppu_pad/widgets/cards/music/progress_bar.dart';
import 'package:omppu_pad/widgets/cards/music/track_description.dart';

class MusicCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MusicPlayerProvider(
      child: MusicWidget()
    );
  }
}

class MusicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            HeaderControls(),
            TrackDescription(),
            ProgressBar(),
            PlaybackControls()
          ],
        ),
      ),
    );
  }

}
