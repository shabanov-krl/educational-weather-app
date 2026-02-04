part of '../weather_screen.dart';

class _HorlyWeatherSection extends StatefulWidget {
  const _HorlyWeatherSection();

  @override
  State<_HorlyWeatherSection> createState() => _HorlyWeatherSectionState();
}

class _HorlyWeatherSectionState extends State<_HorlyWeatherSection> {
  late final HourlyWeatherBloc _hourlyWeatherBloc;

  @override
  void initState() {
    super.initState();

    _hourlyWeatherBloc = HourlyWeatherBloc(
      weatherScreenRepository: DIContainer.weatherScreenRepository,
    );
    _hourlyWeatherBloc.getHourlyWeather();
  }

  @override
  void dispose() {
    _hourlyWeatherBloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<HourlyWeatherState>(
  stream: _hourlyWeatherBloc.state,
  builder: (context, snapshot) {
    final state = snapshot.data;
        switch (state) {
          case null:
          case HourlyWeatherState$Loading():
            return const Center(child: CircularProgressIndicator());
          case HourlyWeatherState$Success(:final hourlyWeather):
            return SizedBox(
              height: 100,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: hourlyWeather.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final dataHour = hourlyWeather[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(dataHour.time, style: const TextStyle(color: Colors.white70)),
                      Icon(
                        ImageIcon.getWeatherIcon(dataHour.condition),
                        color: Colors.white,
                        size: 28,
                      ),
                      Text('${dataHour.temperature}°',
                          style: const TextStyle(color: Colors.white)),
                      Text('${dataHour.precipitation}%',
                          style: const TextStyle(
                              color: Colors.lightBlueAccent, fontSize: 12)),
                    ],
                  );
                },
              ),
            );
          case HourlyWeatherState$Error(:final message):
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _hourlyWeatherBloc.getHourlyWeather,
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
