import 'dart:async';

import 'package:test_project_weather/features/common/weather_exception.dart';
import 'package:test_project_weather/features/favorites/data/favorites_repository.dart';
import 'package:test_project_weather/features/favorites/domain/city_matcher.dart'
    as city_matcher;
import 'package:test_project_weather/features/favorites/domain/favorites_cities_bloc/favorites_state.dart';

class FavoritesCitiesBloc {
  final FavoritesRepository _favoritesRepository;
  final List<String> _initialFavoriteCities;

  final StreamController<FavoritesState> _stateController =
      StreamController<FavoritesState>.broadcast();

  List<String> _favoriteCities = const [];
  Map<String, FavoriteCityWeatherModel> _weatherByCity = const {};
  List<String> _allCities = const [];
  bool _isCitiesLoading = false;
  String? _citiesErrorMessage;

  Stream<FavoritesState> get state => _stateController.stream;

  FavoritesCitiesBloc({
    required FavoritesRepository favoritesRepository,
    List<String> initialFavoriteCities = const ['Краснодар', 'Москва'],
  }) : _favoritesRepository = favoritesRepository,
       _initialFavoriteCities = List<String>.unmodifiable(
         initialFavoriteCities,
       );

  Future<void> loadFavoritesRequested() async {
    _emitState(const FavoritesState$Loading());

    try {
      _favoriteCities = List<String>.from(_initialFavoriteCities);
      _weatherByCity = {
        for (final city in _favoriteCities)
          city: const FavoriteCityWeatherModel.loading(),
      };
      _allCities = const [];
      _isCitiesLoading = true;
      _citiesErrorMessage = null;
      _emitSuccessState();

      await Future.wait([
        _loadCities(),
        ..._favoriteCities.map(_loadWeatherForCity),
      ]);
    } catch (error) {
      _emitState(FavoritesState$Error(_mapErrorToMessage(error)));
    }
  }

  Future<void> favoriteAdded(String city) async {
    final trimmedCity = city.trim();

    if (trimmedCity.isEmpty) {
      return;
    }

    final alreadyExists = _favoriteCities.any(
      (favoriteCity) => favoriteCity.toLowerCase() == trimmedCity.toLowerCase(),
    );

    if (alreadyExists) {
      return;
    }

    _favoriteCities = List<String>.from(_favoriteCities)..add(trimmedCity);
    _weatherByCity = Map<String, FavoriteCityWeatherModel>.from(_weatherByCity)
      ..[trimmedCity] = const FavoriteCityWeatherModel.loading();
    _emitSuccessState();

    await _loadWeatherForCity(trimmedCity);
  }

  void favoriteRemovedAt(int index) {
    if (index < 0 || index >= _favoriteCities.length) {
      return;
    }

    final city = _favoriteCities[index];

    _favoriteCities = List<String>.from(_favoriteCities)..removeAt(index);
    _weatherByCity = Map<String, FavoriteCityWeatherModel>.from(_weatherByCity)
      ..remove(city);
    _emitSuccessState();
  }

  Future<void> favoriteRefreshed(String city) async {
    final normalizedCity = city.trim();

    if (normalizedCity.isEmpty) {
      return;
    }

    final targetCity = _favoriteCities.firstWhere(
      (favoriteCity) => favoriteCity.toLowerCase() == normalizedCity.toLowerCase(),
      orElse: () => '',
    );

    if (targetCity.isEmpty) {
      return;
    }

    _weatherByCity = Map<String, FavoriteCityWeatherModel>.from(_weatherByCity)
      ..[targetCity] = const FavoriteCityWeatherModel.loading();
    _emitSuccessState();

    await _loadWeatherForCity(targetCity);
  }

  String? findBestMatch(String input) {
    return city_matcher.findBestMatch(_allCities, input);
  }

  Future<void> _loadCities() async {
    try {
      final cities = await _favoritesRepository.loadCities();

      _allCities = List<String>.unmodifiable(cities);
      _citiesErrorMessage = null;
    
    } catch (error) {
      _allCities = const [];
      _citiesErrorMessage = _mapErrorToMessage(error);
    
    } finally {
      _isCitiesLoading = false;
      _emitSuccessState();
    }
  }

  Future<void> _loadWeatherForCity(String city) async {
    try {
      final weather = await _favoritesRepository.getCurrentWeather(city);

      _weatherByCity = Map<String, FavoriteCityWeatherModel>.from(_weatherByCity)
        ..[city] = FavoriteCityWeatherModel.success(weather);
    
    } catch (error) {
      _weatherByCity = Map<String, FavoriteCityWeatherModel>.from(_weatherByCity)
        ..[city] = FavoriteCityWeatherModel.error(_mapErrorToMessage(error));
    
    } finally {
      _emitSuccessState();
    }
  }

  void _emitSuccessState() {
    _emitState(
      FavoritesState$Success(
        favoriteCities: List<String>.unmodifiable(_favoriteCities),
        weatherByCity: Map<String, FavoriteCityWeatherModel>.unmodifiable(
          _weatherByCity,
        ),
        allCities: List<String>.unmodifiable(_allCities),
        isCitiesLoading: _isCitiesLoading,
        citiesErrorMessage: _citiesErrorMessage,
      ),
    );
  }

  void _emitState(FavoritesState state) {
    if (_stateController.isClosed) {
      return;
    }

    _stateController.add(state);
  }

  String _mapErrorToMessage(Object error) {
    if (error is WeatherException) {
      return error.message;
    }

    return error.toString();
  }

  void dispose() {
    _stateController.close();
  }
}
