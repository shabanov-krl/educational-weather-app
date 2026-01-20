import 'package:flutter/material.dart';
import 'package:test_project_weather/weather_page/bloc_wt_page/gen_func.dart';

import '../data_wt_page/generate.dart';

class WeatherHeader extends StatelessWidget {
  final WeatherData weather;

  const WeatherHeader({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {

    final scale = MediaQuery.of(context).size.width / 375;

    return Column(
      children: [
        Text(
          'Мое местоположение',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16 * scale,
          ),
        ),
        Text(
          weather.city,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36 * scale,
          ),
        ),
        Text(
          '${weather.currentTemp}°',
          style: TextStyle(
            fontSize: 90 * scale,
            fontWeight: FontWeight.w200,
          ),
        ),
        Text(
          weather.condition,
          style: TextStyle(fontSize: 22 * scale),
        ),
        Text(
          'H:${weather.high}°  L:${weather.low}°',
          style: TextStyle(fontSize: 14 * scale),
        ),
      ],
    );
  }
}


class WidgetsWeatherSummary extends StatelessWidget {
  final WeatherData weather;

  const WidgetsWeatherSummary({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(26, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Завтра ожидается ${weather.changes} температуры, '
        'максимальная температура составит ${weather.tomorrowHigh}°.',
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourly;

  const HourlyForecast({required this.hourly, super.key});

  @override
  Widget build(BuildContext context) {
      return AspectRatio (
      aspectRatio: 4.5,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: hourly.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final dataHour = hourly[index];
          return Column(
            spacing: 2.2,
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
  }
}

class ForecastInfo extends StatelessWidget {
  const ForecastInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
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
    );
  }
}


class DailyForecast extends StatelessWidget {
  final List<DailyWeather> daily;

  const DailyForecast({required this.daily, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: daily.map((dataDay) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(dataDay.day,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 18)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      ImageIcon.getWeatherIcon(dataDay.condition),
                      color: Colors.white,
                      size: 20,
                    ),
                    Text('${dataDay.precipitation}%',
                        style: const TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  '${dataDay.low}° / ${dataDay.high}°',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}



class ImageIcon {
  static IconData getWeatherIcon(String condition) {
    switch (condition) {
      case 'Ясно':
        return Icons.wb_sunny;
      case 'Частично облачно':
        return Icons.wb_cloudy;
      case 'Преимущественно облачно':
        return Icons.cloud;
      case 'Дождь':
        return Icons.umbrella;
      case 'Небольшой дождь':
        return Icons.water_drop;
      case 'Тумано':
        return Icons.opacity;
      default:
        return Icons.cloud;
    }
  }
}
