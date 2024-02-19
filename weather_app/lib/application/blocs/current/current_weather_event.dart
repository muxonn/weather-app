part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent {}

class QueryForLocationEvent extends CurrentWeatherEvent {
  final String location;

  QueryForLocationEvent({required this.location});
}
