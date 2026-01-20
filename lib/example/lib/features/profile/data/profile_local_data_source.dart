import 'package:test_project_weather/example/lib/core/my_local_storage.dart';
import 'package:test_project_weather/example/lib/features/profile/data/models/profile_model.dart';

class ProfileLocalDataSource {
  final MyLocalStorage _myLocalStorage;

  ProfileLocalDataSource({
    required MyLocalStorage myLocalStorage,
  }) : _myLocalStorage = myLocalStorage;

  Future<void> setProfile(ProfileModel profile) async {
    await _myLocalStorage.set('profile', profile.toString());
  }
}
