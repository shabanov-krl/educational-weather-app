import 'package:json_annotation/json_annotation.dart';

part 'daily_weather.g.dart';

@JsonSerializable()
class DailyWeatherModel {
  final String city;
  final String day;
  final int high;
  final int low;
  final String condition;
  final int precipitation;

  DailyWeatherModel({
    required this.city,
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.precipitation,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherModelToJson(this);
}
