import 'package:test_project_weather/features/city_details/data/models/horly_weather.dart';

interface class HourlyWeatherState {
  const HourlyWeatherState();
}

class HourlyWeatherState$Loading extends HourlyWeatherState {
  const HourlyWeatherState$Loading();
}

class HourlyWeatherState$Success extends HourlyWeatherState {
  final List<HourlyWeatherModel> hourlyWeather;
  const HourlyWeatherState$Success(this.hourlyWeather);
}

class HourlyWeatherState$Error extends HourlyWeatherState {
  final String message;

  const HourlyWeatherState$Error(this.message);
}
