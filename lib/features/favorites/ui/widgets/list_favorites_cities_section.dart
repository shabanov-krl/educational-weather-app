part of '../favorites_screen.dart';

class _ListFavoritesCitiesSection extends StatelessWidget {
  final List<String> favoriteCities;
  final Map<String, FavoritesCitiesModel> weatherByCity;
  final void Function(FavoritesCitiesModel cityWeather) onTapCity;
  final void Function(int cityId) onRemoveCity;

  const _ListFavoritesCitiesSection({
    required this.favoriteCities,
    required this.weatherByCity,
    required this.onTapCity,
    required this.onRemoveCity,
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

        return Dismissible(
          key: ValueKey(cityWeather?.cityId ?? '$city$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            if (cityWeather != null) {
              onRemoveCity(cityWeather.cityId);
            }
          },
          child: ListTile(
            title: Text(
              city,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(cityWeather?.condition ?? 'Нет данных'),
            trailing: cityWeather == null
                ? const Text('—')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${cityWeather.currentTemp}°',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'H:${cityWeather.high}° L:${cityWeather.low}°',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
            onTap: cityWeather == null ? null : () => onTapCity(cityWeather),
          ),
        );
      },
    );
  }
}