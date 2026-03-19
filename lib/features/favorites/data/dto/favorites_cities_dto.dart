import 'package:json_annotation/json_annotation.dart';

part 'favorites_cities_dto.g.dart';

@JsonSerializable()
class FavoritesCitiesDto {
  final int cityId;
  final String city;
  final int currentTemp;
  final int high;
  final int low;
  final String condition;

  FavoritesCitiesDto({
    required this.cityId,
    required this.city,
    required this.currentTemp,
    required this.high,
    required this.low,
    required this.condition,
  });

  factory FavoritesCitiesDto.fromJson(
    Map<String, dynamic> json,
  ) => _$FavoritesCitiesDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FavoritesCitiesDtoToJson(this);
}
