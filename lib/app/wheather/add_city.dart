import 'package:flutter/material.dart';
import 'package:weather_app/helper/city_helper.dart';

class AddCity extends StatelessWidget {
  const AddCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getCities();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cities'),
      ),
    );
  }

  Future<void> getCities() async {
    var response = await CityHelper.fetchCities();
    print(response.body.toString());
  }
}
