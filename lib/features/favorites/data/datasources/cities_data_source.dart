import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:test_project_weather/features/common/weather_exception.dart';
import 'package:test_project_weather/features/favorites/data/dto/list_cities_dto.dart';


class CitiesDataSource {

  Future<List<ListCitiesDto>> getListCities() async {
    try {
      final rawJson = await rootBundle.loadString('lib/features/favorites/data/cites_mock_data.json');
      final decoded = jsonDecode(rawJson);

      if (decoded is! List) {
        throw const FormatException('Некорректный формат списка городов');
      }

      final listCities = <ListCitiesDto>[];

      for (final item in decoded) {
        if (item is! Map) {
          continue;
        }

        final cityJson = Map<String, dynamic>.from(item);
        final mappedJson = <String, dynamic>{
          'cityId': cityJson['ID'],
          'city': cityJson['nameCity'],
        };

        final cityId = mappedJson['cityId'];
        final cityName = mappedJson['city'];
        if (cityId is! num || cityName is! String || cityName.trim().isEmpty) {
          continue;
        }

        listCities.add(
          ListCitiesDto.fromJson({
            'cityId': cityId.toInt(),
            'city': cityName.trim(),
          }),
        );
      }

      return listCities;
    } catch (error) {
      throw WeatherException('Ошибка загрузки списка городов: $error');
    }
  }

}
