import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/weather_app.dart';
import 'package:weather_app/repository/weather_repository.dart';

import 'app/wheather/add_city/add_city.dart';

void main() {
  WeatherRepository();
  runApp(const MyApp());
}

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  'add_city': (context) => const AddCity(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const title = 'My Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ),
      home: const WeatherApp(
        title: title,
      ),
    );
  }
}
