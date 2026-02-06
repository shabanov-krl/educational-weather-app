import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/city_details_repository.dart';
import 'package:test_project_weather/features/city_details/data/datasources/city_details_remote_data_source.dart';
import 'package:test_project_weather/features/favorites/data/datasources/favorites_screen_remote.dart';
import 'package:test_project_weather/features/favorites/data/favorites_screen_repository.dart';

class DIContainer {
  static final MyHttpClient myHttpClient = MyHttpClient();

  static final CityDetailsRemoteDataSource weatherScreenRemoteDataSource =
      CityDetailsRemoteDataSource(myHttpClient: myHttpClient);
  static final CityDetailsRepository weatherScreenRepository =
      CityDetailsRepository(
        cityDetailsRemoteDataSource: weatherScreenRemoteDataSource,
      );

  static final FavoritesScreenRemoteDataSource favoritesScreenRemoteDataSource =
      FavoritesScreenRemoteDataSource(myHttpClient: myHttpClient);
  static final FavoritesScreenRepository favoritesScreenRepository =
      FavoritesScreenRepository(
        favoritesScreenRemoteDataSource: favoritesScreenRemoteDataSource,
      );
}
