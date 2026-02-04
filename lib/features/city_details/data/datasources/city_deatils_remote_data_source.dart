import 'dart:math';

import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/daily_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/horly_weather.dart';
import 'package:test_project_weather/features/city_details/data/weather_conditions.dart';
import 'package:test_project_weather/features/common/weather_exception.dart';

// TODO(kshabanov): rename to CityDetailsRemoteDataSource
class WeatherScreenRemoteDataSource {
  final MyHttpClient _myHttpClient;
  final _rnd = Random();

  WeatherScreenRemoteDataSource({
    required MyHttpClient myHttpClient,
  }) : _myHttpClient = myHttpClient;

  Future<CurrentWeather> getCurrentWeather([String? city]) async {
    await _myHttpClient.get('https://api.test.com/current_weather');

    if (_rnd.nextBool()) {
      throw WeatherException('Ошибка загрузки текущего прогноза погоды');
    }

    final currentTemp = 10 + _rnd.nextInt(15);
    final high = currentTemp + _rnd.nextInt(5);
    final low = currentTemp - _rnd.nextInt(6);
    final tomorrowHigh = 10 + _rnd.nextInt(15);

    return CurrentWeather(
      city: city ?? 'Krasnodar',
      currentTemp: currentTemp,
      high: high,
      low: low,
      condition: WeatherConditions.random(),
      tomorrowHigh: tomorrowHigh,
      changes: tomorrowHigh > currentTemp ? 'повышение' : 'понижение',
    );
  }

  // TODO(kshabanov): add city param
  Future<List<HourlyWeather>> getHourlyWeather() async {
    await _myHttpClient.get('https://api.test.com/hourly_weather');

    if (_rnd.nextBool()) {
      throw WeatherException('Ошибка загрузки почасового прогноза');
    }

    final baseTemp = 10 + _rnd.nextInt(15);

    return List.generate(24, (i) {
      final hour = DateTime.now().add(Duration(hours: i));

      return HourlyWeather(
        time: i == 0 ? 'Сейчас' : '${hour.hour.toString().padLeft(2, '0')}:00',
        temperature: baseTemp + _rnd.nextInt(3) - 1,
        precipitation: _rnd.nextInt(80),
        condition: WeatherConditions.random(),
      );
    });
  }

  // TODO(kshabanov): add city param
  Future<List<DailyWeather>> getDailyWeather() async {
    await _myHttpClient.get('https://api.test.com/daily_weather');

    if (_rnd.nextBool()) {
      throw WeatherException('Ошибка загрузки дневного прогноза');
    }

    return List.generate(10, (i) {
      final date = DateTime.now().add(Duration(days: i + 1));

      return DailyWeather(
        day: i == 0 ? 'Завтра' : WeatherConditions.weekday(date.weekday),
        high: 10 + _rnd.nextInt(15),
        low: 5 + _rnd.nextInt(10),
        condition: WeatherConditions.random(),
        precipitation: _rnd.nextInt(80),
      );
    });
  }
}
