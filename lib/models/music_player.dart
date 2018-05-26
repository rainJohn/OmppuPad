class PlaybackState {
  String artist;
  String album;
  String track;
  double progressSeconds;
  double durationSeconds;
  bool isPlaying;
  
  PlaybackState({
    this.artist,
    this.album,
    this.track,
    this.progressSeconds,
    this.durationSeconds,
    this.isPlaying
  });

  PlaybackState.fallback() {
    artist = '';
    album = '';
    track = '';
    progressSeconds = 0.0;
    durationSeconds= 100.0;
    isPlaying = false;
  }
}

enum TrackSkip { next, previous }
enum TrackRepeat { track, context, off }