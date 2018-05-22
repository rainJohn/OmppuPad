import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:omppu_pad/models/music_player.dart';

class SpotifyAPI {
  SpotifyAPI._();
  // ===================== CLEAN THIS MESS =====================
  static String _accessToken = 'BQBirlraXycYvJUrRAUMNf0O62YbeheEnshR7JypTb_rfAb6iBxqIpcl3609HAZBpLB-0Hko52kXK0FtN9Kn7ZAeaq-SCQX4537AkStE2l0N6nqTrQPVT2wkvMRC-C8FxPl4iT2UhlPPPmp8EdFDFxtU6CKAM7h0u0Wf6375ZZlRm5DNtL8msXmc80u1';
  static String _refreshToken = 'AQB6koxOHczkDu55MvPkD8mKSPaX1-4WwhUJAvfl8EdMc7R8M_WWZbFnkau2BpX3bTMzkmpETiHUVlLdqbE9qv7nky4IW3s7BPCcuAN7IAwBB-LEyuYSAcxa95zYjbwf0vQ';
  // ===================== CLEAN THIS MESS =====================

  static const String _baseURL = 'https://api.spotify.com/v1';

  // ==================== SPOTIFY REMOTE API ====================
  // Get current state of remote player, as described by the class PlaybackState
  static Future<PlaybackState> getCurrentlyPlaying() async {
    http.Response res = await http.get(
      Uri.parse(
        '$_baseURL/me/player/currently-playing'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    print("Currently playing returned: ${res.statusCode}\n\n${res.body}");
    if (res.body == null) {
      return new PlaybackState.fallback();
    }
    var decoded = convert.json.decode(res.body);
    PlaybackState ps = new PlaybackState(
      artist: decoded['item']['artists'].map((artist) => artist['name']).join(', '),
      album: decoded['item']['album']['name'],
      track: decoded['item']['name'],
      progressSeconds: decoded['progress_ms'] / 1000,
      durationSeconds: decoded['item']['duration_ms'] / 1000,
      isPlaying: decoded['is_playing']
    );
    return ps;
  }

  // Send a request to stop playback. Will respond with 403 if already stopped.
  // Returns whether the playback is running after calling.
  static Future<bool> pausePlayback([String deviceId = '']) async {
    http.Response res = await http.put(
      Uri.parse(
          '$_baseURL/me/player/pause'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    print("Stopping playback returned: ${res.statusCode}\n\n${res.body}");
    if (res.statusCode != 204) return true;
    return false;
  }

  // Send a request to resume playback. Will respond with 403 if already playing.
  // Returns whether the playback is running after calling.
  static Future<bool> resumePlayback([String deviceId = '']) async {
    http.Response res = await http.put(
      Uri.parse('$_baseURL/me/player/play'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    print("resuming playback returned: ${res.statusCode}\n\n${res.body}");
    if (res.statusCode != 204) return false;
    return true;
  }

  // Sends a request to skip to the direction provided as enum.
  // Request will fail if there's no previous/next song in the context 
  // of the player.
  static skipPlayback(Skip direction) async {
    http.Response res = await http.post(
      Uri.parse('$_baseURL/me/player/${describeEnum(direction)}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_accessToken'
      }
    );
    print("skipping playback returned: ${res.statusCode}\n\n${res.body}");
  }

  // ==================== SPOTIFY REFRESH AUTH TOKEN ====================
  // THIS BELONGS IN A BACKEND SERVICE; TESTING PURPOSES ONLY!
  static const String _clientId = 'd5b9bdddee95456cbccd02f8bb2f09ef';
  static const String _clientSecret = '33d7cdb6e0ae4f3481d3402479ce5ba4';
  static Future<void> refreshAuthToken() async {
    var bytes = convert.utf8.encode("$_clientId:$_clientSecret");
    var authorization = convert.base64.encode(bytes);
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
    var decoded = convert.json.decode(res.body);
    _accessToken = decoded['access_token'];
    if (decoded['refresh_token'] != null) {
      _refreshToken = decoded['refresh_token'];
    }
    new Timer(Duration(seconds: decoded['expires_in']), refreshAuthToken);
  }
}