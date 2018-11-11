import 'dart:async';

import 'package:omppu_pad/api/hsl.dart';
import 'package:omppu_pad/models/transport.dart';
import 'package:rxdart/subjects.dart';

class TransportBloc {
  final _arrivalsController = BehaviorSubject<List<TransportArrival>>();
  final _sortedArrivalsController = BehaviorSubject<List<TransportArrival>>();

  TransportBloc.withInitialLoad(List<String> stopIds) {
    _arrivalsController.listen((list) {
      list.sort((a, b) {
        if (a.serviceDay != b.serviceDay) {
          return a.serviceDay.compareTo(b.serviceDay);
        }
        final aValue =
            a.realtime ? a.realtimeArrival : a.scheduledArrival;
        final bValue =
            b.realtime ? b.realtimeArrival : b.scheduledArrival;
        return aValue.compareTo(bValue);
      });
      _sortedArrivalsController.sink.add(list);
    });
    refreshArrivals(stopIds);
  }

  Future<Null> refreshArrivals(List<String> stopIds) async {
    List<TransportArrival> arrivals = await HslAPI.getStopArrivals(stopIds);
    _arrivalsController.sink.add(arrivals);
    return;
  }

  Stream<List<TransportArrival>> get arrivals => _sortedArrivalsController.stream;

  dispose() {
    _arrivalsController.close();
    _sortedArrivalsController.close();
  }

}