import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:omppu_pad/models/weather.dart';
import 'package:omppu_pad/utils/keychain.dart';

class WeatherAPI {
  WeatherAPI._();
  static final Keychain _keychain = new Keychain();

  static Future<List<DayForecast>> getWeatherForecast() async {
    final response = await http.get(
      "http://api.openweathermap.org/data/2.5/forecast?q=Helsinki,fi&APPID=${_keychain.openWeatherMapAPIKey}");
    print('weather responded: ${response.statusCode}');
    return _dayForecastsFromJson(response.body);
  }

  static List<DayForecast> _dayForecastsFromJson(String jsonString) {
    List<DayForecast> list = new List<DayForecast>();
    Map decoded = json.decode(jsonString);
    decoded['list'].forEach((day) =>
      list.add(
        DayForecast(
          code: day['weather'][0]['id'],
          date: day['dt_txt'],
          description: day['weather'][0]['description'],
          maxTemperature: day['main']['temp_max'],
          minTemperature: day['main']['temp_min']
        )
      )
    );
    return list;
  }
}