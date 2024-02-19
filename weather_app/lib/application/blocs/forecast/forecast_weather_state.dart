part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherState {}

class ForecastWeatherInitial extends ForecastWeatherState {}

class ForecastWeatherLoading extends ForecastWeatherState {
  final ForecastWeather? lastWeather;

  ForecastWeatherLoading({this.lastWeather});
}

class ForecastWeatherLoaded extends ForecastWeatherState {
  final ForecastWeather weather;

  ForecastWeatherLoaded({required this.weather});
}
