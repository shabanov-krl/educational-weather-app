import 'package:json_annotation/json_annotation.dart';

part 'current_weather.g.dart';

// TODO(kshabanov): add postfix Model for model classes
@JsonSerializable()
class CurrentWeather {
  final String city;
  final int currentTemp;
  final int high;
  final int low;
  final String condition;
  final int tomorrowHigh;
  final String changes;

  CurrentWeather({
    required this.city,
    required this.currentTemp,
    required this.high,
    required this.low,
    required this.condition,
    required this.tomorrowHigh,
    required this.changes,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}
