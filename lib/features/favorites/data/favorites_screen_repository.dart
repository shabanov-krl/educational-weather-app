import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/favorites/data/datasources/favorites_screen_remote.dart';

class FavoritesScreenRepository {
  final FavoritesScreenRemoteDataSource _favoritesScreenRemoteDataSource;

  FavoritesScreenRepository({
    required FavoritesScreenRemoteDataSource favoritesScreenRemoteDataSource,
  }) : _favoritesScreenRemoteDataSource = favoritesScreenRemoteDataSource;

  Future<CurrentWeatherModel> getCurrentWeather([String? city]) async {
    final remoteCurrentWeather = await _favoritesScreenRemoteDataSource
        .getCurrentWeather(city);

    return CurrentWeatherModel(
      city: remoteCurrentWeather.city,
      currentTemp: remoteCurrentWeather.currentTemp,
      high: remoteCurrentWeather.high,
      low: remoteCurrentWeather.low,
      condition: remoteCurrentWeather.condition,
      tomorrowHigh: remoteCurrentWeather.tomorrowHigh,
      changes: remoteCurrentWeather.changes,
    );
  }
}
