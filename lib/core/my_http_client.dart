import 'package:test_project_weather/common/random_req_time.dart';

class MyHttpClient {
  Future<void> get(String url) async {
    await randomRequestTime();
  }
}
