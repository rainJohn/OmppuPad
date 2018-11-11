import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/widgets/cards/transport/transport_tab.dart';

class TransportStopCard extends StatelessWidget {
  final String title;
  final TransportMode transportMode;
  final Map<String, List<String>> stops;
  final int initialTab;

  TransportStopCard(
    this.title,
    this.transportMode,
    this.stops,
    this.initialTab
  );

  List<Tab> getTitleTabsFromStops() {
    return stops.keys
      .map((stopName) => new Tab(text: stopName))
      .toList();
  }

  List<TransportTab> getTransportTabsFromStops() {
    return stops.values
      .map((stopIds) => new TransportTab(stopIds, transportMode))
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Theme.of(context).primaryColorDark,
      child: new Container(
        height: 350.0,
        child: new DefaultTabController(
          initialIndex: initialTab,
          length: 3,
          child: Scaffold(
            appBar: new AppBar(
              backgroundColor: Theme.of(context).cardColor,
              leading: new Icon(
                transportMode == TransportMode.bus
                  ? Icons.directions_bus
                  : Icons.directions_railway
              ),
              title: new Text(title,
                style: Theme.of(context).textTheme.body2),
              bottom: new TabBar(
                tabs: getTitleTabsFromStops(),
              )),
            body: new TabBarView(
              children: getTransportTabsFromStops(),
            ),
          ),
        ),
      ),
    );
  }
}