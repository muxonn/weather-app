import 'dart:convert';

import 'package:weather_app/data/core/weather_client.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

class CurrentWeatherRepository {
  Future<CurrentWeather> getCurrentWeather(String location) async {
    WeatherClient client = WeatherClient();
    final response = await client.getCurrent(location);
    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(body);
    } else {
      throw Exception("Failed to load API");
    }
  }
}
