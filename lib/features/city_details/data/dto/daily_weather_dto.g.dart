// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeatherDto _$DailyWeatherDtoFromJson(Map<String, dynamic> json) =>
    DailyWeatherDto(
      cityId: (json['cityId'] as num).toInt(),
      city: json['city'] as String,
      day: json['day'] as String,
      high: (json['high'] as num).toInt(),
      low: (json['low'] as num).toInt(),
      condition: json['condition'] as String,
      precipitation: (json['precipitation'] as num).toInt(),
    );

Map<String, dynamic> _$DailyWeatherDtoToJson(DailyWeatherDto instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'city': instance.city,
      'day': instance.day,
      'high': instance.high,
      'low': instance.low,
      'condition': instance.condition,
      'precipitation': instance.precipitation,
    };
