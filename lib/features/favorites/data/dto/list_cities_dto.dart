import 'package:json_annotation/json_annotation.dart';

part 'list_cities_dto.g.dart';

@JsonSerializable()
class ListCitiesDto {
  final int cityId;
  final String city;

  ListCitiesDto({
    required this.cityId,
    required this.city,
  });

  factory ListCitiesDto.fromJson(
    Map<String, dynamic> json,
  ) => _$ListCitiesDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListCitiesDtoToJson(this);
}
