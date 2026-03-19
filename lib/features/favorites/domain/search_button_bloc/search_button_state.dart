import 'package:test_project_weather/features/favorites/data/models/list_cities_model.dart';

interface class SearchButtonState {
  const SearchButtonState();
}

class SearchButtonState$LoadingCities extends SearchButtonState {
  final String query;

  const SearchButtonState$LoadingCities({this.query = ''});
}

class SearchButtonState$Ready extends SearchButtonState {
  final String query;
  final List<ListCitiesModel> suggestions; // топ-5
  final String? citiesErrorMessage;

  const SearchButtonState$Ready({
    required this.query,
    required this.suggestions,
    this.citiesErrorMessage,
  });

  bool get hasCitiesError =>
      citiesErrorMessage != null && citiesErrorMessage!.isNotEmpty;
}

class SearchButtonState$Selected extends SearchButtonState {
  final int cityId;
  final String cityName;

  const SearchButtonState$Selected({
    required this.cityId,
    required this.cityName,
  });
}

class SearchButtonState$NoMatch extends SearchButtonState {
  final String query;
  final String message;

  const SearchButtonState$NoMatch({
    required this.query,
    this.message = 'Ничего не найдено',
  });
}

class SearchButtonState$Error extends SearchButtonState {
  final String message;

  const SearchButtonState$Error(this.message);
}