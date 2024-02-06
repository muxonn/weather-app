import 'dart:convert';

import 'package:weather_app/data/core/weather_client.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

class CurrentWeatherRepository {
  Future<CurrentWeather?> getCurrentWeather(String location) async {
    WeatherClient client = WeatherClient();

    try {
      final response = await client.getCurrent(location);

      final Map<String, dynamic> body = jsonDecode(response.body);
      return CurrentWeather.fromJson(body);
    } catch (e) {
      print("Exception! $e");
      return null;
    }
  }
}
