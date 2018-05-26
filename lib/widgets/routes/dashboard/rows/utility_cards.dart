import 'package:flutter/material.dart';

import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/widgets/cards/battery_card.dart';
import 'package:omppu_pad/widgets/cards/lights_card.dart';
import 'package:omppu_pad/widgets/cards/music/music_card.dart';
import 'package:omppu_pad/widgets/cards/transport/transport_stop_card.dart';

class UtilityCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 350.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            width: 300.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Expanded(child: new MusicCard()),
                new LightsCard(),
                new BatteryCard()
              ],
            ),
          ),
          new Expanded(
            child: new TransportStopCard(
              Icons.directions_railway,
              'Tram Arrivals',
              TransportMode.tram,
              TransportStops.tramStopsMap,
              0
            )
          ),
          new Expanded(
            child: new TransportStopCard(
              Icons.directions_bus,
              'Bus Arrivals',
              TransportMode.bus,
              TransportStops.busStopsMap,
              1
            )
          )
        ],
      )
    );
  }
}
