import 'dart:async';

import 'package:test_project_weather/common/exception_message.dart';
import 'package:test_project_weather/features/weather_screen/data/wt_screen_repository.dart';
import 'package:test_project_weather/features/weather_screen/domain/horly_weather_bloc/horly_weather_state.dart';



class HourlyWeatherBloc {
  final WeatherScreenRepository _weatherScreenRepository;

  final StreamController<HourlyWeatherState> _stateController =
      StreamController<HourlyWeatherState>.broadcast();

  Stream<HourlyWeatherState> get state => _stateController.stream;

  HourlyWeatherBloc({
    required WeatherScreenRepository weatherScreenRepository,
  }) : _weatherScreenRepository = weatherScreenRepository;

  Future<void> getHourlyWeather() async {
    _stateController.add(const HourlyWeatherState$Loading());

    try {
      final hourlyWeather = await _weatherScreenRepository.getHourlyWeather();

      _stateController.add(HourlyWeatherState$Success(hourlyWeather));
    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();
      _stateController.add(HourlyWeatherState$Error(message));
    }
  }

  void dispose() {
    _stateController.close();
  }
}
