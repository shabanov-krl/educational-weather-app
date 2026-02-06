// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather_remote_today_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherRemoteTodayDataDto _$CurrentWeatherRemoteTodayDataDtoFromJson(
  Map<String, dynamic> json,
) => CurrentWeatherRemoteTodayDataDto(
  city: json['city'] as String,
  currentTemp: (json['currentTemp'] as num).toInt(),
  high: (json['high'] as num).toInt(),
  low: (json['low'] as num).toInt(),
);

Map<String, dynamic> _$CurrentWeatherRemoteTodayDataDtoToJson(
  CurrentWeatherRemoteTodayDataDto instance,
) => <String, dynamic>{
  'city': instance.city,
  'currentTemp': instance.currentTemp,
  'high': instance.high,
  'low': instance.low,
};
