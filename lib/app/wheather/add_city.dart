import 'package:flutter/material.dart';
import 'package:weather_app/helper/city_helper.dart';

class AddCity extends StatelessWidget {
  const AddCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CityHelper.fetchCountry();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cities'),
      ),
    );
  }
}
