import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:test_project_weather/core/di_container.dart';
import 'package:test_project_weather/features/weather_screen/domain/current_weather_bloc/current_weather_bloc.dart';
import 'package:test_project_weather/features/weather_screen/domain/current_weather_bloc/current_weather_state.dart';
import 'package:test_project_weather/features/weather_screen/domain/daily_weather_bloc/daily_weather_bloc.dart';
import 'package:test_project_weather/features/weather_screen/domain/daily_weather_bloc/daily_weather_state.dart';
import 'package:test_project_weather/features/weather_screen/domain/horly_weather_bloc/horly_weather_bloc.dart';
import 'package:test_project_weather/features/weather_screen/domain/horly_weather_bloc/horly_weather_state.dart';


part 'widgets/current_weather_section.dart';
part 'widgets/daily_weather_section.dart';
part 'widgets/forecast_info_section.dart';
part 'widgets/hourly_weather_section.dart';



class WeatherScreen extends StatelessWidget {
  final String? selectedCity;

  const WeatherScreen({super.key, this.selectedCity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const material.Color.fromARGB(255, 17, 29, 36),
      body: ListView(
        children: [
          material.Padding(
            padding: const EdgeInsets.all(30),
            child: _CurrentWeatherSection(city: selectedCity),
          ),
          const material.Padding(
            padding: EdgeInsets.all(8),
            child: _HorlyWeatherSection(),
          ),
          const _ForecastInfo(),
          const _DailyWeatherSection(),
        ],
      ),
    );
  }
}

class ImageIcon {
  static IconData getWeatherIcon(String condition) {
    switch (condition) {
      case 'Ясно':
        return Icons.wb_sunny;
      case 'Частично облачно':
        return Icons.wb_cloudy;
      case 'Преимущественно облачно':
        return Icons.cloud;
      case 'Дождь':
        return Icons.umbrella;
      case 'Небольшой дождь':
        return Icons.water_drop;
      case 'Тумано':
        return Icons.opacity;
      default:
        return Icons.cloud;
    }
  }
}
