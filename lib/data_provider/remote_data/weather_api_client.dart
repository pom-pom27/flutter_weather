import 'dart:convert';

import 'package:flutter_weather/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const _baseUrl = 'https://www.metaweather.com';

  final http.Client httpClient;

  WeatherApiClient({required this.httpClient});

  Future<int> getLocationId(String city) async {
    final locationUrl = '$_baseUrl/api/location/search/?query=$city';

    final locationResponse = await httpClient.get(
      Uri.parse(locationUrl),
    );
    // final locationResponse = await httpClient.get(
    //   Uri.http(
    //     _baseUrl,
    //     '/api/location/search/',
    //     {'query': city},
    //   ),
    // );

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for this city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;

    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$_baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(Uri.parse(weatherUrl));

    // final weatherResponse = await http.get(
    //   Uri.http(
    //     _baseUrl,
    //     '/api/location/$locationId',
    //   ),
    // );

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for this location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);

    return Weather.fromJson(weatherJson);
  }
}
