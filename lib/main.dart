import 'package:flutter/material.dart';
import 'package:test_project_weather/features/weather_screen/ui/weather_screen.dart';
import 'features/favorites_screen/ui/favorites_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather main',
      theme: ThemeData.dark(),
      initialRoute: '/favorites',
      routes: {
        '/favorites': (context) => const FavoritesScreen(),
        '/weather': (context) => const WeatherPage(),
      },
    );
  }
}



class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments;
    final city = arg is String ? arg : null;
    return WeatherScreen(selectedCity: city);
  }
}
