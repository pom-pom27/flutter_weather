import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'temprature.dart';
import 'weather_condition.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  const CombinedWeatherTemperature({Key? key, required this.weather})
      : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: WeatherConditions(condition: weather.condition),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Temperature(
            temperature: weather.temp,
            high: weather.maxTemp,
            low: weather.minTemp,
          ),
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
