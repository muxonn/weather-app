import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/application/blocs/current/current_weather_bloc.dart';
import 'package:weather_app/application/blocs/forecast/forecast_weather_bloc.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';
import 'package:weather_app/data/forecast/forecast_weather_repository.dart';
import 'package:weather_app/data/forecast/formatted_hour.dart';
import 'package:weather_app/data/forecast/models/forecast_weather.dart';
import 'package:weather_app/data/forecast/models/weather_hour.dart';
import 'package:weather_app/views/widgets/hour_section.dart';
import 'package:weather_app/views/widgets/cloud_block.dart';
import 'package:weather_app/views/widgets/humidity_block.dart';
import 'package:weather_app/views/widgets/wind_block.dart';

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

  void submitSearch(
      BuildContext context, TextEditingController textController) {
    print(textController.text);
    final location = textController.text;
    context.read<CurrentWeatherBloc>().add(
          QueryForLocationEvent(location: location),
        );
    context
        .read<ForecastWeatherBloc>()
        .add(QueryForForecastEvent(location: location));
    textController.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
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
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: SearchBar(
                                  hintText: "Your location...",
                                  controller: textController,
                                  onSubmitted: (String value) async {
                                    submitSearch(context, textController);
                                  },
                                  constraints: const BoxConstraints(
                                      maxWidth: 300, minHeight: 55),
                                  leading: IconButton(
                                    onPressed: () {
                                      submitSearch(context, textController);
                                    },
                                    icon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: currentWeather == null
                                    ? SizedBox()
                                    : buildCurrentWeather(currentWeather),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: forecastWeather == null
                                    ? SizedBox()
                                    : buildForecastWeather(forecastWeather),
                              ),
                              if (currentState is CurrentWeatherLoading &&
                                  forecastState is ForecastWeatherLoading)
                                CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        width: double.infinity,
                        child: Text("🌤️ Weather App, 2024"),
                      ),
                    ),
                  ],
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
          child: Container(
            child: Wrap(
              spacing: 10,
              children: [
                CloudBlock(cloudiness: data!.cloudiness!)
                    .animate(
                        key: ValueKey(
                            '${data.locationName!}-${data.cloudiness}'))
                    .slide(
                      delay: 0.ms,
                      begin: Offset(0, 0.4),
                      end: Offset(0, 0),
                    )
                    .fade(),
                HumidityBlock(humidity: data.humidity!)
                    .animate(
                        key: ValueKey('${data.locationName!}-${data.humidity}'))
                    .slide(
                      delay: 300.ms,
                      begin: Offset(0, 0.4),
                      end: Offset(0, 0),
                    )
                    .fade(),
                WindBlock(
                        windDirection: data.windDirection!,
                        windSpeed: data.windKph!)
                    .animate(
                        key: ValueKey(
                            '${data.locationName!}-${data.windDirection}'))
                    .slide(
                      delay: 600.ms,
                      begin: Offset(0, 0.4),
                      end: Offset(0, 0),
                    )
                    .fade(),
              ],
            ),
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
          for (var i = 0; i < next24Hours.length; i++)
            HourSection(
              time: formatted.getFormattedHour(next24Hours[i].time!),
              date: next24Hours[i].time!,
              temperatureCelcius: next24Hours[i].temperatureCelcius.toString(),
              conditionText: next24Hours[i].conditionText!,
              conditionIcon: next24Hours[i].conditionIcon!,
            )
                .animate(key: ValueKey('${data.locationName!}-$i'))
                .slide(
                  delay: (300 * i / 2).ms,
                  begin: Offset(-0.4, 0),
                  end: Offset(0, 0),
                )
                .fade(),
          Divider(),
        ],
      ),
    );
  }
}
