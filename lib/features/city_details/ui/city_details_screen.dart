import 'package:flutter/material.dart';
import 'package:test_project_weather/core/di_container.dart';
import 'package:test_project_weather/features/city_details/domain/current_weather_bloc/current_weather_bloc.dart';
import 'package:test_project_weather/features/city_details/domain/current_weather_bloc/current_weather_state.dart';
import 'package:test_project_weather/features/city_details/domain/daily_weather_bloc/daily_weather_bloc.dart';
import 'package:test_project_weather/features/city_details/domain/daily_weather_bloc/daily_weather_state.dart';
import 'package:test_project_weather/features/city_details/domain/horly_weather_bloc/horly_weather_bloc.dart';
import 'package:test_project_weather/features/city_details/domain/horly_weather_bloc/horly_weather_state.dart';

part 'widgets/current_weather_section.dart';
part 'widgets/daily_weather_section.dart';
part 'widgets/hourly_weather_section.dart';

class WeatherScreen extends StatelessWidget {
  final String city;

  const WeatherScreen({required this.city, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 29, 36),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: _CurrentWeatherSection(city),
          ),

          _HorlyWeatherSection(city),

          _DailyWeatherSection(city),
        ],
      ),
    );
  }
}

final weatherConditionIcons = {
  'Ясно': Icons.wb_sunny,
  'Частично облачно': Icons.wb_cloudy,
  'Преимущественно облачно': Icons.cloud,
  'Дождь': Icons.umbrella,
  'Небольшой дождь': Icons.water_drop,
  'Тумано': Icons.opacity,
};
