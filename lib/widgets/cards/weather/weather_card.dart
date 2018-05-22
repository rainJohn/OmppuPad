import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:omppu_pad/models/weather.dart';

import 'package:omppu_pad/utils/statistics.dart';
import 'package:omppu_pad/widgets/cards/weather/day_forecast_column.dart';
import 'package:omppu_pad/api/weather.dart';
import 'package:omppu_pad/styles.dart';

class WeatherCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  DateTime lastUpdate;

  _WeatherCardState() {
    new Timer.periodic(new Duration(minutes: 15), scheduleNextUpdate);
  }

  void scheduleNextUpdate(Timer timer) {
    var now = DateTime.now();
    if (lastUpdate == null || lastUpdate.difference(now).inHours > 2) {
      this.setState(() => lastUpdate = now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        height: 300.0,
        child: new Card(
          child: new FutureBuilder<List<DayForecast>>(
            future: WeatherAPI.getWeatherForecast(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var forecasts = aggregateForecastsByDay(snapshot.data);
                return new Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.gutter,
                    horizontal: Spacing.gutterMini),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: forecasts.map(
                      (dayForecast) => DayForecastColumn(dayForecast: dayForecast),
                    ).toList(),
                  ),
                );
              } else if (snapshot.hasError) {
                return new Center(
                  child: new Text('Failed to fetch weather data.'),
                );
              }
              return new Center(child: new CupertinoActivityIndicator());
            } 
          ),
        ),
      ),
    );
  }
}

// Not happy with this; could use refactoring/rethinking or switching to a better fitting API.
List<DayForecast> aggregateForecastsByDay(List<DayForecast> forecasts) {
  List<DayForecast> aggregatedForecasts = new List<DayForecast>();
  Set<String> dates = Set.from(forecasts.map((f) => f.date.split(' ')[0]));
  List<String> dateList = dates.toList(); // WHY THE HELL CAN I NOT CALL .TOLIST() ABOVE AND AVOID A VAR DEF?
  while (dateList.length > 5) dateList.removeLast();
  dateList.forEach((d) {
    String date;
    int code;
    String description;
    List<num> minimums = [];
    List<num> maximums = [];
    List<DayForecast> sameDayForecasts = forecasts.where(
      (f) => f.date.split(' ')[0] == d
    ).toList();
    sameDayForecasts.forEach((f) {
      minimums.add(f.minTemperature);
      maximums.add(f.maxTemperature);
      if (date == null) date = f.date;
      if (description == null)
        description = Statistics.mode(sameDayForecasts.map((f) => f.description).toList());
      if (code == null)
        code = Statistics.mode(sameDayForecasts.map((f) => f.code).toList());
    });
    if (sameDayForecasts.length != 0) {
      aggregatedForecasts.add(
        new DayForecast(
          code: code,
          date: date,
          description: description,
          minTemperature: minimums.reduce(min),
          maxTemperature: maximums.reduce(max)
        ),
      );
    }
  });
  return aggregatedForecasts;
}
