import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/core/weather_client.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/views/home_page.dart';

void main() {
  runApp(Provider(
      create: (context) => WeatherClient(),
      child: Provider(
        create: (context) => CurrentWeatherRepository(),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
