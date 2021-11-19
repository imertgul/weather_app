import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/widget/wrapper.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  final String title;
  const WeatherApp({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'add_city');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<String>>(
        stream: WeatherRepository().weathersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var cities = snapshot.data!;
            if (cities.isEmpty) {
              return const Center(child: Text('Please add one'));
            }
            List<Widget> cardList = cities.map((e) => WeatherCardWrapper(city: e, key: Key(e),)).cast<Widget>().toList();
            cardList.add(const WeatherByCoordWrapper());
            return ListView(
              children: cardList,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

