import 'package:flutter/foundation.dart';

class PlaybackState {
  String artist;
  String album;
  String track;
  double progressSeconds;
  double durationSeconds;
  bool isPlaying;
  bool isShuffling;
  TrackRepeat repeatState;

  
  PlaybackState({
    this.artist,
    this.album,
    this.track,
    this.progressSeconds,
    this.durationSeconds,
    this.isPlaying,
    this.isShuffling,
    this.repeatState
  });

  PlaybackState.fallback() {
    artist = '';
    album = '';
    track = '';
    progressSeconds = 0.0;
    durationSeconds= 100.0;
    isPlaying = false;
    isShuffling = false;
    repeatState = TrackRepeat.off;
  }
}

enum TrackSkip { next, previous }
enum TrackRepeat { track, context, off }

trackRepeatFromString(String string) {
  return TrackRepeat.values.firstWhere(((e) => describeEnum(e) == string));
}