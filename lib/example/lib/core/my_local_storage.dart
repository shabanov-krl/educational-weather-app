class MyLocalStorage {
  Future<void> set(String key, String value) async {
    await Future.delayed(const Duration(seconds: 1));

    /// ...
  }
}
