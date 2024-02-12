import 'package:bloc/bloc.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc
    extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  ForecastWeatherBloc() : super(ForecastWeatherInitial()) {
    on<ForecastWeatherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
