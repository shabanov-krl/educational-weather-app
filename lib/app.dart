import 'package:flutter/material.dart';
import 'package:test_project_weather/features/city_details/ui/city_details_screen.dart';

import 'features/favorites/ui/favorites_screen.dart';

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
        '/weather': (context) {
          final arg = ModalRoute.of(context)?.settings.arguments;
          final String city = arg.toString();

          return WeatherScreen(city: city);
        },
      },
    );
  }
}
