import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/api/spotify.dart';
import 'package:omppu_pad/models/music_player.dart';
import 'package:omppu_pad/widgets/cards/music/header_controls.dart';
import 'package:omppu_pad/widgets/cards/music/progress_bar.dart';
import 'package:omppu_pad/widgets/cards/music/track_description.dart';

class MusicCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  PlaybackState state;

  updateState(){
    new Timer(new Duration(seconds: 1), fetchNewState);
  }

  fetchNewState() async {
    PlaybackState newState = await SpotifyAPI.getCurrentlyPlaying();
    this.setState(() => state = newState);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<PlaybackState>(
      future: SpotifyAPI.getCurrentlyPlaying(),
      builder: (BuildContext context, AsyncSnapshot<PlaybackState> snapshot) {
        if (snapshot.hasData) {
          state = snapshot.data;
        } else {
          state = new PlaybackState.fallback();
        }
        return new Card(
          child: new Padding(
            padding: EdgeInsets.all(1.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new HeaderControls(),
                new TrackDescription(title: state.track, artist: state.artist),
                new ProgressBar(
                  progressSeconds: state.progressSeconds,
                  durationSeconds : state.durationSeconds,
                  isPlaying: state.isPlaying
                ),
                new PlaybackControls(isPlaying: state.isPlaying, triggerReload: updateState)
              ],
            ),
          ),
        );
      }
    );
  }
}
