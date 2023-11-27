import 'package:flutter/material.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> getCurrentWeather() async {
    CurrentWeatherRepository currentWeatherRepository =
        CurrentWeatherRepository();
    final data = await currentWeatherRepository.getCurrentWeather("Warsaw");
    //print(data.conditionIcon);
  }

  @override
  Widget build(BuildContext context) {
    getCurrentWeather();
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                "Sunny",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Kebili, Mali",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "32°",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Icon(
                      Icons.sunny,
                      size: 60,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
