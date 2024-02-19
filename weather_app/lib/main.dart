import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/application/providers/theme_provider.dart';
import 'package:weather_app/data/core/weather_client.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/forecast/forecast_weather_repository.dart';
import 'package:weather_app/views/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherClient>(
          create: (context) => WeatherClient(),
        ),
        Provider<CurrentWeatherRepository>(
          create: (context) => CurrentWeatherRepository(),
        ),
        Provider<ForecastWeatherRepository>(
          create: (context) => ForecastWeatherRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final ThemeData themeData =
        ThemeData(brightness: isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
