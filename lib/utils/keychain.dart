import 'dart:async';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/* 
  A singleton meant to load any configuration 
  variables and keys for the app, hence "keychain".
  Loaded before app startup (main.dart).
*/
class Keychain {
  String hueAPIKey;
  String hueBridgeAddress;
  String darkSkyAPIKey;

  static final Keychain _singleton = Keychain._internal();

  factory Keychain() {
    return _singleton;
  }

  Keychain._internal();

  // Any new items added to keychain.yml should be added 
  // as class attributes and loaded here:
  Future<void> loadKeys() async {
    // this should load an encrypted file and decipher it before usage and disposal.
    var yamlString = await rootBundle.loadString('lib/assets/keychain.yml');
    var keychain = loadYaml(yamlString);
    hueAPIKey = keychain['hue_api_key'];
    hueBridgeAddress = keychain['hue_bridge_addr'];
    darkSkyAPIKey = keychain['dark_sky_api_key'];
  }
}