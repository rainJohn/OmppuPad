class Statistics {
  Statistics._();

  // Compute the mode/trend of a dataSet of any kind.
  // P.S. the function definition is funny ¯\_(ツ)_/¯
  static dynamic mode(List<dynamic> dataSet) {
    // Ignore empty sets
    if (dataSet.length == 0) return null;

    Map<dynamic, int> datumCount = Map<dynamic, int>();
    dataSet.forEach((datum) =>
      datumCount.containsKey(datum)
        ? datumCount[datum]++
        : datumCount[datum] = 1
    );

    var mode;
    var highestCount = 0;
    datumCount.forEach((datum, count) {
      if (count > highestCount) {
        mode = datum;
        highestCount = count;
      }
    });
    return mode;
  }
}