class TransportStops {
  // TODO enable selection of stops (does HSL allow inspecting transport type by ID????)
  static final Map<String, List<String>> busStopsMap = {
    'Linnanmäki': ['HSL:1122113', 'HSL:1122114'],
    'Pasilan Konepaja': ['HSL:1220117', 'HSL:1220114']
  };

  static final Map<String, List<String>> tramStopsMap = {
    'Kotkankatu': ["HSL:1220430", "HSL:1220431"],
    'Linnanmäki': ['HSL:1122413', 'HSL:1122414'],
  };

  TransportStops._();
}

enum TransportMode { bus, tram }

class TransportArrival {
  final String gtfsId;
  final String headsign;
  final bool realtime;
  final int realtimeArrival;
  final int scheduledArrival;
  final int serviceDay;
  final String shortName;

  TransportArrival({
    this.gtfsId,
    this.headsign,
    this.realtime,
    this.realtimeArrival,
    this.scheduledArrival,
    this.serviceDay,
    this.shortName
  });
}