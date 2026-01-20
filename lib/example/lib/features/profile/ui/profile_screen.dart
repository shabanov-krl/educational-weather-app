import 'package:flutter/material.dart';
import 'package:test_project_weather/example/lib/core/di_container.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/profile_bloc/profile_bloc.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/profile_bloc/profile_state.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/rating_bloc/rating_bloc.dart';
import 'package:test_project_weather/example/lib/features/profile/domain/rating_bloc/rating_state.dart';

part 'widgets/profile_section.dart';
part 'widgets/rating_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ProfileSection(),
        _RatingSection(),
      ],
    );
  }
}
