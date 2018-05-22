import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:omppu_pad/api/hsl.dart';
import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/styles.dart';

enum TransportMode { bus, tram }

// TODO MAKE STATELESS
class TransportStopCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final TransportMode transportMode;
  final Map<String, List<String>> stops;
  final int initialTab;

  TransportStopCard(
    this.icon,
    this.title,
    this.transportMode,
    this.stops,
    this.initialTab
  );

  @override
  State<StatefulWidget> createState() => _TransportStopCardState();
}

class _TransportStopCardState extends State<TransportStopCard> {
  _TransportStopCardState();

  List<Tab> getTitleTabsFromStops() {
    return widget.stops.keys
      .map((stopName) => new Tab(text: stopName))
      .toList();
  }

  List<TransportTab> getTransportTabsFromStops() {
    return widget.stops.values
      .map((stopIds) => new TransportTab(stopIds, widget.transportMode))
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Theme.of(context).primaryColorDark,
      child: new Container(
        height: 350.0,
        child: new DefaultTabController(
          initialIndex: widget.initialTab,
          length: 3,
          child: Scaffold(
            appBar: new AppBar(
              backgroundColor: Theme.of(context).cardColor,
              leading: new Icon(widget.icon),
              title: new Text(widget.title,
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

class TransportTab extends StatelessWidget {
  final List<String> stopIds;
  final TransportMode transportMode;
  TransportTab(this.stopIds, this.transportMode);

  List<Widget> buildArrivalItems(List<Arrival> arrivals) {
    return arrivals.map((arrival) => new ArrivalRow(arrival: arrival)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Arrival>>(
      future: HslAPI.getStopArrivals(stopIds),
      builder: (BuildContext context, AsyncSnapshot<List<Arrival>> snapshot) {
        if (snapshot.hasData) {
          snapshot.data.sort((a, b) {
            if (a.serviceDay != b.serviceDay) {
              return a.serviceDay.compareTo(b.serviceDay);
            }
            final aValue =
                a.realtime ? a.realtimeArrival : a.scheduledArrival;
            final bValue =
                b.realtime ? b.realtimeArrival : b.scheduledArrival;
            return aValue.compareTo(bValue);
          });

          return new ListView.builder(
            padding: EdgeInsets.all(Spacing.gutterMicro),
            itemBuilder: (context, index) {
              var nextEntryIndex = index.isOdd
                ? (index + 1) ~/ 2
                : index ~/ 2;
              
              if (nextEntryIndex < snapshot.data.length) {
                return index.isOdd
                  ? new Divider()
                  : new ArrivalRow(
                      arrival: snapshot.data[nextEntryIndex]
                    );
              }
            },
          );
        } else if (snapshot.hasError) {
          return new Center(child: new Text('Failed request to HSL.'));
        }
        return new Center(child: new CupertinoActivityIndicator());
      });
  }
}

class ArrivalRow extends StatelessWidget {
  final Arrival arrival;
  ArrivalRow({this.arrival});

  final dateFormat = new DateFormat('HH:mm');

  // HSL returns the arrival date in seconds (for the current day),
  // so we have to transform the date to a human-readable format.
  String getArrivalTime() {
    num arrivalInSeconds =
      arrival.realtime ? arrival.realtimeArrival : arrival.scheduledArrival;
    return dateFormat.format(
      new DateTime(DateTime.now().year, 0, 0, 0, 0, arrivalInSeconds, 0, 0));
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(Spacing.gutterMicro),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 40.0,
                  child: new Text(arrival.shortName,
                    style: Theme.of(context).textTheme.body2)),
                new Text(
                  arrival.headsign,
                  style: Theme.of(context).textTheme.body1.merge(
                    new TextStyle(fontSize: FontSize.smallText)
                  ),
                  overflow: TextOverflow.fade
                ),
              ],
            ),
          ),
          new Text(getArrivalTime(), textAlign: TextAlign.end),
        ],
      ),
    );
  }
}
