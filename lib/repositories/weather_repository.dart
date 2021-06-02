import 'package:flutter_weather/data_provider/data_provider.dart';
import 'package:flutter_weather/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({required this.weatherApiClient});

  Future<Weather> getWeather(String city) async {
    final locationId = await weatherApiClient.getLocationId(city);
    return weatherApiClient.fetchWeather(locationId);
  }
}
