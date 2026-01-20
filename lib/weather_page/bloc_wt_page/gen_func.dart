import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_project_weather/weather_page/bloc_wt_page/utility.dart';
import 'package:test_project_weather/weather_page/data_wt_page/generate.dart';
import 'package:test_project_weather/weather_page/widget_wt_page/widgets.dart';

class WeatherData {
  final String city;
  final int currentTemp;
  final int high;
  final int low;
  final String condition;
  final int tomorrowHigh;
  final String changes;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;


  WeatherData({
    required this.city,
    required this.currentTemp,
    required this.high,
    required this.low,
    required this.condition,
    required this.tomorrowHigh,
    required this.changes,
    required this.hourly,
    required this.daily,
  });
}

class HeadWidget {
  final CurrentWeather current;
  final WeatherSummary summary;

  HeadWidget({
    required this.current,
    required this.summary,
  });
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final rnd = Random();

    final items = <Widget>[
      AsyncSection<HeadWidget>(
        load: () async {
          final current = await CurrentWeatherGenerator.generateAsync(rnd);
          final summary = WeatherSummaryGenerator.generate(current.high, rnd);

          return HeadWidget(
            current: current,
            summary: summary,
          );
        },
        builder: (data) => Column(
          children: [
            WeatherHeader(
              weather: WeatherData(
                city: data.current.city,
                currentTemp: data.current.currentTemp,
                high: data.current.high,
                low: data.current.low,
                condition: data.current.condition,
                tomorrowHigh: data.summary.tomorrowHigh,
                changes: data.summary.changes,
                hourly: const [],
                daily: const [],
              ),
            ),
            WidgetsWeatherSummary(
              weather: WeatherData(
                city: '',
                currentTemp: 0,
                high: 0,
                low: 0,
                condition: '',
                tomorrowHigh: data.summary.tomorrowHigh,
                changes: data.summary.changes,
                hourly: const [],
                daily: const [],
              ),
            ),
          ],
        ),
      ),

      AsyncSection<List<HourlyWeather>>(
        load: () async {
          final current = await CurrentWeatherGenerator.generateAsync(rnd);
          return HourlyForecastGenerator.generateAsync(
            now,
            current.currentTemp,
            rnd,
          );
        },
        builder: (hourly) => HourlyForecast(hourly: hourly),
      ),

      const Align(
        alignment: Alignment.center,
        child: ForecastInfo(),
      ),

      AsyncSection<List<DailyWeather>>(
        load: () => DailyForecastGenerator.generateAsync(now, rnd),
        builder: (daily) => DailyForecast(daily: daily),
      ),
    ];

    final gaps = <double>[
      24,
      0,  
      16, 
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 51, 56),
      body: SafeArea(
        child: ListView.separated(
          //padding: const EdgeInsets.all(12),//.symmetric(horizontal: 20, vertical: 12),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, index) =>
              SizedBox(height: gaps[index]),
        ),
      ),
    );
  }
}