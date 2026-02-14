part of '../favorites_screen.dart';

class _ListFavoritesCitiesSection extends StatelessWidget {
  final List<String> favoriteCities;
  final Map<String, FavoriteCityWeatherModel> weatherByCity;
  final void Function(String city) onTapCity;
  final void Function(int index) onRemoveAt;
  final Future<void> Function(String city) onRefreshCity;

  const _ListFavoritesCitiesSection({
    required this.favoriteCities,
    required this.weatherByCity,
    required this.onTapCity,
    required this.onRemoveAt,
    required this.onRefreshCity,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteCities.isEmpty) {
      return const Center(child: Text('Нет избранных городов'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: favoriteCities.length,
      separatorBuilder: (_, __) => const Divider(height: 2),
      itemBuilder: (context, index) {
        final city = favoriteCities[index];
        final cityWeather = weatherByCity[city];

        Widget subtitle;
        Widget trailing;

        if (cityWeather == null || cityWeather.isLoading) {
          subtitle = const Text('Загрузка...');
          trailing = const SizedBox(
            width: 64,
            child: Center(
              child: SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        } else if (cityWeather.hasError) {
          subtitle = Text(cityWeather.errorMessage ?? 'Ошибка загрузки');
          trailing = IconButton(
            onPressed: () {
              onRefreshCity(city);
            },
            icon: const Icon(Icons.refresh),
          );
        } else if (cityWeather.weather case final weather?) {
          subtitle = Text(weather.condition);
          trailing = Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${weather.currentTemp}°',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'H:${weather.high}° L:${weather.low}°',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        } else {
          subtitle = const Text('—');
          trailing = const Text('—');
        }

        return Dismissible(
          key: ValueKey('$city$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => onRemoveAt(index),
          child: ListTile(
            title: Text(
              city,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: subtitle,
            trailing: trailing,
            onTap: () => onTapCity(city),
          ),
        );
      },
    );
  }
}
