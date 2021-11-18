import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/add_city/widgets/cities_list.dart';
import 'package:weather_app/helpers/city_helper.dart';

class AddCity extends StatelessWidget {
  final Function(String city) selectedCity;
  const AddCity({Key? key, required this.selectedCity}) : super(key: key);

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
            return CitiesListWidget(
                countries: snapshot.data!.countries,
                selectedCity: selectedCity);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}