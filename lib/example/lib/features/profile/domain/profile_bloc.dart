import 'dart:async';

import 'package:test_project_weather/example/lib/features/profile/data/models/profile_model.dart';
import 'package:test_project_weather/example/lib/features/profile/data/profile_repository.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/profile_state.dart';

class ProfileBloc {
  final ProfileRepository _profileRepository;

  final StreamController<ProfileState> _stateController =
      StreamController<ProfileState>.broadcast();

  Stream<ProfileState> get state => _stateController.stream;

  ProfileBloc({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  Future<ProfileModel?> getProfile() async {
    _stateController.add(const ProfileState$Loading());

    try {
      final profile = await _profileRepository.getProfile();

      _stateController.add(ProfileState$Success(profile));

      return profile;
    } catch (e) {
      _stateController.add(ProfileState$Error(e.toString()));

      return null;
    }
  }

  void dispose() {
    _stateController.close();
  }
}
