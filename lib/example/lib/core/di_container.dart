import 'package:test_project_weather/example/lib/core/my_http_client.dart';
import 'package:test_project_weather/example/lib/core/my_local_storage.dart';
import 'package:test_project_weather/example/lib/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:test_project_weather/example/lib/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:test_project_weather/example/lib/features/profile/data/profile_repository.dart';

class DIContainer {
  static final MyHttpClient myHttpClient = MyHttpClient();
  static final MyLocalStorage myLocalStorage = MyLocalStorage();
  static final ProfileRemoteDataSource profileRemoteDataSource =
      ProfileRemoteDataSource(myHttpClient: myHttpClient);
  static final ProfileLocalDataSource profileLocalDataSource =
      ProfileLocalDataSource(myLocalStorage: myLocalStorage);
  static final ProfileRepository profileRepository = ProfileRepository(
    profileRemoteDataSource: profileRemoteDataSource,
    profileLocalDataSource: profileLocalDataSource,
  );
}
