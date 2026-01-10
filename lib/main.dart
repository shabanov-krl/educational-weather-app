import 'dart:math';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather test',
      theme: ThemeData.dark(),
      home: const WeatherPage(),
    );
  }
}


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}


class _WeatherPageState extends State<WeatherPage> {
  late WeatherData weather;


  @override
  void initState() {
    super.initState();
    weather = WeatherGenerator.generate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 51, 56),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSummary(),
              const SizedBox(height: 20),              
              _buildHourlyForecast(),
              const SizedBox(height: 20),
              _buildInfoForecast(),
              const SizedBox(height: 20),
              _buildDailyForecast(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Мое местоположение",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          weather.city,
          style: const TextStyle(color: Colors.white, fontSize: 36),
        ),
            const SizedBox(height: 12),
        Text(
          "${weather.currentTemp}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 100,
            fontWeight: FontWeight.w200,
          ),
        ),
        Text(
          weather.condition,
          style: const TextStyle(color: Colors.white70, fontSize: 24),
        ),
        Text(
          "H:${weather.high}°  L:${weather.low}°",
          style: const TextStyle(color: Colors.white60, fontSize: 16),
        ),
      ],
    );
  }


  Widget _buildHourlyForecast() {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: weather.hourly.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final h = weather.hourly[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(h.time, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Icon(
                WeatherGenerator.getWeatherIcon(h.condition),
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text("${h.temperature}°", style: const TextStyle(color: Colors.white)),
              Text("${h.precipitation}%", style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 12)),
            ],
          );
        },
      ),
    );
  }


  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        "Завтра ожидается ${weather.changes} температуры, максимальная температура составит ${weather.tomorrowHigh}°.",
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }

  Widget _buildInfoForecast() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Icon(
            Icons.event_note, 
            color: const Color.fromARGB(179, 177, 173, 173), 
            size: 16, 
          ),
          const SizedBox(width: 8), 
          Text(
            "Прогноз погоды на 10 дней", 
            style: const TextStyle(
              color: Color.fromARGB(179, 177, 173, 173),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDailyForecast() {
    return Column(
      children: weather.daily.map((d) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4), 
          child: Row(
            children: [
              Expanded(
                child: Text(
                  d.day,
                  textAlign: TextAlign.left, 
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      WeatherGenerator.getWeatherIcon(d.condition),
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "${d.precipitation}%", 
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 12,
                      )
                    ),
                  ]
                ),  
              ),
              Expanded(
                child: Text(
                  "${d.low}° / ${d.high}°",
                  textAlign: TextAlign.left, 
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


class HourlyWeather {
  final String time;
  final int temperature;
  final int precipitation;
  final String condition;


  HourlyWeather(this.time, this.temperature, this.precipitation, this.condition);
}


class DailyWeather {
  final String day;
  final int high;
  final int low;
  final String condition;
  final int precipitation;


  DailyWeather(this.day, this.high, this.low, this.condition, this.precipitation);
}


class WeatherGenerator {
  static final Random _rnd = Random();


  static WeatherData generate() {

    final now = DateTime.now();

    final currentTemp = 10 + _rnd.nextInt(15);
    final high = currentTemp + _rnd.nextInt(5);
    final low = currentTemp - _rnd.nextInt(6);
    final tomorrowHigh = 10 + _rnd.nextInt(15);
    final changes = tomorrowHigh > high ? 'повышение' : 'понижение';


    final hourly = <HourlyWeather>[];
    for (int i = 0; i < 24; i++) {
      final hourToAdd = now.add(Duration(hours: i));
      String formattedTime;
      if (i==0) {
        formattedTime = 'Сейчас';
      } else {
        formattedTime = '${hourToAdd.hour.toString().padLeft(2, '0')}:00';//${hourToAdd.minute.toString().padLeft(2, '0')}';
      }
      final hourlyCondition = _conditions[_rnd.nextInt(_conditions.length)];
      final tempVariation = _rnd.nextInt(3) - 1;
      final precip = _rnd.nextInt(80);

      hourly.add(HourlyWeather(formattedTime, currentTemp + tempVariation, precip, hourlyCondition));
    }


    final List<DailyWeather> daily = [];

    for (int i = 1; i <= 10; i++) {
      final futureDate = now.add(Duration(days: i));
      String dayName;
      if (i == 1) {
        dayName = "Завтра";
      } else {
        dayName = _formatWeekday(futureDate.weekday);
      }
      final dayHigh = 10 + _rnd.nextInt(15);
      final dayLow = 5 + _rnd.nextInt(10);
      final dayCondition = _conditions[_rnd.nextInt(_conditions.length)];
      final precip = _rnd.nextInt(80);
      daily.add(DailyWeather(dayName, dayHigh, dayLow, dayCondition, precip));
    }


    return WeatherData(
      city: "Krasnodar",
      currentTemp: currentTemp,
      high: high,
      low: low,
      condition: _conditions[_rnd.nextInt(_conditions.length)],
      tomorrowHigh: tomorrowHigh,
      changes: changes,
      hourly: hourly,
      daily: daily,
    );
  }


  static String _formatWeekday(int weekday) {
    const days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
    return days[weekday - 1];
  }


  static const _conditions = [
    // "Mostly Cloudy",
    // "Partly Cloudy",
    // "Clear",
    // "Rain",
    // "Light Rain",
    // "Foggy",


  "Преимущественно облачно",
  "Частично облачно",
  "Ясно",
  "Дождь",
  "Небольшой дождь",
  "Тумано"
  ];


  static IconData getWeatherIcon(String condition) {
    switch (condition) {
      case "Ясно":
        return Icons.wb_sunny;
      case "Частично облачно":
        return Icons.wb_cloudy;
      case "Преимущественно облачно":
        return Icons.cloud;
      case "Дождь":
        return Icons.umbrella;
      case "Небольшой дождь":
        return Icons.water_drop;
      case "Тумано":
        return Icons.opacity;
      default:
        return Icons.cloud;
    }
  }
}
