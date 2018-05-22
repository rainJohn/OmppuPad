import 'package:flutter/cupertino.dart';

/* 
  This class is meant to provide access to any icons loaded as images,
  and font icons not loaded by default in Flutter (e.g. extended 
  iOS font-family icons).
*/
class AppIcons {
  AppIcons._();

  static const fontFamily = 'CupertinoIcons';
  static const fontPackage = 'cupertino_icons';

  // battery icons
  static const batteryEmpty =
    const IconData(0xf112, fontFamily: fontFamily, fontPackage: fontPackage);
  static const battery25 =
    const IconData(0xf115, fontFamily: fontFamily, fontPackage: fontPackage);
  static const battery75 =
    const IconData(0xf114, fontFamily: fontFamily, fontPackage: fontPackage);
  static const batteryFull =
    const IconData(0xf113, fontFamily: fontFamily, fontPackage: fontPackage);
  static const batteryCharging =
    const IconData(0xf111, fontFamily: fontFamily, fontPackage: fontPackage);

  // playback icons
  static const shuffle =
    const IconData(0xF4A8, fontFamily: fontFamily, fontPackage: fontPackage);
  static const prevSong =
    const IconData(0xF4AB, fontFamily: fontFamily, fontPackage: fontPackage);
  static const nextSong =
    const IconData(0xF4AD, fontFamily: fontFamily, fontPackage: fontPackage);
  static const play =
    const IconData(0xF488, fontFamily: fontFamily, fontPackage: fontPackage);
  static const pause = 
    const IconData(0xF478, fontFamily: fontFamily, fontPackage: fontPackage);
  static const repeat =
    const IconData(0xF3B1, fontFamily: fontFamily, fontPackage: fontPackage);
  static const repeatOne =
    const IconData(0xF49D, fontFamily: fontFamily, fontPackage: fontPackage);

  // weather icons
  static const AssetImage thunderstorm = const AssetImage('lib/assets/images/storm.png');
  static const AssetImage drizzle = const AssetImage('lib/assets/images/drizzle.png');
  static const AssetImage rain = const AssetImage('lib/assets/images/rain.png');
  static const AssetImage snow = const AssetImage('lib/assets/images/snow.png');
  static const AssetImage fog = const AssetImage('lib/assets/images/fog.png');
  static const AssetImage clear = const AssetImage('lib/assets/images/clear.png');
  static const AssetImage clouds = const AssetImage('lib/assets/images/clouds.png');
}


