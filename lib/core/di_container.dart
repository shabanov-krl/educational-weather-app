import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/datasources/city_deatils_remote_data_source.dart';
import 'package:test_project_weather/features/city_details/data/wt_screen_repository.dart';
import 'package:test_project_weather/features/favorites/data/datasources/favorites_screen_remote.dart';
import 'package:test_project_weather/features/favorites/data/favorites_screen_repository.dart';

class DIContainer {
  static final MyHttpClient myHttpClient = MyHttpClient();

  static final WeatherScreenRemoteDataSource weatherScreenRemoteDataSource =
      WeatherScreenRemoteDataSource(myHttpClient: myHttpClient);
  static final WeatherScreenRepository weatherScreenRepository =
      WeatherScreenRepository(
        weatherScreenRemoteDataSource: weatherScreenRemoteDataSource,
      );

  static final FavoritesScreenRemoteDataSource favoritesScreenRemoteDataSource =
      FavoritesScreenRemoteDataSource(myHttpClient: myHttpClient);
  static final FavoritesScreenRepository favoritesScreenRepository =
      FavoritesScreenRepository(
        favoritesScreenRemoteDataSource: favoritesScreenRemoteDataSource,
      );
}
