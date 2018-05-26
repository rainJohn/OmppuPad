import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/api/hsl.dart';
import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/styles.dart';
import 'package:omppu_pad/widgets/cards/transport/arrival_row.dart';

class TransportTab extends StatelessWidget {
  final List<String> stopIds;
  final TransportMode transportMode;
  TransportTab(this.stopIds, this.transportMode);

  List<Widget> buildArrivalItems(List<TransportArrival> arrivals) {
    return arrivals.map((arrival) => TransportRow(arrival: arrival)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransportArrival>>(
      future: HslAPI.getStopArrivals(stopIds),
      builder: (BuildContext context, AsyncSnapshot<List<TransportArrival>> snapshot) {
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

          return ListView.builder(
            padding: EdgeInsets.all(Spacing.gutterMicro),
            itemBuilder: (context, index) {
              var nextEntryIndex = index.isOdd
                ? (index + 1) ~/ 2
                : index ~/ 2;
              
              if (nextEntryIndex < snapshot.data.length) {
                return index.isOdd
                  ? Divider()
                  : TransportRow(
                      arrival: snapshot.data[nextEntryIndex]
                    );
              }
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed request to HSL.'));
        }
        return Center(child: CupertinoActivityIndicator());
      });
  }
}