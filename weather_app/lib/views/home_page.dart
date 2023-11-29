import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Future<CurrentWeather> getCurrentWeather(String location) async {
    CurrentWeatherRepository currentWeatherRepository =
        CurrentWeatherRepository();
    final data = await currentWeatherRepository.getCurrentWeather(location);
    print(data.conditionIcon);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: create usememoized on start of app, but refresh page
    // basing on data value - not use future

    //final future = useMemoized(getCurrentWeather);
    //final snapshot = useFuture(future);
    final searchController = useTextEditingController();
    final data = useState(CurrentWeather());
    final isLoaded = useState(false);

    useMemoized(() async {
      isLoaded.value = false;
      final response = await getCurrentWeather("Warsaw");
      data.value = response;
      isLoaded.value = true;
    });

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: isLoaded.value
                  ? buildCurrentWeather(data.value as CurrentWeather)
                  : CircularProgressIndicator(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SearchBar(
                controller: searchController,
                onSubmitted: (String value) async {
                  print(searchController.text);
                  //data.value = await getCurrentWeather();
                  //print(data.value.country);
                  try {
                    isLoaded.value = false;
                    final response =
                        await getCurrentWeather(searchController.text);
                    data.value = response;
                    isLoaded.value = true;
                  } catch (e) {
                    print("No results");
                    final snackBar =
                        SnackBar(content: const Text("No results"));

                    isLoaded.value = true;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                constraints: const BoxConstraints(maxWidth: 300, minHeight: 55),
                leading: const Icon(Icons.search),
                backgroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentWeather(CurrentWeather data) {
    return Column(
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
    );
  }
}
