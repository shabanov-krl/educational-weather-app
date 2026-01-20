import 'package:test_project_weather/example/lib/features/profile/data/models/profile_model.dart';

interface class ProfileState {
  const ProfileState();
}

class ProfileState$Loading extends ProfileState {
  const ProfileState$Loading();
}

class ProfileState$Success extends ProfileState {
  final ProfileModel profile;

  const ProfileState$Success(this.profile);
}

class ProfileState$Error extends ProfileState {
  final String message;

  const ProfileState$Error(this.message);
}
