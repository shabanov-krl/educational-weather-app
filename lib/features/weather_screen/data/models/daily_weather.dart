import 'package:json_annotation/json_annotation.dart';

part 'daily_weather.g.dart';

@JsonSerializable()
class DailyWeather {
  final String day;
  final int high;
  final int low;
  final String condition;
  final int precipitation;

  DailyWeather({
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.precipitation,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherToJson(this);
}
