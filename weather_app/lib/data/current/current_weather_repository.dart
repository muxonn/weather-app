import 'package:weather_app/data/core/weather_client.dart';

class CurrentWeatherRepository {
  Future<void> getCurrentWeather(String location) async {
    WeatherClient client = WeatherClient();
    final response = await client.getCurrent(location);
    print(response);
  }
}
