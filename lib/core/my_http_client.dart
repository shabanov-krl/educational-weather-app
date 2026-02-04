import 'package:test_project_weather/core/utils/random_request_time.dart';

class MyHttpClient {
  Future<void> get(String url) async {
    await randomRequestTime();
  }
}
