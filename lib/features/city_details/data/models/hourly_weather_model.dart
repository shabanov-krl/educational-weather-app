class HourlyWeatherModel {
  final int cityId;
  final String city;
  final String time;
  final int temperature;
  final int precipitation;
  final String condition;

  HourlyWeatherModel({
    required this.cityId,
    required this.city,
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.condition,
  });
}
