import 'package:test_project_weather/features/city_details/data/models/daily_weather.dart';

interface class DailyWeatherState {
  const DailyWeatherState();
}

class DailyWeatherState$Loading extends DailyWeatherState {
  const DailyWeatherState$Loading();
}

class DailyWeatherState$Success extends DailyWeatherState {
  final List<DailyWeatherModel> dailyWeather;

  const DailyWeatherState$Success(this.dailyWeather);
}

class DailyWeatherState$Error extends DailyWeatherState {
  final String message;

  const DailyWeatherState$Error(this.message);
}
