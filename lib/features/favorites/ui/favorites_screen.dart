import 'package:flutter/material.dart';
import 'package:test_project_weather/core/di_container.dart';
import 'package:test_project_weather/features/city_details/data/models/current_weather.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<String> _favorites = ['Krasnodar', 'Moscow'];
  final TextEditingController _controller = TextEditingController();
  final Map<String, Future<CurrentWeather>> _weatherFutures = {};
  bool _pushedWeather = false;

  @override
  void initState() {
    super.initState();
    for (final city in _favorites) {
      _weatherFutures[city] = DIContainer.favoritesScreenRepository
          .getCurrentWeather(city);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_pushedWeather && _favorites.isNotEmpty) {
        _pushedWeather = true;
        Navigator.pushNamed(context, '/weather', arguments: _favorites[0]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addFavorite(String city) {
    final trimmed = city.trim();
    if (trimmed.isEmpty) {
      return;
    }
    setState(() {
      _favorites.add(trimmed);
      _weatherFutures[trimmed] = DIContainer.favoritesScreenRepository
          .getCurrentWeather(trimmed);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text('Нет избранных городов'))
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final city = _favorites[index];
                return Dismissible(
                  key: ValueKey(city + index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      _favorites.removeAt(index);
                      _weatherFutures.remove(city);
                    });
                  },
                  child: FutureBuilder<CurrentWeather>(
                    future: _weatherFutures[city],
                    builder: (context, snapshot) {
                      Widget subtitle;
                      Widget trailing;

                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                      } else if (snapshot.hasError) {
                        subtitle = const Text('Ошибка загрузки');
                        trailing = const Text('—');
                      } else if (snapshot.data case final data?) {
                        subtitle = Text(data.condition);
                        trailing = Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${data.currentTemp}°',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'H:${data.high}° L:${data.low}°',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      } else {
                        subtitle = const Text('—');
                        trailing = const Text('—');
                      }

                      return ListTile(
                        title: Text(
                          city,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: subtitle,
                        trailing: trailing,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/weather',
                            arguments: city,
                          );
                        },
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 2),
              itemCount: _favorites.length,
            ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(22),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Поиск города или аэропорта',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(80),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: _addFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
