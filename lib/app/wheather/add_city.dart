import 'package:flutter/material.dart';
import 'package:weather_app/helper/city_helper.dart';
import 'package:weather_app/models/country/country.dart';

class AddCity extends StatelessWidget {
  const AddCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cities'),
      ),
      body: FutureBuilder<CountriesResponse>(
        future: CityHelper.fetchCountry(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.countries.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
