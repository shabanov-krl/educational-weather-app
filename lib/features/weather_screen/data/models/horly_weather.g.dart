// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horly_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeather _$HourlyWeatherFromJson(Map<String, dynamic> json) =>
    HourlyWeather(
      time: json['time'] as String,
      temperature: (json['temperature'] as num).toInt(),
      precipitation: (json['precipitation'] as num).toInt(),
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$HourlyWeatherToJson(HourlyWeather instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature': instance.temperature,
      'precipitation': instance.precipitation,
      'condition': instance.condition,
    };
