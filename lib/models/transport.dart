class Arrival {
  final String gtfsId;
  final String headsign;
  final bool realtime;
  final int realtimeArrival;
  final int scheduledArrival;
  final int serviceDay;
  final String shortName;

  Arrival(
      {this.gtfsId,
      this.headsign,
      this.realtime,
      this.realtimeArrival,
      this.scheduledArrival,
      this.serviceDay,
      this.shortName});
}