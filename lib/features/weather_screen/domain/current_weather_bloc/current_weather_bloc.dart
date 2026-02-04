import 'dart:async';

import 'package:test_project_weather/common/exception_message.dart';
import 'package:test_project_weather/features/weather_screen/data/wt_screen_repository.dart';
import 'package:test_project_weather/features/weather_screen/domain/current_weather_bloc/current_weather_state.dart';

class CurrentWeatherBloc {
  final WeatherScreenRepository _weatherScreenRepository;

  final StreamController<CurrentWeatherState> _stateController =
      StreamController<CurrentWeatherState>.broadcast();

  Stream<CurrentWeatherState> get state => _stateController.stream;

  CurrentWeatherBloc({
    required WeatherScreenRepository weatherScreenRepository,
  }) : _weatherScreenRepository = weatherScreenRepository;

  Future<void> getCurrentWeather([String? city]) async {
    _stateController.add(const CurrentWeatherState$Loading());

    try {
      final currentWeather = await _weatherScreenRepository.getCurrentWeather(city);

      _stateController.add(CurrentWeatherState$Success(currentWeather));
    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();
      _stateController.add(CurrentWeatherState$Error(message));
    }
  }

  void dispose() {
    _stateController.close();
  }
}
