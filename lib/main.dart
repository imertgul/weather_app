import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/weather_app.dart';

import 'app/wheather/add_city.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddCity(),
    );
  }
}

