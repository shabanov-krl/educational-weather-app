import 'package:test_project_weather/features/city_details/data/datasources/city_deatils_remote_data_source.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/daily_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/horly_weather.dart';

// TODO(kshabanov): add dtos
// TODO(kshabanov): rename to CityDetailsRepository

class WeatherScreenRepository {
  final WeatherScreenRemoteDataSource _weatherScreenRemoteDataSource;

  WeatherScreenRepository({
    required WeatherScreenRemoteDataSource weatherScreenRemoteDataSource,
  }) : _weatherScreenRemoteDataSource = weatherScreenRemoteDataSource;

  Future<CurrentWeather> getCurrentWeather([String? city]) async {
    return _weatherScreenRemoteDataSource.getCurrentWeather(city);
  }

  Future<List<HourlyWeather>> getHourlyWeather() async {
    return _weatherScreenRemoteDataSource.getHourlyWeather();
  }

  Future<List<DailyWeather>> getDailyWeather() async {
    return _weatherScreenRemoteDataSource.getDailyWeather();
  }
}
