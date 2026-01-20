import 'package:test_project_weather/example/lib/core/my_http_client.dart';
import 'package:test_project_weather/example/lib/features/profile/data/models/profile_model.dart';
import 'package:test_project_weather/example/lib/features/profile/data/models/rating_model.dart';

class ProfileRemoteDataSource {
  final MyHttpClient _myHttpClient;

  ProfileRemoteDataSource({
    required MyHttpClient myHttpClient,
  }) : _myHttpClient = myHttpClient;

  Future<ProfileModel> getProfile() async {
    await _myHttpClient.get('https://api.example.com/profile');

    return ProfileModel(name: 'John Doe', age: 30);
  }

  Future<RatingModel> getRating() async {
    await _myHttpClient.get('https://api.example.com/rating');

    return RatingModel(rating: 5);
  }
}
