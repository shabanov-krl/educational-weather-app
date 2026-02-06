// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentWeatherModel _$CurrentWeatherModelFromJson(Map<String, dynamic> json) =>
    CurrentWeatherModel(
      city: json['city'] as String,
      currentTemp: (json['currentTemp'] as num).toInt(),
      high: (json['high'] as num).toInt(),
      low: (json['low'] as num).toInt(),
      condition: json['condition'] as String,
      tomorrowHigh: (json['tomorrowHigh'] as num).toInt(),
      changes: json['changes'] as String,
    );

Map<String, dynamic> _$CurrentWeatherModelToJson(
  CurrentWeatherModel instance,
) => <String, dynamic>{
  'city': instance.city,
  'currentTemp': instance.currentTemp,
  'high': instance.high,
  'low': instance.low,
  'condition': instance.condition,
  'tomorrowHigh': instance.tomorrowHigh,
  'changes': instance.changes,
};
