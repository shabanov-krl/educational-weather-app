import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/city_details/data/weather_conditions.dart';
import 'package:test_project_weather/features/common/weather_exception.dart';

class FavoritesRemoteDataSource {
  final MyHttpClient _myHttpClient;
  final Random _random = Random();

  FavoritesRemoteDataSource({
    required MyHttpClient myHttpClient,
  }) : _myHttpClient = myHttpClient;

  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    await _myHttpClient.get('https://api.test.com/current_weather/$city');

    if (_random.nextBool()) {
      throw WeatherException('Ошибка загрузки текущего прогноза погоды');
    }

    final currentTemp = 10 + _random.nextInt(15);
    final high = currentTemp + _random.nextInt(5);
    final low = currentTemp - _random.nextInt(6);
    final tomorrowHigh = 10 + _random.nextInt(15);

    return CurrentWeatherModel(
      city: city,
      currentTemp: currentTemp,
      high: high,
      low: low,
      condition: WeatherConditions.random(),
      tomorrowHigh: tomorrowHigh,
      changes: tomorrowHigh > currentTemp ? 'повышение' : 'понижение',
    );
  }

  Future<List<String>> loadCities({
    String assetPath = 'lib/features/favorites/data/map_cities.json',
  }) async {
    final dynamic decoded = jsonDecode(await rootBundle.loadString(assetPath));

    if (decoded is! List<dynamic>) {
      return const [];
    }

    final cities = <String>[];

    for (final item in decoded) {
      if (item is Map<String, dynamic>) {
        final value = item['nameCity'];

        if (value is String) {
          final trimmedValue = value.trim();

          if (trimmedValue.isNotEmpty) {
            cities.add(trimmedValue);
          }
        }
      }
    }

    final unique = cities.toSet().toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return unique;
  }
}
