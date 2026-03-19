import 'dart:async';

import 'package:test_project_weather/features/common/weather_exception.dart';
import 'package:test_project_weather/features/favorites/data/cities_repository.dart';
import 'package:test_project_weather/features/favorites/data/favorites_repository.dart';
import 'package:test_project_weather/features/favorites/data/models/favorites_cities_model.dart';
import 'package:test_project_weather/features/favorites/domain/favorites_cities_bloc/favorites_state.dart';

class FavoritesCitiesBloc {
  static const List<int> _defaultFavoriteIds = [30, 40];

  final FavoritesRepository _favoritesRepository;
  final CitiesRepository _citiesRepository;

  final StreamController<FavoritesState> _stateController =
      StreamController<FavoritesState>.broadcast();

  Stream<FavoritesState> get state => _stateController.stream;

  final List<int> _favoriteCityIds = <int>[];

  Map<int, String>? _cityNameById;

  final Map<String, FavoritesCitiesModel> _weatherByCity =
      <String, FavoritesCitiesModel>{};

  FavoritesCitiesBloc({
    required CitiesRepository citiesRepository,
    required FavoritesRepository favoritesRepository,
  })  : _citiesRepository = citiesRepository,
        _favoritesRepository = favoritesRepository;

  Future<void> getFavoritesCities() async {
    _emitState(const FavoritesState$Loading());

    try {
      await _checkCitiDictionary();

      if (_favoriteCityIds.isEmpty) {
        _favoriteCityIds.addAll(_defaultFavoriteIds);
      }

      final results = await Future.wait(
        _favoriteCityIds.map((cityId) => _loadWeatherForCityId(cityId)),
      );

      _weatherByCity
        ..clear()
        ..addEntries(results.map((m) => MapEntry(m.city, m)));

      _emitCurrentFavoritesState();
    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();
      _emitState(FavoritesState$Error(message));
    }
  }

  Future<void> addFavoriteCity(int cityId) async {
    _emitState(const FavoritesState$Loading());

    try {
      await _checkCitiDictionary();

      if (_favoriteCityIds.contains(cityId)) {
        _emitState(
          FavoritesStateAdd$Success(
            favoriteCities: _favoriteCityIds
                .map(_resolveCityName)
                .toList(growable: false),
          ),
        );
        _emitCurrentFavoritesState();
        return;
      }
      
      await _favoritesRepository.addFavoriteCity(cityId);
      _favoriteCityIds.add(cityId);

      final model = await _loadWeatherForCityId(cityId);
      _weatherByCity[model.city] = model;

      _emitState(
        FavoritesStateAdd$Success(
          favoriteCities: _favoriteCityIds
              .map(_resolveCityName)
              .toList(growable: false),
        ),
      );

      _emitCurrentFavoritesState();
    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();
      _emitState(FavoritesState$Error(message));
    }
  }

  Future<void> removeFavoriteCity(int cityId) async {
    late final List<int> previousIds;
    late final Map<String, FavoritesCitiesModel> previousWeather;

    try {
      await _checkCitiDictionary();

      if (!_favoriteCityIds.contains(cityId)) {
        _emitState(
          FavoritesStateDel$Success(
            favoriteCities: _favoriteCityIds
                .map(_resolveCityName)
                .toList(growable: false),
          ),
        );
        _emitCurrentFavoritesState();
        return;
      }

      previousIds = List<int>.from(_favoriteCityIds);
      previousWeather =
          Map<String, FavoritesCitiesModel>.from(_weatherByCity);

      final cityName = _resolveCityName(cityId);

      _favoriteCityIds.remove(cityId);
      _weatherByCity.remove(cityName);

      _emitCurrentFavoritesState();

      await _favoritesRepository.removeFavoriteCity(cityId);

      _emitState(
        FavoritesStateDel$Success(
          favoriteCities: _favoriteCityIds
              .map(_resolveCityName)
              .toList(growable: false),
        ),
      );

      _emitCurrentFavoritesState();
    } catch (e) {
      if (_cityNameById != null) {
        _favoriteCityIds
          ..clear()
          ..addAll(previousIds);

        _weatherByCity
          ..clear()
          ..addAll(previousWeather);

        _emitCurrentFavoritesState();
      }

      final message = e is WeatherException ? e.message : e.toString();
      _emitState(FavoritesState$Error(message));
    }
  }

  Future<void> _checkCitiDictionary() async {
    if (_cityNameById != null) {
      return;
    }

    final cities = await _citiesRepository.getListCities();
    final map = <int, String>{};

    for (final c in cities) {
      map[c.cityId] = c.city;
    }

    _cityNameById = Map<int, String>.unmodifiable(map);
  }

  String _resolveCityName(int cityId) {
    final name = _cityNameById?[cityId];
    return name ?? 'City#$cityId';
  }

  Future<FavoritesCitiesModel> _loadWeatherForCityId(int cityId) async {
    final resolvedName = _resolveCityName(cityId);
    final remoteModel = await _favoritesRepository.getFavoritesCities(cityId);

    return FavoritesCitiesModel(
      cityId: remoteModel.cityId,
      city: resolvedName,
      currentTemp: remoteModel.currentTemp,
      high: remoteModel.high,
      low: remoteModel.low,
      condition: remoteModel.condition,
    );
  }

  void _emitCurrentFavoritesState() {
    _emitState(
      FavoritesStateGet$Success(
        favoriteCities: _favoriteCityIds
            .map(_resolveCityName)
            .toList(growable: false),
        weatherByCity:
            Map<String, FavoritesCitiesModel>.unmodifiable(_weatherByCity),
      ),
    );
  }

  void dispose() {
    if (!_stateController.isClosed) {
      _stateController.close();
    }
  }

  void _emitState(FavoritesState state) {
    if (_stateController.isClosed) {
      return;
    }
    _stateController.add(state);
  }
}