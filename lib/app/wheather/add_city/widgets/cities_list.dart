import 'package:flutter/material.dart';
import 'package:weather_app/models/country/country.dart';
import 'package:weather_app/repository/weather_repository.dart';

class CitiesListWidget extends StatefulWidget {
  const CitiesListWidget({
    Key? key,
    required this.countries,
  }) : super(key: key);

  final List<Country> countries;

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
            //refreshing the state of list
          }
        },
        controller: TextEditingController(text: 'Ist'),
        decoration: const InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(48),
            ),
            height: 48,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 6),
                  Expanded(
                    child: search,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: widget.countries
                  .map((e) {
                    //filter by search
                    var filteredCities = e.cities.where((city) =>
                        city.contains(search.controller!.text.capitalize()));
                    if (filteredCities.isEmpty) {
                      return null;
                    } else {
                      return Country(e.country, filteredCities.toList());
                    }
                  })
                  .where((e) => e != null)
                  .map((e) => CountryWidget(
                        country: e!,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CountryWidget extends StatelessWidget {
  final Country country;
  const CountryWidget({
    Key? key,
    required this.country,
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
          Column(
            children: country.cities
                .map((e) => ListTile(
                      onTap: () {
                        WeatherRepository().addCity(e);
                        Navigator.pop(context);
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
