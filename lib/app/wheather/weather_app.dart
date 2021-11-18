import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/add_city/add_city.dart';
import 'package:weather_app/helpers/weather_helper.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  final String title;
  const WeatherApp({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WeatherHelper.currentWeather('Kadikoy');
    WeatherRepository();
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
                          WeatherRepository().addCity(city);
                        },
                      ),
                    ));
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: StreamBuilder<List<String>>(
        stream: WeatherRepository().weathersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView(
              children: snapshot.data!.map((e) => Text(e)).toList(),
            );
          } return const CircularProgressIndicator();
        },
      ),
    );
  }
}
