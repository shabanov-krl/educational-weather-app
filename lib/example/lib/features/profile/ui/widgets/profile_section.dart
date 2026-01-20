part of '../profile_screen.dart';

class _ProfileSection extends StatefulWidget {
  const _ProfileSection();

  @override
  State<_ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<_ProfileSection> {
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();

    _profileBloc = ProfileBloc(
      profileRepository: DIContainer.profileRepository,
    );
    _profileBloc.getProfile();
  }

  @override
  void dispose() {
    _profileBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ProfileState>(
      stream: _profileBloc.state,
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
                      _profileBloc.getProfile();
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
