import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/helpers/weather_helper.dart';
import 'package:weather_app/models/weather/weather.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherCard extends StatefulWidget {
  final String city;
  const WeatherCard({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  static const _animationDuration = 300;
  bool isCardOpen = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: WeatherHelper.currentWeather(widget.city),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          var weather = snapshot.data!;
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
                            Text(widget.city),
                            const Text('lat long'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(weather.temp.toString() + '°'),
                            Text(weather.title),
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
                                      const Icon(CommunityMaterialIcons.arrow_down_bold),
                                      Text(weather.tempMin.toString()+ '°'),
                                      const Icon(CommunityMaterialIcons.arrow_up_bold),
                                      Text(weather.tempMax.toString()+ '°'),
                                      const Icon(CommunityMaterialIcons.wind_turbine),
                                      Text(weather.windSpeed.toString()+ ' km/s'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(weather.description),

                                      Expanded(child: Container()),
                                      // TextButton(
                                      //   onPressed: () {
                                      //     WeatherRepository().removeCity(widget.city);
                                      //   },
                                      //   child: const Text('Delete'),
                                      // )
                                      IconButton(
                                        onPressed: () {
                                          WeatherRepository()
                                              .removeCity(widget.city);
                                        },
                                        icon: const Icon(Icons.delete),
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
