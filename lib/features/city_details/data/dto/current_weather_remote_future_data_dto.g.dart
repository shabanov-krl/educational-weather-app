// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_remote_future_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherRemoteFutureDataDto _$CurrentWeatherRemoteFutureDataDtoFromJson(
  Map<String, dynamic> json,
) => CurrentWeatherRemoteFutureDataDto(
  city: json['city'] as String,
  condition: json['condition'] as String,
  tomorrowHigh: (json['tomorrowHigh'] as num).toInt(),
  changes: json['changes'] as String,
);

Map<String, dynamic> _$CurrentWeatherRemoteFutureDataDtoToJson(
  CurrentWeatherRemoteFutureDataDto instance,
) => <String, dynamic>{
  'city': instance.city,
  'condition': instance.condition,
  'tomorrowHigh': instance.tomorrowHigh,
  'changes': instance.changes,
};
