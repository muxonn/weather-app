import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/blocs/current/current_weather_bloc.dart';
import 'package:weather_app/blocs/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';
import 'package:weather_app/data/forecast/models/forecast_weather.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  CurrentWeather? getCurrent({required CurrentWeatherState from}) {
    final state = from;
    print(state);
    if (state is CurrentWeatherLoading) {
      return state.lastWeather;
    }

    if (state is CurrentWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  ForecastWeather? getForecast({required ForecastWeatherState from}) {
    final state = from;
    print(state);
    if (state is ForecastWeatherLoading) {
      return state.lastWeather;
    }

    if (state is ForecastWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return BlocProvider(
        create: (context) => CurrentWeatherBloc(
              repository: context.read<CurrentWeatherRepository>(),
            ),
        child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
            final weather = getCurrent(from: state);
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
                      padding: const EdgeInsets.only(top: 10),
                      child: SearchBar(
                        controller: textController,
                        onSubmitted: (String value) async {
                          print(textController.text);
                          final location = textController.text;
                          //data.value = await getCurrentWeather();
                          //print(data.value.country);
                          context.read<CurrentWeatherBloc>().add(
                                QueryForLocationEvent(location: location),
                              );
                        },
                        constraints:
                            const BoxConstraints(maxWidth: 300, minHeight: 55),
                        leading: const Icon(Icons.search),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: weather == null
                          ? Text('No data')
                          : buildCurrentWeather(weather),
                    ),
                    if (state is CurrentWeatherLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget buildCurrentWeather(CurrentWeather? data) {
    return Column(
      children: [
        Text(
          "${data?.locationName}, ${data?.country}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "${data?.conditionText}",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${data?.temperatureCelcius?.round()}°",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            //SizedBox(width: 10),
            Container(
              child: Image.network(
                "https:${data?.conditionIcon}",
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 10,
            children: [
              Container(width: 100, height: 80, color: Colors.black),
              Container(width: 100, height: 80, color: Colors.black),
              Container(width: 100, height: 80, color: Colors.black),
              Container(width: 100, height: 80, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
