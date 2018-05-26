import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:omppu_pad/app_icons.dart';
import 'package:omppu_pad/models/weather.dart';

class DayForecastColumn extends StatelessWidget {
  final DayForecast dayForecast;

  DayForecastColumn({@required this.dayForecast});

  String getTemperatureRange() {
    var min = dayForecast.minTemperature.toInt();
    var max = dayForecast.maxTemperature.toInt();
    return "$min - $max° C";
  }

  @override
  Widget build(BuildContext context) {
    bool isToday = isDateTimeToday(dayForecast.date);
    TextStyle style = isToday
      ? Theme.of(context).textTheme.body2
      : Theme.of(context).textTheme.body1;
    return Container(
      decoration: BoxDecoration(
        color: isToday
          ? Theme.of(context).selectedRowColor
          : Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            isToday ? 'Today' : DateFormat('EEEE').format(dayForecast.date),
            style: style
          ),
          Image(image: getImageByWeatherCode(dayForecast.iconCode)),
          Text(getTemperatureRange(), style: style)
        ]
      ),
    );
  }
}

isDateTimeToday(DateTime dateTime) =>
  dateTime.weekday == DateTime.now().weekday;

// refer to https://openweathermap.org/weather-conditions for codes and meanings
AssetImage getImageByWeatherCode(String code) {
  switch(code) {
    case 'clear':
    case 'clear-day':
    case 'clear-night':
      return AppIcons.clear;
    case 'rain':
      return AppIcons.rain;
    case 'snow':
      return AppIcons.snow;
    case 'sleet':
      return AppIcons.sleet;
    case 'wind':
      return AppIcons.cloudy;
    case 'fog':
      return AppIcons.fog;
    case 'cloudy':
    case 'partly-cloudy-day':
    case 'partly-cloudy-night':
      return AppIcons.cloudy;
    case 'storm':
      return AppIcons.storm;
    default:
      return AppIcons.cloudy;
  }
}
