import 'package:flutter/material.dart';

import 'package:omppu_pad/widgets/cards/battery_card.dart';
import 'package:omppu_pad/widgets/cards/lights_card.dart';
import 'package:omppu_pad/widgets/cards/music/music_card.dart';
import 'package:omppu_pad/widgets/cards/transport_stop_card.dart';

// TODO enable selection of stops (does HSL allow inspecting transport type by ID????)
const Map<String, List<String>> busStopsMap = {
  'Linnanmäki': ['HSL:1122113', 'HSL:1122114'],
  'Pasilan Konepaja': ['HSL:1220117', 'HSL:1220114']
};

const Map<String, List<String>> tramStopsMap = {
  'Kotkankatu': ["HSL:1220430", "HSL:1220431"],
  'Linnanmäki': ['HSL:1122413', 'HSL:1122414'],
};

class FooterRow extends StatelessWidget {
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
              tramStopsMap,
              0
            )
          ),
          new Expanded(
            child: new TransportStopCard(
              Icons.directions_bus,
              'Bus Arrivals',
              TransportMode.bus,
              busStopsMap,
              1
            )
          )
        ],
      )
    );
  }
}
