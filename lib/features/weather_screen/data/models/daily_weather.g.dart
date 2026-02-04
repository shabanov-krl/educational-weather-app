// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeather _$DailyWeatherFromJson(Map<String, dynamic> json) => DailyWeather(
  day: json['day'] as String,
  high: (json['high'] as num).toInt(),
  low: (json['low'] as num).toInt(),
  condition: json['condition'] as String,
  precipitation: (json['precipitation'] as num).toInt(),
);

Map<String, dynamic> _$DailyWeatherToJson(DailyWeather instance) =>
    <String, dynamic>{
      'day': instance.day,
      'high': instance.high,
      'low': instance.low,
      'condition': instance.condition,
      'precipitation': instance.precipitation,
    };
