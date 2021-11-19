import 'package:flutter/material.dart';
import 'package:weather_app/repository/weather_repository.dart';

class ErrorCityWidget extends StatelessWidget {
  final String city;
  final String errorText;
  const ErrorCityWidget(
      {Key? key, required this.city, required this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          leading:const Icon(Icons.error),
          title: Text(errorText),
          trailing: IconButton(
            onPressed: () {
              WeatherRepository().removeCity(city);
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
class ErrorTextWidget extends StatelessWidget {
  final String errorText;
  const ErrorTextWidget(
      {Key? key,  required this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          leading:const Icon(Icons.error),
          title: Text(errorText),
         
        ),
      ),
    );
  }
}
