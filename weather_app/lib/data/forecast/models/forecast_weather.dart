import 'package:weather_app/data/forecast/models/forecast_day.dart';

class ForecastWeather {
  ForecastWeather({this.forecastDays});

  List<ForecastDay>? forecastDays;

  ForecastWeather.fromJson(Map<String, dynamic> json) {
    forecastDays =
        json['forecast']['forecastday'].map((x) => ForecastDay.fromJson(x));
  }
}
