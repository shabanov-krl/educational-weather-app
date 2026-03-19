class FavoritesCitiesModel {
  final int cityId;
  final String city;
  final int currentTemp;
  final int high;
  final int low;
  final String condition;

  FavoritesCitiesModel({
    required this.cityId,
    required this.city,
    required this.currentTemp,
    required this.high,
    required this.low,
    required this.condition,
  });
}