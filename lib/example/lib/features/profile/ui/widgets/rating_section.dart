part of '../profile_screen.dart';

class _RatingSection extends StatefulWidget {
  const _RatingSection();

  @override
  State<_RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<_RatingSection> {
  late final RatingBloc _ratingBloc;

  @override
  void initState() {
    super.initState();

    _ratingBloc = RatingBloc(profileRepository: DIContainer.profileRepository);
    _ratingBloc.getRating();
  }

  @override
  void dispose() {
    _ratingBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RatingState>(
      stream: _ratingBloc.state,
      builder: (context, snapshot) {
        final data = snapshot.data;

        switch (data) {
          case null:
          case RatingState$Loading():
            return const Center(child: CircularProgressIndicator());
          case RatingState$Success():
            return Text('Rating: ${data.rating.rating}');
          case RatingState$Error():
            return Center(
              child: Column(
                children: [
                  Text('Error: ${data.message}'),
                  ElevatedButton(
                    onPressed: () {
                      _ratingBloc.getRating();
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
