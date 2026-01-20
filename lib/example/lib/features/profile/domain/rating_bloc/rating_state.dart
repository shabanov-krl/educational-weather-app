import 'package:test_project_weather/example/lib/features/profile/data/models/rating_model.dart';

interface class RatingState {
  const RatingState();
}

class RatingState$Loading extends RatingState {
  const RatingState$Loading();
}

class RatingState$Success extends RatingState {
  final RatingModel rating;

  const RatingState$Success(this.rating);
}

class RatingState$Error extends RatingState {
  final String message;

  const RatingState$Error(this.message);
}
