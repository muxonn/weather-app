import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/forecast/forecast_weather_repository.dart';
import 'package:weather_app/data/forecast/models/forecast_weather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc
    extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  final ForecastWeatherRepository repository;

  ForecastWeatherBloc({required this.repository})
      : super(ForecastWeatherInitial()) {
    on<QueryForForecastEvent>((event, emit) async {
      final location = event.location;

      final state = this.state;
      if (state is ForecastWeatherLoaded) {
        emit(ForecastWeatherLoading(lastWeather: state.weather));
      } else {
        emit(ForecastWeatherLoading());
      }

      final weather = await repository.getForecastWeather(location);

      if (weather != null) {
        emit(ForecastWeatherLoaded(weather: weather));
      } else {
        final newState = this.state;
        if (newState is ForecastWeatherLoading &&
            newState.lastWeather != null) {
          emit(ForecastWeatherLoaded(weather: newState.lastWeather!));
        } else {
          emit(ForecastWeatherLoaded());
        }
      }
    });
  }
}
