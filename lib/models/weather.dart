class DayForecast {
  final String iconCode;
  final DateTime date;
  final String description;
  final double maxTemperature;
  final double minTemperature;
  final DateTime sunriseTime;
  final DateTime sunsetTime;

  DayForecast({
    this.iconCode,
    this.date,
    this.description,
    this.maxTemperature,
    this.minTemperature,
    this.sunriseTime,
    this.sunsetTime
  });
}