import 'package:flutter/material.dart';
import 'package:test_project_weather/weather_page/bloc_wt_page/gen_func.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather main',
      theme: ThemeData.dark(),
      home: const WeatherPage(),
    );
  }
}
