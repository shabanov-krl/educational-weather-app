import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';

interface class CurrentWeatherState {
  const CurrentWeatherState();
}

class CurrentWeatherState$Loading extends CurrentWeatherState {
  const CurrentWeatherState$Loading();
}

class CurrentWeatherState$Success extends CurrentWeatherState {
  final CurrentWeather currentWeather;

  const CurrentWeatherState$Success(this.currentWeather);
}

class CurrentWeatherState$Error extends CurrentWeatherState {
  final String message;

  const CurrentWeatherState$Error(this.message);
}
