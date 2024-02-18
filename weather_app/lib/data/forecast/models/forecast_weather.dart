import 'package:weather_app/data/forecast/models/forecast_day.dart';

class ForecastWeather {
  ForecastWeather({this.forecastDays, this.locationName});

  List<ForecastDay>? forecastDays;
  String? locationName;
  ForecastWeather.fromJson(Map<String, dynamic> json) {
    forecastDays = List<ForecastDay>.from(
        json['forecast']['forecastday'].map((x) => ForecastDay.fromJson(x)));
    locationName = json['location']['name'];
  }
}
