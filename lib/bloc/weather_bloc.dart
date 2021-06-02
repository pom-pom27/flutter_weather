import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/repositories/repositories.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial());

  final WeatherRepository weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        final weather = await weatherRepository.getWeather(event.city);

        yield WeatherLoadSuccess(weather);
      } catch (_) {
        yield WeatherLoadFail();
      }
    }
  }
}
