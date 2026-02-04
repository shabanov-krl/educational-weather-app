part of '../weather_screen.dart';

class _DailyWeatherSection extends StatefulWidget {
  const _DailyWeatherSection();

  @override
  State<_DailyWeatherSection> createState() => _DailyWeatherSectionState();
}

class _DailyWeatherSectionState extends State<_DailyWeatherSection> {
  late final DailyWeatherBloc _dailyWeatherBloc;

  @override
  void initState() {
    super.initState();

    _dailyWeatherBloc = DailyWeatherBloc(
      weatherScreenRepository: DIContainer.weatherScreenRepository,
    );
    _dailyWeatherBloc.getDailyWeather();
  }

  @override
  void dispose() {
    _dailyWeatherBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DailyWeatherState>(
      stream: _dailyWeatherBloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data;
        switch (state) {
          case null:
          case DailyWeatherState$Loading():
            return const Center(child: CircularProgressIndicator());
          case DailyWeatherState$Success(:final dailyWeather):
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: dailyWeather.map((dataDailyWeather) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dataDailyWeather.day,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                weatherConditionIcons[dataDailyWeather
                                    .condition],
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                '${dataDailyWeather.precipitation}%',
                                style: const TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${dataDailyWeather.low}° / ${dataDailyWeather.high}°',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          case DailyWeatherState$Error(:final message):
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _dailyWeatherBloc.getDailyWeather,
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
