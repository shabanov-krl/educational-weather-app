// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horly_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeatherModel _$HourlyWeatherModelFromJson(Map<String, dynamic> json) =>
    HourlyWeatherModel(
      city: json['city'] as String,
      time: json['time'] as String,
      temperature: (json['temperature'] as num).toInt(),
      precipitation: (json['precipitation'] as num).toInt(),
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$HourlyWeatherModelToJson(HourlyWeatherModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'time': instance.time,
      'temperature': instance.temperature,
      'precipitation': instance.precipitation,
      'condition': instance.condition,
    };
