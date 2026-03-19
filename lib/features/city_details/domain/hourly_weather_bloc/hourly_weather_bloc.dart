import 'dart:async';

import 'package:test_project_weather/features/city_details/data/city_details_repository.dart';
import 'package:test_project_weather/features/city_details/domain/hourly_weather_bloc/hourly_weather_state.dart';
import 'package:test_project_weather/features/common/weather_exception.dart';

class HourlyWeatherBloc {
  final CityDetailsRepository _weatherScreenRepository;

  final StreamController<HourlyWeatherState> _stateController =
      StreamController<HourlyWeatherState>.broadcast();

  Stream<HourlyWeatherState> get state => _stateController.stream;

  HourlyWeatherBloc({
    required CityDetailsRepository weatherScreenRepository,
  }) : _weatherScreenRepository = weatherScreenRepository;

  Future<void> getHourlyWeather(int cityId) async {
    _emitState(const HourlyWeatherState$Loading());

    try {
      final hourlyWeather = await _weatherScreenRepository.getHourlyWeather(cityId);

      _emitState(HourlyWeatherState$Success(hourlyWeather));

    } catch (e) {
      final message = e is WeatherException ? e.message : e.toString();

      _emitState(HourlyWeatherState$Error(message));
    }
  }

  void dispose() {
    if (_stateController.isClosed) {
      return;
    }
    _stateController.close();
  }


  void _emitState(HourlyWeatherState state) {
    if (_stateController.isClosed) {
      return;
    }

    _stateController.add(state);
  }
}
