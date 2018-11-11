import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:omppu_pad/models/music_player.dart';

class SpotifyAPI {
  static const String _baseUrl = 'https://api.spotify.com/v1';

  SpotifyAPI._();

  // ==================== SPOTIFY REMOTE API ====================
  // Get current state of remote player, as described by the class PlaybackState
  static Future<PlaybackState> getPlayerStatus() async {
    http.Response res = await http.get(
      Uri.parse(
        '$_baseUrl/me/player'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    if (res.body == null) {
      return PlaybackState.fallback();
    }
    Map<String, dynamic> decoded = json.decode(res.body);
    return PlaybackState(
      artist: decoded['item']['artists'].map((artist) => artist['name']).join(', ') ?? '',
      album: decoded['item']['album']['name'] ?? '',
      track: decoded['item']['name'] ?? '',
      progressSeconds: decoded['progress_ms'] / 1000, // TODO add timestamp diff
      durationSeconds: decoded['item']['duration_ms'] / 1000,
      isPlaying: decoded['is_playing'] ?? false,
      isShuffling: decoded['shuffle_state'] ?? false,
      repeatState: decoded['repeat_state'] != null ? trackRepeatFromString(decoded['repeat_state']) : TrackRepeat.off
    );
  }



  // Send a request to stop playback. Will respond with 403 if already stopped.
  // Returns whether the playback is running after calling.
  static Future<bool> pausePlayback([String deviceId = '']) async {
    http.Response res = await http.put(
      Uri.parse(
          '$_baseUrl/me/player/pause'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    if (res.statusCode != 204) return true;
    return false;
  }

  // Send a request to resume playback. Will respond with 403 if already playing.
  // Returns whether the playback is running after calling.
  static Future<bool> resumePlayback([String deviceId = '']) async {
    http.Response res = await http.put(
      Uri.parse('$_baseUrl/me/player/play'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    if (res.statusCode != 204) return false;
    return true;
  }

  // Sends a request to skip to the direction provided as enum.
  // Request will fail if there's no previous/next song in the context 
  // of the player.
  static skipPlayback(TrackSkip direction) async {
    http.post(
      Uri.parse('$_baseUrl/me/player/${describeEnum(direction)}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
  }

  // Send a request to enable/disable track shuffling
  static shufflePlayback(bool shuffle) async {
    http.put(
      Uri.parse('$_baseUrl/me/player/shuffle?state=$shuffle'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
  }

  // Send a request to set the desired repeat mode
  static repeatPlayback(TrackRepeat repeat) async {
    http.put(
      Uri.parse('$_baseUrl/me/player/repeat?state=${describeEnum(repeat)}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
  }

  // ==================== SPOTIFY REFRESH AUTH TOKEN ====================  
  static Future<void> refreshAuthToken() async {
    var bytes = utf8.encode("$_clientId:$_clientSecret");
    var authorization = base64.encode(bytes);
    http.Response res = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic $authorization'
      },
      body: {
        'grant_type': 'refresh_token',
        'refresh_token' : _refreshToken
      }
    );
    print("refresh auth returned: ${res.statusCode}\n\n${res.body}");
    var decoded = json.decode(res.body);
    _accessToken = decoded['access_token'];
    if (decoded['refresh_token'] != null) {
      _refreshToken = decoded['refresh_token'];
    }
    Timer(Duration(seconds: decoded['expires_in']), refreshAuthToken);
  }
  // THIS BELONGS IN A BACKEND SERVICE; TESTING PURPOSES ONLY!
  static const String _clientId = 'd5b9bdddee95456cbccd02f8bb2f09ef';
  static const String _clientSecret = '33d7cdb6e0ae4f3481d3402479ce5ba4';
  // ===================== CLEAN THIS MESS =====================
  static String _accessToken = 'BQBirlraXycYvJUrRAUMNf0O62YbeheEnshR7JypTb_rfAb6iBxqIpcl3609HAZBpLB-0Hko52kXK0FtN9Kn7ZAeaq-SCQX4537AkStE2l0N6nqTrQPVT2wkvMRC-C8FxPl4iT2UhlPPPmp8EdFDFxtU6CKAM7h0u0Wf6375ZZlRm5DNtL8msXmc80u1';
  static String _refreshToken = 'AQB6koxOHczkDu55MvPkD8mKSPaX1-4WwhUJAvfl8EdMc7R8M_WWZbFnkau2BpX3bTMzkmpETiHUVlLdqbE9qv7nky4IW3s7BPCcuAN7IAwBB-LEyuYSAcxa95zYjbwf0vQ';
  // ===================== CLEAN THIS MESS =====================
}