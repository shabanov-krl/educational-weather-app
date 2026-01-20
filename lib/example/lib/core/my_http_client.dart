class MyHttpClient {
  Future<void> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));

    /// ...
  }
}
