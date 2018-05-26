import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/styles.dart';

class TransportRow extends StatelessWidget {
  final TransportArrival arrival;
  TransportRow({this.arrival});

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
