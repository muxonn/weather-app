import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/current/current_weather_repository.dart';
import 'package:weather_app/data/current/models/current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final CurrentWeatherRepository repository;

  CurrentWeatherBloc({required this.repository})
      : super(CurrentWeatherInitial()) {
    on<QueryForLocationEvent>((event, emit) async {
      final location = event.location;

      final state = this.state;
      if (state is CurrentWeatherLoaded) {
        emit(CurrentWeatherLoading(lastWeather: state.weather));
      } else {
        emit(CurrentWeatherInitial());
      }

      final weather = await repository.getCurrentWeather(location);

      if (weather != null) {
        emit(CurrentWeatherLoaded(weather: weather));
      } else {
        emit(CurrentWeatherInitial());
      }
    });
  }
}
