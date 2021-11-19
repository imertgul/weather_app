import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/helpers/location_helper.dart';
import 'package:weather_app/helpers/weather_helper.dart';
import 'package:weather_app/models/weather/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

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

class WeatherCard extends StatefulWidget {
  final Weather weather;
  const WeatherCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  static const _animationDuration = 300;
  bool isCardOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCardOpen = !isCardOpen;
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.all(8),
          height: isCardOpen ? 150 : 100,
          duration: const Duration(milliseconds: _animationDuration),
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(widget.weather.name),
                      Text(widget.weather.lat.toString() + ' ' + widget.weather.lon.toString()),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.weather.temp.toString() + '°'),
                      Text(widget.weather.title),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: _animationDuration),
                  child: !isCardOpen
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                    CommunityMaterialIcons.arrow_down_bold),
                                Text(widget.weather.tempMin.toString() + '°'),
                                const Icon(
                                    CommunityMaterialIcons.arrow_up_bold),
                                Text(widget.weather.tempMax.toString() + '°'),
                                const Icon(CommunityMaterialIcons.wind_turbine),
                                Text(widget.weather.windSpeed.toString() +
                                    ' km/s'),
                              ],
                            ),
                            Row(
                              children: [
                                Text(widget.weather.description.toTitleCase()),
                                Expanded(child: Container()),
                                TextButton(
                                  onPressed: () {
                                    WeatherRepository()
                                        .removeCity(widget.weather.name);
                                  },
                                  child: const Text('Delete'),
                                )
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}
