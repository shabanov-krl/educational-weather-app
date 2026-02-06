part of '../city_details_screen.dart';

class _CurrentWeatherSection extends StatefulWidget {
  final String city;

  const _CurrentWeatherSection(this.city);

  @override
  State<_CurrentWeatherSection> createState() => _CurrentWeatherSectionState();
}

class _CurrentWeatherSectionState extends State<_CurrentWeatherSection> {
  late final CurrentWeatherBloc _currentWeatherBloc;

  @override
  void initState() {
    super.initState();

    _currentWeatherBloc = CurrentWeatherBloc(
      weatherScreenRepository: DIContainer.weatherScreenRepository,
    );

    _currentWeatherBloc.getCurrentWeather(widget.city);
  }

  @override
  void dispose() {
    _currentWeatherBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(kshabanov): rename to textTheme +
    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder<CurrentWeatherState>(
      stream: _currentWeatherBloc.state,
      builder: (context, snapshot) {
        final data = snapshot.data;

        switch (data) {
          case null:
          case CurrentWeatherState$Loading():
            return const Center(child: CircularProgressIndicator());
          case CurrentWeatherState$Success(:final currentWeather):
            return SizedBox(
              height: 420,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Мое местоположение',
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      currentWeather.city,
                      style: textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 42,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${currentWeather.currentTemp}°',
                        style: textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 96,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      currentWeather.condition,
                      style: textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Text(
                    'H:${currentWeather.high}°  L:${currentWeather.low}°',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Text(
                    'Завтра ожидается ${currentWeather.changes} температуры, '
                    'максимальная температура составит ${currentWeather.high}°.',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
            
          case CurrentWeatherState$Error():
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.message,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        _currentWeatherBloc.getCurrentWeather(widget.city);
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );
        }

        return const Center(child: Text('Неизвестное состояние'));
      },
    );
  }
}
