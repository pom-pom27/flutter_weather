import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/bloc.dart';
import 'package:flutter_weather/data_provider/data_provider.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:http/http.dart' as http;

import 'ui/screens/screens.dart';
import 'ui/widgets/widgets.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final WeatherRepository _weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    MyApp(
      weatherRepository: _weatherRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: WeatherScreen(),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitySelection()),
              );

              if (city != null) {
                BlocProvider.of<WeatherBloc>(context).add(
                  WeatherRequested(city: city),
                );
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return Center(child: Text('Please select a location'));
              }
              if (state is WeatherLoadInProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoadSuccess) {
                final weather = state.weather;

                return ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: Location(location: weather.location),
                      ),
                    ),
                    Center(
                      child: LastUpdated(dateTime: weather.lastUpdated),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: CombinedWeatherTemperature(weather: weather),
                    ),
                  ],
                );
              }
              if (state is WeatherLoadFail) {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
