import 'package:weather_app/data/core/base_client.dart';
import 'package:weather_app/data/core/weather_client_path.dart';

class WeatherClient extends WABaseClient {
  //tutaj dac pobranie z weather_client_path
  //w current weather repository zmienic
  Future<dynamic> getCurrent(String location) async {
    //final response = await get(WeatherClientPath.current(location));
    final response = await get(WeatherClientPath.current(location));
    return response.body;
  }
}
