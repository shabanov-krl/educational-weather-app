// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeatherDto _$HourlyWeatherDtoFromJson(Map<String, dynamic> json) =>
    HourlyWeatherDto(
      cityId: (json['cityId'] as num).toInt(),
      city: json['city'] as String,
      time: json['time'] as String,
      temperature: (json['temperature'] as num).toInt(),
      precipitation: (json['precipitation'] as num).toInt(),
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$HourlyWeatherDtoToJson(HourlyWeatherDto instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'city': instance.city,
      'time': instance.time,
      'temperature': instance.temperature,
      'precipitation': instance.precipitation,
      'condition': instance.condition,
    };
