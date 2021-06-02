part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String city;

  WeatherRequested({required this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}
