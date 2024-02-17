import 'package:weather_app/data/forecast/models/forecast_weather.dart';
import 'package:weather_app/data/forecast/models/weather_hour.dart';

class FormattedForecast {
  FormattedForecast({required this.forecastWeather});

  ForecastWeather forecastWeather;

  String getFormattedHour(String time) {
    int hour = DateTime.parse(time).hour;

    if (hour == 0) {
      return '12am';
    }

    if (hour == 12) {
      return '12pm';
    }

    if (hour < 12) {
      return '${hour}am';
    } else {
      return '${hour - 12}pm';
    }
  }

  List<WeatherHour> getForecastHours() {
    int currentHour = DateTime.now().hour;
    List<WeatherHour> joinedHours = [
      ...forecastWeather.forecastDays![0].hour!,
      ...forecastWeather.forecastDays![1].hour!
    ];

    List<WeatherHour> next24Hours = [];
    for (int i = currentHour; i < currentHour + 24; i++) {
      next24Hours.add(joinedHours[i]);
    }

    for (var i in next24Hours) {
      print(i.time);
    }
    return next24Hours;
  }
}
