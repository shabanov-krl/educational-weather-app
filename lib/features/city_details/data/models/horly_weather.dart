import 'package:json_annotation/json_annotation.dart';

part 'horly_weather.g.dart';

@JsonSerializable()
class HourlyWeather {
  final String time;
  final int temperature;
  final int precipitation;
  final String condition;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.condition,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherToJson(this);
}
