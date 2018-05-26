import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:omppu_pad/models/weather.dart';
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
            future: WeatherAPI.getWeatherForecast('60.1695', '24.9354'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.gutter,
                    horizontal: Spacing.gutterMini),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data
                      .where((forecast) => forecast.date.isAfter(DateTime.now()))
                      .take(5)
                      .map(
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
