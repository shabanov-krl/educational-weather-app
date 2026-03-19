// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_cities_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListCitiesDto _$ListCitiesDtoFromJson(Map<String, dynamic> json) =>
    ListCitiesDto(
      cityId: (json['cityId'] as num).toInt(),
      city: json['city'] as String,
    );

Map<String, dynamic> _$ListCitiesDtoToJson(ListCitiesDto instance) =>
    <String, dynamic>{'cityId': instance.cityId, 'city': instance.city};
