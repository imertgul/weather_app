import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherCard extends StatefulWidget {
  final Weather weather;
  final bool isLocationBased;
  const WeatherCard({
    Key? key,
    required this.weather,
    this.isLocationBased = false,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.weather.name, textAlign: TextAlign.start,),
                          widget.isLocationBased
                              ? const Icon(Icons.location_on_sharp)
                              : Container(),
                        ],
                      ),
                      Text(widget.weather.lat.toString() +
                          ' ' +
                          widget.weather.lon.toString()),
                    ],
                  ),
                  Expanded(child: Container()),
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
                                widget.isLocationBased
                                    ? Container()
                                    : TextButton(
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
