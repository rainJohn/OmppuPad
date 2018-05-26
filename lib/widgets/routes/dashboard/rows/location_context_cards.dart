import 'package:flutter/material.dart';

import 'package:omppu_pad/widgets/cards/clock_card.dart';
import 'package:omppu_pad/widgets/cards/weather/weather_card.dart';

class LocationContextCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ClockCard(), WeatherCard()],
      ),
    );
  }
}
