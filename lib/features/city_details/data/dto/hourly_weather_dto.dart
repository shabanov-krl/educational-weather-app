import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather_dto.g.dart';

@JsonSerializable()
class HourlyWeatherDto {
  final int cityId;
  final String city;
  final String time;
  final int temperature;
  final int precipitation;
  final String condition;

  HourlyWeatherDto({
    required this.cityId,
    required this.city,
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.condition,
  });

  factory HourlyWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherDtoToJson(this);
}
