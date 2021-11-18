import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/add_city/add_city.dart';
import 'package:weather_app/helpers/weather_helper.dart';

class WeatherApp extends StatelessWidget {
  final String title;
  const WeatherApp({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherHelper.currentWeather('Kadikoy');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCity(
                        selectedCity: (city) {
                          print(city);
                        },
                      ),
                    ));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: const Text('Weathers will be listed here'),
    );
  }
}
