import 'package:flutter/material.dart';
import 'package:test_project_weather/example/lib/core/di_container.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/profile_bloc.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();

    profileBloc = ProfileBloc(profileRepository: DIContainer.profileRepository);
    profileBloc.getProfile();
  }

  @override
  void dispose() {
    profileBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileState>(
      stream: profileBloc.state,
      builder: (context, snapshot) {
        final data = snapshot.data;

        switch (data) {
          case null:
          case ProfileState$Loading():
            return const Center(child: CircularProgressIndicator());
          case ProfileState$Success():
            return ListView(
              children: [
                Text(data.profile.name),
                Text(data.profile.age.toString()),
              ],
            );
          case ProfileState$Error():
            return Center(
              child: Column(
                children: [
                  Text('Error: ${data.message}'),
                  ElevatedButton(
                    onPressed: () {
                      profileBloc.getProfile();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
        }

        return const Center(child: Text('Unknown state'));
      },
    );
  }
}
