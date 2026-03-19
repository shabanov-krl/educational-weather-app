import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_dto.g.dart';

@JsonSerializable()
class DailyWeatherDto {
  final int cityId;
  final String city;
  final String day;
  final int high;
  final int low;
  final String condition;
  final int precipitation;

  DailyWeatherDto({
    required this.cityId,
    required this.city,
    required this.day,
    required this.high,
    required this.low,
    required this.condition,
    required this.precipitation,
  });

  factory DailyWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherDtoToJson(this);
}
