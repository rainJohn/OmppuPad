import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omppu_pad/models/transport.dart';

class HslAPI {
  HslAPI._();
  // Base function to query the HSL/Digitransit GraphQL API
  static Future<dynamic> _queryHSL(String graphQl) async {
    return http.post(
        Uri.parse(
            'https://api.digitransit.fi/routing/v1/routers/hsl/index/graphql'),
        body: graphQl,
        headers: {'Content-Type': 'application/graphql'});
  }

  static Future<List<Arrival>> getStopArrivals(List<String> stopGtfsIds) async {
    var ids = stopGtfsIds.map((string) => "\"$string\"").join(", ");
    http.Response response = await _queryHSL("""
    {
      stops(ids: [$ids]) {
        gtfsId
        stoptimesWithoutPatterns {
          headsign
          realtime
          realtimeArrival
          scheduledArrival
          serviceDay
          trip{
            route {
              shortName
            }
          }
        }
      }  
    }
    """);
    return _getArrivalsFromJson(utf8.decode(response.bodyBytes));
  }

  static List<Arrival> _getArrivalsFromJson(String jsonString) {
    List<Arrival> result = new List<Arrival>();
    json.decode(jsonString)['data']['stops'].forEach((stop) {
      for (var arrival in stop["stoptimesWithoutPatterns"]) {
        // WHY THE HELL DOES THIS FAIL WITH A MAP FN?!
        result.add(new Arrival(
            gtfsId: stop['gtfsId'],
            headsign: arrival['headsign'],
            realtime: arrival['realtime'],
            realtimeArrival: arrival['realtimeArrival'],
            scheduledArrival: arrival['scheduledArrival'],
            serviceDay: arrival['serviceDay'],
            shortName: arrival['trip']['route']['shortName'],
            ));
      }
    });
    return result;
  }
}
