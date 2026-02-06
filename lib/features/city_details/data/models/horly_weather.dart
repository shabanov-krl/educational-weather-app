import 'package:json_annotation/json_annotation.dart';

part 'horly_weather.g.dart';

@JsonSerializable()
class HourlyWeatherModel {
  final String city;
  final String time;
  final int temperature;
  final int precipitation;
  final String condition;

  HourlyWeatherModel({
    required this.city,
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.condition,
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherModelToJson(this);
}
