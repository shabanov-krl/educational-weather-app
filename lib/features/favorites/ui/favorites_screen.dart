import 'package:flutter/material.dart';
import 'package:test_project_weather/core/di_container.dart';
import 'package:test_project_weather/features/favorites/domain/city_matcher.dart';
import 'package:test_project_weather/features/favorites/domain/favorites_cities_bloc/favorites_cities_bloc.dart';
import 'package:test_project_weather/features/favorites/domain/favorites_cities_bloc/favorites_state.dart';

part 'widgets/list_favorites_cities_section.dart';
part 'widgets/search_button_cities_section.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FavoritesCitiesBloc _favoritesCitiesBloc;
  bool _isWeatherScreenPushed = false;

  @override
  void initState() {
    super.initState();

    _favoritesCitiesBloc = FavoritesCitiesBloc(
      favoritesRepository: DIContainer.favoritesScreenRepository,
    );
    _favoritesCitiesBloc.loadFavoritesRequested();
  }

  @override
  void dispose() {
    _favoritesCitiesBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),

      body: StreamBuilder<FavoritesState>(
        stream: _favoritesCitiesBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data;

          switch (state) {
            case null:
            case FavoritesState$Loading():
              return const Center(child: CircularProgressIndicator());

            case FavoritesState$Success(
              :final favoriteCities,
              :final weatherByCity,
            ):
              _tryOpenWeatherScreen(favoriteCities);

              return _ListFavoritesCitiesSection(
                favoriteCities: favoriteCities,
                weatherByCity: weatherByCity,
                onTapCity: (city) =>
                    Navigator.pushNamed(context, '/weather', arguments: city),
                onRemoveAt: _favoritesCitiesBloc.favoriteRemovedAt,
                onRefreshCity: _favoritesCitiesBloc.favoriteRefreshed,
              );

            case FavoritesState$Error(:final message):
              return _FavoritesErrorSection(
                message: message,
                onRetry: () {
                  _favoritesCitiesBloc.loadFavoritesRequested();
                },
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(22),
        child: StreamBuilder<FavoritesState>(
          stream: _favoritesCitiesBloc.state,
          builder: (context, snapshot) {
            final state = snapshot.data;

            switch (state) {
              case null:
              case FavoritesState$Loading():
                return _SearchButtonCitiesSection(
                  citiesLoading: true,
                  allCities: const [],
                  onAddFavorite: (city) {
                    _favoritesCitiesBloc.favoriteAdded(city);
                  },
                  findBestMatch: (_) => null,
                  citiesErrorMessage: null,
                );

              case FavoritesState$Success(
                :final isCitiesLoading,
                :final allCities,
                :final citiesErrorMessage,
              ):
                return _SearchButtonCitiesSection(
                  citiesLoading: isCitiesLoading,
                  allCities: allCities,
                  onAddFavorite: (city) {
                    _favoritesCitiesBloc.favoriteAdded(city);
                  },
                  findBestMatch: _favoritesCitiesBloc.findBestMatch,
                  citiesErrorMessage: citiesErrorMessage,
                );

              case FavoritesState$Error():
                return TextButton(
                  onPressed: () {
                    _favoritesCitiesBloc.loadFavoritesRequested();
                  },
                  child: const Text('Повторить загрузку'),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  void _tryOpenWeatherScreen(List<String> favoriteCities) {
    if (_isWeatherScreenPushed || favoriteCities.isEmpty) {
      return;
    }

    _isWeatherScreenPushed = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      Navigator.pushNamed(context, '/weather', arguments: favoriteCities.first);
    });
  }
}

class _FavoritesErrorSection extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _FavoritesErrorSection({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
