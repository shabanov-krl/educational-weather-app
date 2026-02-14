import 'package:test_project_weather/core/my_http_client.dart';
import 'package:test_project_weather/features/city_details/data/city_details_repository.dart';
import 'package:test_project_weather/features/city_details/data/datasources/city_details_remote_data_source.dart';
import 'package:test_project_weather/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:test_project_weather/features/favorites/data/favorites_repository.dart';

class DIContainer {
  static final MyHttpClient myHttpClient = MyHttpClient();

  static final CityDetailsRemoteDataSource weatherScreenRemoteDataSource =
      CityDetailsRemoteDataSource(myHttpClient: myHttpClient);
  static final CityDetailsRepository weatherScreenRepository =
      CityDetailsRepository(
        cityDetailsRemoteDataSource: weatherScreenRemoteDataSource,
      );

  static final FavoritesRemoteDataSource favoritesScreenRemoteDataSource =
      FavoritesRemoteDataSource(myHttpClient: myHttpClient);
  static final FavoritesRepository favoritesScreenRepository =
      FavoritesRepository(
        favoritesRemoteDataSource: favoritesScreenRemoteDataSource,
      );
}
