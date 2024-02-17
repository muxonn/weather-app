part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherEvent {}

class QueryForForecastEvent extends ForecastWeatherEvent {
  final String location;

  QueryForForecastEvent({required this.location});
}
