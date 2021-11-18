import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/weather_app.dart';
import 'package:weather_app/repository/weather_repository.dart';

void main() {
  WeatherRepository();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const title = 'My Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const WeatherApp(
        title: title,
      ),
    );
  }
}
