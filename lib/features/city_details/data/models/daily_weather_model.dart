class DailyWeatherModel {
  final int cityId;
  final String city;
  final String day;
  final int high;
  final int low;
  final String condition;
  final int precipitation;

  DailyWeatherModel({
    required this.cityId,
    required this.city,
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.precipitation,
  });
}
