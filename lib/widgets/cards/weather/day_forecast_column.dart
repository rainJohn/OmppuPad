import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/weather.dart';

class DayForecastColumn extends StatelessWidget {
  final DayForecast dayForecast;

  DayForecastColumn({@required this.dayForecast});

  String getTemperatureRange() {
    var min = kelvinToCelsius(dayForecast.minTemperature);
    var max = kelvinToCelsius(dayForecast.maxTemperature);
    return "$min - $max°C";
  }

  @override
  Widget build(BuildContext context) {
    bool isToday = isDateTimeToday(DateTime.parse(dayForecast.date));
    TextStyle style = isToday
      ? Theme.of(context).textTheme.body2
      : Theme.of(context).textTheme.body1;
    return new Container(
      decoration: new BoxDecoration(
        color: isToday
          ? Theme.of(context).selectedRowColor
          : Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(new Radius.circular(5.0))),
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(dateTimeStringToWeekday(dayForecast.date), style: style),
          new Image(image: getImageByWeatherCode(dayForecast.code)),
          new Text(getTemperatureRange(), style: style)
        ]
      ),
    );
  }
}

// dynamic as either int or double may arrive at runtime, without locking to single type.
// However this makes it unsafe. Union types would be great here...
String kelvinToCelsius(dynamic kelvin) {
  return (kelvin - 273.15).round().toString();
}

isDateTimeToday(DateTime dateTime) =>
  dateTime.weekday == DateTime.now().weekday;

String dateTimeStringToWeekday(String string) {
  DateTime dateTime = DateTime.parse(string);
  if (isDateTimeToday(dateTime)) return 'Today';
  return new DateFormat('EEEE').format(dateTime);
}

// refer to https://openweathermap.org/weather-conditions for codes and meanings
AssetImage getImageByWeatherCode(int code) {
  if (code >= 200 && code < 300) return AppIcons.thunderstorm;
  if (code >= 300 && code < 400) return AppIcons.drizzle;
  if (code >= 500 && code < 600) return AppIcons.rain;
  if (code >= 600 && code < 700) return AppIcons.snow;
  if (code >= 700 && code < 800) return AppIcons.fog;
  if (code == 800) return AppIcons.clear;
  return AppIcons.clouds;
}
