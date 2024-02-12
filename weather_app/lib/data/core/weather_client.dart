import 'package:weather_app/data/core/base_client.dart';
import 'package:weather_app/data/core/weather_client_path.dart';

class WeatherClient extends WABaseClient {
  Future<dynamic> getCurrent(String location) async {
    final response = await get(WeatherClientPath.current(location));
    return response;
  }

  Future<dynamic> getForecast(String location) async {
    final response = await get(WeatherClientPath.forecast(location));
    return response;
  }
}
