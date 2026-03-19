import 'package:test_project_weather/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:test_project_weather/features/favorites/data/models/favorites_cities_model.dart';

class FavoritesRepository {
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;

  FavoritesRepository({
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  }) : _favoritesRemoteDataSource = favoritesRemoteDataSource;

  Future<FavoritesCitiesModel> getFavoritesCities(int cityId) async {
    final remoteFavoritesCities = await _favoritesRemoteDataSource
        .getFavoritesCities(cityId,);

    return FavoritesCitiesModel(
      cityId: remoteFavoritesCities.cityId,
      city: remoteFavoritesCities.city,
      currentTemp: remoteFavoritesCities.currentTemp,
      high: remoteFavoritesCities.high,
      low: remoteFavoritesCities.low,
      condition: remoteFavoritesCities.condition,
    );
  }

  Future<void> addFavoriteCity(int cityId) async {
    await _favoritesRemoteDataSource.addFavoritesCities(cityId);
  }

  Future<void> removeFavoriteCity(int cityId) async {
    await _favoritesRemoteDataSource.removeFavoritesCities(cityId);
  }
}
