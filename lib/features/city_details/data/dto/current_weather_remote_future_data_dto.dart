import 'package:json_annotation/json_annotation.dart';

part 'current_weather_remote_future_data_dto.g.dart';

@JsonSerializable()
class CurrentWeatherRemoteFutureDataDto {
  final String city;
  final String condition;
  final int tomorrowHigh;
  final String changes;

  CurrentWeatherRemoteFutureDataDto({
    required this.city,
    required this.condition,
    required this.tomorrowHigh,
    required this.changes,
  });

  factory CurrentWeatherRemoteFutureDataDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherRemoteFutureDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherRemoteFutureDataDtoToJson(this);
}
