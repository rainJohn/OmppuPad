import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:omppu_pad/blocs/transport_bloc.dart';
import 'package:omppu_pad/models/transport.dart';
import 'package:omppu_pad/styles.dart';
import 'package:omppu_pad/widgets/cards/transport/arrival_row.dart';

class TransportTab extends StatelessWidget {
  final List<String> stopIds;
  final TransportMode transportMode;
  TransportTab(this.stopIds, this.transportMode);

  @override
  Widget build(BuildContext context) {
    var transportBloc = TransportBloc.withInitialLoad(stopIds);
    return StreamBuilder<List<TransportArrival>>(
      stream: transportBloc.arrivals,
      builder: (BuildContext context, AsyncSnapshot<List<TransportArrival>> snapshot) {
        if (snapshot.hasData) {
          return new RefreshIndicator(
            onRefresh: () => transportBloc.refreshArrivals(stopIds),
            child: ListView.builder(
              padding: EdgeInsets.all(Spacing.gutterMicro),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var nextEntryIndex = index.isOdd
                  ? (index + 1) ~/ 2
                  : index ~/ 2;
                
                if (nextEntryIndex < snapshot.data.length) {
                  return index.isOdd
                    ? Divider()
                    : TransportRow(arrival: snapshot.data[nextEntryIndex]);
                }
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed request to HSL.'));
        }
        return Center(child: CircularProgressIndicator());
      });
  }
}