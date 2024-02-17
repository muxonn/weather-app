import 'dart:convert';

import 'package:weather_app/data/core/weather_client.dart';
import 'package:weather_app/data/forecast/models/forecast_weather.dart';

class ForecastWeatherRepository {
  Future<ForecastWeather?> getForecastWeather(String location) async {
    WeatherClient client = WeatherClient();

    try {
      final response = await client.getForecast(location);

      final Map<String, dynamic> body = jsonDecode(response.body);
      return ForecastWeather.fromJson(body);
    } catch (e) {
      print("Exception! $e");
      return null;
    }
  }
}
