
import 'package:flutter/material.dart';
import 'package:test_project_weather/features/city_details/ui/city_details_screen.dart';
import 'package:test_project_weather/features/favorites/ui/favorites_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather main',
      theme: ThemeData.dark(),
      initialRoute: '/favorites',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/favorites':
            return MaterialPageRoute(
              builder: (_) => const FavoritesScreen(),
            );

          case '/weather':
            final args = settings.arguments as Map<String, dynamic>?;

            final int cityId = args?['cityId'] as int? ?? 0;
            final String cityName = args?['cityName'] as String? ?? '';
            final bool openedFromSearch =
                args?['openedFromSearch'] as bool? ?? false;

            final Future<void> Function(int cityId)? onAddToFavorites =
                args?['onAddToFavorites'] as Future<void> Function(int cityId)?;

            return MaterialPageRoute(
              builder: (_) => WeatherScreen(
                cityId: cityId,
                nameCity: cityName,
                openedFromSearch: openedFromSearch,
                onAddToFavorites: onAddToFavorites,
              ),
            );
        }
        return null;
      },
    );
  }
}