import 'dart:async';

import 'package:omppu_pad/api/spotify.dart';
import 'package:rxdart/subjects.dart';

import 'package:omppu_pad/models/music_player.dart';

class MusicPlayerBloc {
  // Main pipe. The rest are mostly surrogates to stream output.
  static final _playbackStateController = BehaviorSubject<PlaybackState>(seedValue: PlaybackState.fallback());

  static final _trackController = BehaviorSubject<String>();
  static final _artistController = BehaviorSubject<String>();
  static final _playbackController = BehaviorSubject<bool>();
  static final _skipController = BehaviorSubject<TrackSkip>();
  static final _progressController = BehaviorSubject<double>();
  static final _durationController = BehaviorSubject<double>();
  static final _shuffleController = BehaviorSubject<bool>();
  static final _repeatController = BehaviorSubject<TrackRepeat>();

  
  MusicPlayerBloc() {
    // this handles a full state update (such as skipping tracks or init load)
    _playbackStateController.listen((PlaybackState newState) {
      _trackController.add(newState.track);
      _artistController.add(newState.artist);
      _progressController.add(newState.progressSeconds);
      _durationController.add(newState.durationSeconds);
    });

    _playbackController.listen((bool isPlaying) async {
      var handler = isPlaying ? SpotifyAPI.pausePlayback : SpotifyAPI.resumePlayback;
      // we have to double check whether the op completed or not and re-set accordingly
      bool isPlayingAfterHandler = await handler();
      if (isPlaying != isPlayingAfterHandler) {
        _playbackController.sink.add(isPlayingAfterHandler);
      } 
    });

    _skipController.listen((TrackSkip direction) {
      SpotifyAPI.skipPlayback(direction).then(updatePlaybackState());
    });

    _shuffleController.listen((bool shuffle) => SpotifyAPI.shufflePlayback(shuffle));

    _repeatController.listen((TrackRepeat mode) => SpotifyAPI.repeatPlayback(mode));

    updatePlaybackState();
  }

  updatePlaybackState() async {
    // TODO INVESTIGATE: If the request isn't delayed, we get the track playing before an update.
    var playbackState = await Future.delayed(Duration(seconds: 2), SpotifyAPI.getCurrentlyPlaying);
    _playbackStateController.sink.add(playbackState);
  }

  // read-only accessors
  Stream<String> get track => _trackController.stream;
  Stream<String> get artist => _artistController.stream;
  Stream<double> get duration => _durationController.stream;

  // play/pause
  Stream<bool> get isPlaying => _playbackController.stream;
  Sink<bool> get onIsPlayingChanged => _playbackController.sink;

  // skip
  Sink<TrackSkip> get onSkipTrack => _skipController.sink;

  // progress bar
  Stream<double> get progress => _progressController.stream;
  Sink<double> get onProgressChanged => _progressController.sink;

  // shuffle
  Stream<bool> get isShuffling => _shuffleController.stream;
  Sink<bool> get onIsShufflingChanged => _shuffleController.sink;

  // repeat
  Stream<TrackRepeat> get repeatMode => _repeatController.stream;
  Sink<TrackRepeat> get onRepeatModeChanged => _repeatController.sink;


  void dispose() {
    _playbackStateController.close();
    _trackController.close();
    _artistController.close();
    _progressController.close();
    _durationController.close();
    _playbackController.close();
    _shuffleController.close();
    _repeatController.close();
  }
  
}