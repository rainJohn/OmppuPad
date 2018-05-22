import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:omppu_pad/utils/keychain.dart';

class HueAPI {
  HueAPI._();
  static const int HUE_GROUP_ALL = 0;
  static const int HUE_GROUP_BEDROOM = 1;
  static const int HUE_GROUP_LIVING_ROOM = 2;
  static final _keychain = new Keychain();
  static final _baseUrl = "http://${_keychain.hueBridgeAddress}/api/${_keychain.hueAPIKey}";

  // Toggles all lights on/off, defined by bool value.
  static void toggleLightsByGroup(bool switchOn, int group) async {
    http.put(
        Uri.parse('$_baseUrl/groups/$group/action'),
        body: '{"on": $switchOn}');
  }

  // Returns true if at least one light is on
  static Future<bool> checkAnyLightsOn({int group = HUE_GROUP_ALL}) async {
    http.Response response = await http.get(
      Uri.parse('$_baseUrl/groups/$group'));
    return response.statusCode == 200
      ? json.decode(response.body)['state']['any_on']
      : true; // Fallback for error
  }
}
