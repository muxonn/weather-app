import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Future<CurrentWeather> getCurrentWeather() async {
    CurrentWeatherRepository currentWeatherRepository =
        CurrentWeatherRepository();
    final data = await currentWeatherRepository.getCurrentWeather("Warsaw");
    print(data.conditionIcon);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(getCurrentWeather);
    final snapshot = useFuture(future);

    //getCurrentWeather();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Weather App"),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: Center(
        child: snapshot.hasData
            ? buildCurrentWeather(snapshot.data as CurrentWeather)
            : CircularProgressIndicator(),
      ),
    );
  }

  Widget buildCurrentWeather(CurrentWeather data) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            "${data.locationName}, ${data.country}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "${data.conditionText}",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${data.temperatureCelcius?.round()}°",
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Container(
                child: Image.network(
                  "https:${data.conditionIcon}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
