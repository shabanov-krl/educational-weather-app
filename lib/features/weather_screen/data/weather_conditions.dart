import 'dart:math';

class WeatherConditions {
  static const _conditions = [
    'Преимущественно облачно',
    'Частично облачно',
    'Ясно',
    'Дождь',
    'Небольшой дождь',
    'Тумано',
  ];

  static String random() =>
      _conditions[Random().nextInt(_conditions.length)];

  static String weekday(int weekday) {
    const days = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];
    return days[weekday - 1];
  }
}