part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState {}

class CurrentWeatherInitial extends CurrentWeatherState {}

class CurrentWeatherLoading extends CurrentWeatherState {
  final CurrentWeather? lastWeather;

  CurrentWeatherLoading({this.lastWeather});
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  final CurrentWeather? weather;

  CurrentWeatherLoaded({this.weather});
}
