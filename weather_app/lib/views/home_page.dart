import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/blocs/current/current_weather_bloc.dart';
import 'package:weather_app/blocs/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';
import 'package:weather_app/data/forecast/forecast_weather_repository.dart';
import 'package:weather_app/data/forecast/formatted_hour.dart';
import 'package:weather_app/data/forecast/models/forecast_weather.dart';
import 'package:weather_app/data/forecast/models/weather_hour.dart';
import 'package:weather_app/views/widgets/hour_section.dart';
import 'package:weather_app/views/widgets/humidity_block.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentWeatherBloc(
            repository: context.read<CurrentWeatherRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ForecastWeatherBloc(
            repository: context.read<ForecastWeatherRepository>(),
          ),
        )
      ],
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, currentState) {
          final currentWeather = getCurrent(from: currentState);
          return BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
            builder: (context, forecastState) {
              final forecastWeather = getForecast(from: forecastState);
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
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
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
                              context.read<ForecastWeatherBloc>().add(
                                  QueryForForecastEvent(location: location));
                            },
                            constraints: const BoxConstraints(
                                maxWidth: 300, minHeight: 55),
                            leading: const Icon(Icons.search),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: currentWeather == null
                              ? Text('No data')
                              : buildCurrentWeather(currentWeather),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: forecastWeather == null
                              ? Text('no data')
                              : buildForecastWeather(forecastWeather),
                        ),
                        if (currentState is CurrentWeatherLoading &&
                            forecastState is ForecastWeatherLoading)
                          const Center(child: CircularProgressIndicator()),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          width: double.infinity,
                          child: Text("🌤️ Weather App, 2024"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
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
            Image.network(
              "https:${data?.conditionIcon}",
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Wrap(
            spacing: 10,
            children: [
              HumidityBlock(humidity: data!.humidity!),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildForecastWeather(ForecastWeather? data) {
    FormattedForecast formatted = FormattedForecast(forecastWeather: data!);
    List<WeatherHour> next24Hours = formatted.getForecastHours();

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            child: const Text(
              "Expected Feels Like",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          for (var hour in next24Hours)
            HourSection(
              time: formatted.getFormattedHour(hour.time!),
              temperatureCelcius: hour.temperatureCelcius.toString(),
              conditionText: hour.conditionText!,
              conditionIcon: hour.conditionIcon!,
            ),
          Divider(),
        ],
      ),
    );
  }
}
