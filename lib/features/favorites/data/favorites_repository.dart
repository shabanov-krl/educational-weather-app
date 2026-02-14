import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/favorites/data/datasources/favorites_remote_data_source.dart';

class FavoritesRepository {
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;

  FavoritesRepository({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  }) : _favoritesRemoteDataSource = favoritesRemoteDataSource;

  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    final remoteCurrentWeather = await _favoritesRemoteDataSource.getCurrentWeather(
      city,
    );

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

  Future<List<String>> loadCities({
    String assetPath = 'lib/features/favorites/data/map_cities.json',
  }) async {
    return _favoritesRemoteDataSource.loadCities(assetPath: assetPath);
  }
}
