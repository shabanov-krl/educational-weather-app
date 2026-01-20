import 'dart:math';
import 'package:test_project_weather/utility/utility.dart';
import 'package:test_project_weather/weather_page/data_wt_page/utility.dart';


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

class WeatherSummary {
  final int tomorrowHigh;
  final String changes;

  WeatherSummary({
    required this.tomorrowHigh,
    required this.changes,
  });
}

class CurrentWeather {
  final String city;
  final int currentTemp;
  final int high;
  final int low;
  final String condition;

  CurrentWeather({
    required this.city,
    required this.currentTemp,
    required this.high,
    required this.low,
    required this.condition,
  });
}

class CurrentWeatherGenerator {
  static Future<CurrentWeather> generateAsync(Random rnd) async {

    await randomDelay(rnd, minSec: 2, maxSec: 4);

    if (rnd.nextBool()) {
      throw WeatherException('Ошибка загрузка текущей погоды');
    }

    final currentTemp = 10 + rnd.nextInt(15);
    final high = currentTemp + rnd.nextInt(5);
    final low = currentTemp - rnd.nextInt(6);

    return CurrentWeather(
      city: 'Krasnodar',
      currentTemp: currentTemp,
      high: high,
      low: low,
      condition: WeatherConditions.random(rnd),
    );
  }
}

class HourlyForecastGenerator {
  static Future<List<HourlyWeather>> generateAsync(
    DateTime now,
    int baseTemp,
    Random rnd,
  ) async {

    await randomDelay(rnd, minSec: 3, maxSec: 8);

    if (rnd.nextBool()) {
      throw WeatherException('Ошибка загрузки почасового прогноза');
    }

    return List.generate(24, (i) {
      final hour = now.add(Duration(hours: i));
      return HourlyWeather(
        i == 0 ? 'Сейчас' : '${hour.hour.toString().padLeft(2, '0')}:00',
        baseTemp + rnd.nextInt(3) - 1,
        rnd.nextInt(80),
        WeatherConditions.random(rnd),
      );
    });
  }
}


class DailyForecastGenerator {
  static Future<List<DailyWeather>> generateAsync(
    DateTime now, 
    Random rnd
  ) async {

    await randomDelay(rnd);

    //if (false) {
    if (rnd.nextBool()) {
      throw WeatherException('Ошибка загрузки прогноза на дни');
    }

    return List.generate(10, (i) {
      final date = now.add(Duration(days: i + 1));
      return DailyWeather(
        i == 0 ? 'Завтра' : WeatherConditions.weekday(date.weekday),
        10 + rnd.nextInt(15),
        5 + rnd.nextInt(10),
        WeatherConditions.random(rnd),
        rnd.nextInt(80),
      );
    });
  }
}


class WeatherSummaryGenerator {
  static WeatherSummary generate(
    int todayHigh,
    Random rnd,
  ) {

    final tomorrowHigh = 10 + rnd.nextInt(15);

    return WeatherSummary(
      tomorrowHigh: tomorrowHigh,
      changes: tomorrowHigh > todayHigh ? 'повышение' : 'понижение'
    );
  }
}

class WeatherConditions {
  static const _conditions = [
    'Преимущественно облачно',
    'Частично облачно',
    'Ясно',
    'Дождь',
    'Небольшой дождь',
    'Тумано',
  ];

  static String random(Random rnd) =>
      _conditions[rnd.nextInt(_conditions.length)];

  static String weekday(int weekday) {
    const days = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];
    return days[weekday - 1];
  }
}
