// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeatherModel _$DailyWeatherModelFromJson(Map<String, dynamic> json) =>
    DailyWeatherModel(
      city: json['city'] as String,
      day: json['day'] as String,
      high: (json['high'] as num).toInt(),
      low: (json['low'] as num).toInt(),
      condition: json['condition'] as String,
      precipitation: (json['precipitation'] as num).toInt(),
    );

Map<String, dynamic> _$DailyWeatherModelToJson(DailyWeatherModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'day': instance.day,
      'high': instance.high,
      'low': instance.low,
      'condition': instance.condition,
      'precipitation': instance.precipitation,
    };
