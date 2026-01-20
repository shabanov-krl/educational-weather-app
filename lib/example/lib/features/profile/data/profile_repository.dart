import 'package:test_project_weather/example/lib/features/profile/data/models/profile_model.dart';
import 'package:test_project_weather/example/lib/features/profile/data/profile_local_data_source.dart';
import 'package:test_project_weather/example/lib/features/profile/data/profile_remote_data_source.dart';

class ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;

  ProfileRepository({
    required ProfileRemoteDataSource profileRemoteDataSource,
    required ProfileLocalDataSource profileLocalDataSource,
  }) : _profileRemoteDataSource = profileRemoteDataSource,
       _profileLocalDataSource = profileLocalDataSource;

  Future<ProfileModel> getProfile() async {
    final profile = await _profileRemoteDataSource.getProfile();
    await _profileLocalDataSource.setProfile(profile);

    return profile;
  }
}
