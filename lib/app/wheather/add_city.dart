import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/helper/city_helper.dart';
import 'package:weather_app/models/country/country.dart';

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

class CitiesListWidget extends StatefulWidget {
  const CitiesListWidget({
    Key? key,
    required this.countries,
    required this.selectedCity,
  }) : super(key: key);

  final List<Country> countries;
  final Function(String city) selectedCity;

  @override
  State<CitiesListWidget> createState() => _CitiesListWidgetState();
}

class _CitiesListWidgetState extends State<CitiesListWidget> {
  late TextField search;

  @override
  void initState() {
    search = TextField(
      onChanged: (text) {
        if (text.length > 2) {
          setState(() {});
        }
      },
      controller: TextEditingController(text: 'Turkey'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        search,
        Expanded(
          child: ListView(
            children: widget.countries
                .map((e) {
                  var filteredCities = e.cities
                      .where((city) => city.contains(search.controller!.text));
                  if (filteredCities.isEmpty) {
                    return null;
                  } else {
                    return Country(e.country, filteredCities.toList());
                  }
                })
                .where((e) => e != null)
                .map((e) => CountryWidget(
                      country: e!,
                      selectedCity: widget.selectedCity,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class CountryWidget extends StatelessWidget {
  final Function(String city) selectedCity;
  final Country country;
  const CountryWidget({
    Key? key,
    required this.country,
    required this.selectedCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            country.country,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          ListView(
            shrinkWrap: true,
            children: country.cities
                .map((e) => ListTile(
                      onTap: () {
                        selectedCity(e);
                      },
                      trailing: const Icon(Icons.add),
                      title: Text(
                        e,
                        style: const TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
