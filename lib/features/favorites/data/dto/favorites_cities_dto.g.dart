// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_cities_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesCitiesDto _$FavoritesCitiesDtoFromJson(Map<String, dynamic> json) =>
    FavoritesCitiesDto(
      cityId: (json['cityId'] as num).toInt(),
      city: json['city'] as String,
      currentTemp: (json['currentTemp'] as num).toInt(),
      high: (json['high'] as num).toInt(),
      low: (json['low'] as num).toInt(),
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$FavoritesCitiesDtoToJson(FavoritesCitiesDto instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'city': instance.city,
      'currentTemp': instance.currentTemp,
      'high': instance.high,
      'low': instance.low,
      'condition': instance.condition,
    };
