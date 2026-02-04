import 'dart:async';
//import 'package:test_project_weather/features/weather_screen/data/models/daily_weather.dart';
import 'package:test_project_weather/common/exception_message.dart';
import 'package:test_project_weather/features/weather_screen/data/wt_screen_repository.dart';
import 'package:test_project_weather/features/weather_screen/domain/daily_weather_bloc/daily_weather_state.dart';


class DailyWeatherBloc {
  final WeatherScreenRepository _weatherScreenRepository;

  final StreamController<DailyWeatherState> _stateController =
      StreamController<DailyWeatherState>.broadcast();

  Stream<DailyWeatherState> get state => _stateController.stream;

  DailyWeatherBloc({
    required WeatherScreenRepository weatherScreenRepository,
  }) : _weatherScreenRepository = weatherScreenRepository;

  Future<void> getDailyWeather() async {
    _stateController.add(const DailyWeatherState$Loading());

    try {
      final dailyWeather = await _weatherScreenRepository.getDailyWeather();

      _stateController.add(DailyWeatherState$Success(dailyWeather));
    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();
      _stateController.add(DailyWeatherState$Error(message));
    }
  }

  void dispose() {
    _stateController.close();
  }
}
