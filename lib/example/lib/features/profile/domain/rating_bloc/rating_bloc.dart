import 'dart:async';

import 'package:test_project_weather/example/lib/features/profile/data/profile_repository.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/rating_bloc/rating_state.dart';

class RatingBloc {
  final ProfileRepository _profileRepository;

  final StreamController<RatingState> _stateController =
      StreamController<RatingState>.broadcast();

  Stream<RatingState> get state => _stateController.stream;

  RatingBloc({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  Future<void> getRating() async {
    _stateController.add(const RatingState$Loading());

    try {
      final rating = await _profileRepository.getRating();

      _stateController.add(RatingState$Success(rating));
    } catch (e) {
      _stateController.add(RatingState$Error(e.toString()));
    }
  }

  void dispose() {
    _stateController.close();
  }
}
