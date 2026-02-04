import 'package:test_project_weather/features/weather_screen/data/datasources/wt_screen_remote_data_source.dart';
import 'package:test_project_weather/features/weather_screen/data/models/current_weather.dart';
import 'package:test_project_weather/features/weather_screen/data/models/daily_weather.dart';
import 'package:test_project_weather/features/weather_screen/data/models/horly_weather.dart';

class WeatherScreenRepository {
  final WeatherScreenRemoteDataSource _weatherScreenRemoteDataSource;

  WeatherScreenRepository({
    required WeatherScreenRemoteDataSource weatherScreenRemoteDataSource,
  }) : _weatherScreenRemoteDataSource = weatherScreenRemoteDataSource;

  Future<CurrentWeather> getCurrentWeather([String? city]) async {
    final remoteCurrentWeather = await _weatherScreenRemoteDataSource.getCurrentWeather(city);

    return CurrentWeather(
      city: remoteCurrentWeather.city,
      currentTemp: remoteCurrentWeather.currentTemp,
      high: remoteCurrentWeather.high,
      low: remoteCurrentWeather.low,
      condition: remoteCurrentWeather.condition,
      tomorrowHigh: remoteCurrentWeather.tomorrowHigh,
      changes: remoteCurrentWeather.changes,
    );
  }

  Future<List<HourlyWeather>> getHourlyWeather() async {
    final remoteHourlyWeather = await _weatherScreenRemoteDataSource.getHourlyWeather();
    return remoteHourlyWeather;
  }

  Future<List<DailyWeather>> getDailyWeather() async {
    final remoteDailyWeather = await _weatherScreenRemoteDataSource.getDailyWeather();
    return remoteDailyWeather;
  }

}
