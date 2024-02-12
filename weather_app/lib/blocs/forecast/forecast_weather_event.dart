part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherEvent {}

class QueryForLocationEvent extends ForecastWeatherEvent {
  final String location;

  QueryForLocationEvent({required this.location});
}
