import 'dart:math';

//import 'package:test_project_weather/common/exception_message.dart';
import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/city_details/data/weather_conditions.dart';

class FavoritesScreenRemoteDataSource {
  final MyHttpClient _myHttpClient;
  final rnd = Random();
  final now = DateTime.now();

  FavoritesScreenRemoteDataSource({
    required MyHttpClient myHttpClient,
  }) : _myHttpClient = myHttpClient;

  Future<CurrentWeather> getCurrentWeather([String? city]) async {
    await _myHttpClient.get('https://api.test.com/current_weather');

    // if (rnd.nextBool()) {
    //   throw WeatherException('Ошибка загрузки текущего прогноза погоды');
    // }

    final currentTemp = 10 + rnd.nextInt(15);
    final high = currentTemp + rnd.nextInt(5);
    final low = currentTemp - rnd.nextInt(6);
    final tomorrowHigh = 10 + rnd.nextInt(15);

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
}
