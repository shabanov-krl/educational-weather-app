part of '../city_details_screen.dart';

class _DailyWeatherSection extends StatefulWidget {
  final String city;

  const _DailyWeatherSection(this.city);

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
    _dailyWeatherBloc.getDailyWeather(widget.city);
  }

  @override
  void dispose() {
    _dailyWeatherBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.event_note,
                  color: Color.fromARGB(179, 177, 173, 173),
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  'Прогноз погоды на 10 дней',
                  style: TextStyle(
                    color: Color.fromARGB(179, 177, 173, 173),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),

        StreamBuilder<DailyWeatherState>(
          stream: _dailyWeatherBloc.state,
          builder: (context, snapshot) {
            final state = snapshot.data;

            switch (state) {
              case null:
              case DailyWeatherState$Loading():
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
                );

              case DailyWeatherState$Success(:final dailyWeather):
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  itemCount: dailyWeather.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dataDailyWeather = dailyWeather[index];

                    return Row(
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
                                        .condition] ??
                                    Icons.help_outline,
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
                    );
                  },
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
                          onPressed: () =>
                              _dailyWeatherBloc.getDailyWeather(widget.city),
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
        ),
      ],
    );
  }
}
