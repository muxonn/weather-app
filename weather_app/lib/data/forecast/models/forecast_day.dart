import 'package:weather_app/data/forecast/models/weather_day.dart';
import 'package:weather_app/data/forecast/models/weather_hour.dart';

class ForecastDay {
  ForecastDay({
    this.date,
    this.hour,
    this.day,
  });

  DateTime? date;
  List<WeatherHour>? hour;
  WeatherDay? day;

  ForecastDay.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    hour = List<WeatherHour>.from(
        json["hour"].map((x) => WeatherHour.fromJson(x)));
    day = WeatherDay.fromJson(json['day']);
  }
}
