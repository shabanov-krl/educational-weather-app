import 'package:test_project_weather/features/city_details/data/datasources/city_details_remote_data_source.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/daily_weather.dart';
import 'package:test_project_weather/features/city_details/data/models/horly_weather.dart';

class CityDetailsRepository {
  final CityDetailsRemoteDataSource _cityDetailsRemoteDataSource;

  CityDetailsRepository({
    required CityDetailsRemoteDataSource cityDetailsRemoteDataSource,
  }) : _cityDetailsRemoteDataSource = cityDetailsRemoteDataSource;

  Future<CurrentWeatherModel> getCurrentWeather(String city) async {
    // TODO(kshabanov): делать запросы параллельно, например, Future.wait()
    /// final currentWeather = Future.wait(
    ///   [
    ///     _cityDetailsRemoteDataSource.getCurrentWeatherToday(city),
    ///     _cityDetailsRemoteDataSource.getCurrentWeatherFuture(city),
    ///   ],
    ///   eagerError: true,
    /// );

    final cityDetailsRemoteTodayDataDto = await _cityDetailsRemoteDataSource
        .getCurrentWeatherToday(city);
    final cityDetailsRemoteFutureDataDto = await _cityDetailsRemoteDataSource
        .getCurrentWeatherFuture(city);

    return CurrentWeatherModel(
      city: city,
      currentTemp: cityDetailsRemoteTodayDataDto.currentTemp,
      high: cityDetailsRemoteTodayDataDto.high,
      low: cityDetailsRemoteTodayDataDto.low,
      condition: cityDetailsRemoteFutureDataDto.condition,
      tomorrowHigh: cityDetailsRemoteFutureDataDto.tomorrowHigh,
      changes: cityDetailsRemoteFutureDataDto.changes,
    );
  }

  Future<List<HourlyWeatherModel>> getHourlyWeather(String city) async {
    return _cityDetailsRemoteDataSource.getHourlyWeather(city);
  }

  Future<List<DailyWeatherModel>> getDailyWeather(String city) async {
    return _cityDetailsRemoteDataSource.getDailyWeather(city);
  }
}
