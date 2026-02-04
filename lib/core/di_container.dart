import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/favorites_screen/data/datasources/favorites_screen_remote.dart';
import 'package:test_project_weather/features/favorites_screen/data/favorites_screen_repository.dart';
import 'package:test_project_weather/features/weather_screen/data/datasources/wt_screen_remote_data_source.dart';
import 'package:test_project_weather/features/weather_screen/data/wt_screen_repository.dart';

class DIContainer {
  static final MyHttpClient myHttpClient = MyHttpClient();

  static final WeatherScreenRemoteDataSource weatherScreenRemoteDataSource =
      WeatherScreenRemoteDataSource(myHttpClient: myHttpClient);
  static final WeatherScreenRepository weatherScreenRepository = WeatherScreenRepository(
    weatherScreenRemoteDataSource: weatherScreenRemoteDataSource,
  );

  static final FavoritesScreenRemoteDataSource favoritesScreenRemoteDataSource =
      FavoritesScreenRemoteDataSource(myHttpClient: myHttpClient);
  static final FavoritesScreenRepository favoritesScreenRepository = FavoritesScreenRepository(
    favoritesScreenRemoteDataSource: favoritesScreenRemoteDataSource,
  );
}
