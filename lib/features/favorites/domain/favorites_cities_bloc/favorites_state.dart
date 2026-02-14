import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';

interface class FavoritesState {
  const FavoritesState();
}

class FavoriteCityWeatherModel {
  final bool isLoading;
  final CurrentWeatherModel? weather;
  final String? errorMessage;

  const FavoriteCityWeatherModel._({
    required this.isLoading,
    required this.weather,
    required this.errorMessage,
  });

  const FavoriteCityWeatherModel.loading()
      : this._(isLoading: true, weather: null, errorMessage: null);

  const FavoriteCityWeatherModel.success(CurrentWeatherModel weather)
      : this._(isLoading: false, weather: weather, errorMessage: null);

  const FavoriteCityWeatherModel.error(String errorMessage)
      : this._(isLoading: false, weather: null, errorMessage: errorMessage);

  bool get hasData => weather != null;
  bool get hasError => errorMessage != null;
}

class FavoritesState$Loading extends FavoritesState {
  const FavoritesState$Loading();
}

class FavoritesState$Success extends FavoritesState {
  final List<String> favoriteCities;
  final Map<String, FavoriteCityWeatherModel> weatherByCity;
  final List<String> allCities;
  final bool isCitiesLoading;
  final String? citiesErrorMessage;

  const FavoritesState$Success({
    required this.favoriteCities,
    required this.weatherByCity,
    required this.allCities,
    required this.isCitiesLoading,
    required this.citiesErrorMessage,
  });
}

class FavoritesState$Error extends FavoritesState {
  final String message;

  const FavoritesState$Error(this.message);
}
