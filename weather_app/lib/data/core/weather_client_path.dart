import 'package:weather_app/data/api/api_key.dart';

class WeatherClientPath {
  static Uri current(String location) {
    return Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$key&q=$location&aqi=no");
  }

  static Uri forecast(String location) {
    return Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$key&q=$location&days=1&aqi=no&alerts=no");
  }
}
