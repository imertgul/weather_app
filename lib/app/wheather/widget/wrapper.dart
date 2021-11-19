import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/helpers/location_helper.dart';
import 'package:weather_app/helpers/weather_helper.dart';
import 'package:weather_app/models/weather/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

import 'weather_card.dart';

class WeatherCardWrapper extends StatelessWidget {
  final String city;
  const WeatherCardWrapper({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: WeatherHelper.currentWeather(city),
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) {
          return WeatherCard(
            key: ValueKey(city),
            weather: snap.data!,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
class WeatherByCoordWrapper extends StatelessWidget {
  const WeatherByCoordWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: WeatherHelper.currentWeatherByMyCoord(),
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) {
          return WeatherCard(
            key: ValueKey(snap.data!.name),
            weather: snap.data!,
            isLocationBased: true,
          );
        }
        if (snap.hasError) {
          return Text(snap.error.toString());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}