import 'dart:async';

import 'package:test_project_weather/features/city_details/data/city_details_repository.dart';
import 'package:test_project_weather/features/city_details/domain/daily_weather_bloc/daily_weather_state.dart';
import 'package:test_project_weather/features/common/weather_exception.dart';

class DailyWeatherBloc {
  final CityDetailsRepository _weatherScreenRepository;

  final StreamController<DailyWeatherState> _stateController =
      StreamController<DailyWeatherState>.broadcast();

  Stream<DailyWeatherState> get state => _stateController.stream;

  DailyWeatherBloc({
    required CityDetailsRepository weatherScreenRepository,
  }) : _weatherScreenRepository = weatherScreenRepository;

  Future<void> getDailyWeather(String city) async {
    _stateController.add(const DailyWeatherState$Loading());

    try {
      final dailyWeather = await _weatherScreenRepository.getDailyWeather(city);

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
