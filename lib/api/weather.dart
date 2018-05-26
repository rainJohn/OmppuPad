import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:omppu_pad/models/weather.dart';
import 'package:omppu_pad/utils/keychain.dart';

class WeatherAPI {
  WeatherAPI._();
  static final Keychain _keychain = Keychain();
  static final _url = 'https://api.darksky.net/forecast';
  static final _queryParams = '?exclude=currently,minutely,hourly,alerts,flags&units=auto';

  static Future<List<DayForecast>> getWeatherForecast(String latitude, String longitude) async {
    final response = await http.get(
      "$_url/${_keychain.darkSkyAPIKey}/$latitude,$longitude$_queryParams");
    return _dayForecastsFromJson(response.body);
  }

  static List<DayForecast> _dayForecastsFromJson(String jsonString) {
    List<DayForecast> list = List<DayForecast>();
    Map decoded = json.decode(jsonString);
    decoded['daily']['data'].forEach((day) =>
      list.add(
        DayForecast(
          iconCode: day['summary'].contains(RegExp('thunder|storm|blizzard|tempest')) ? 'storm' : day['icon'],
          date: DateTime.fromMillisecondsSinceEpoch(day['time'] * 1000),
          description: day['summary'],
          maxTemperature: day['temperatureHigh'],
          minTemperature: day['temperatureLow'],
          sunriseTime: DateTime.fromMillisecondsSinceEpoch(day['sunriseTime'] * 1000),
          sunsetTime: DateTime.fromMillisecondsSinceEpoch(day['sunsetTime'] * 1000),
        ),
      ),
    );
    return list;
  }
}