import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/wheather/widget/wrapper.dart';
import 'package:weather_app/repository/auth_repository.dart';
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
              AuthRepository().signOut();
            },
            icon: const Icon(CommunityMaterialIcons.logout),
          ),
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
            List<Widget> cardList = [];
            if (cities.isEmpty) {
              cardList.add(const WeatherByCoordWrapper());
            } else {
              cardList = cities
                  .map((e) => WeatherCardWrapper(
                        city: e,
                        key:
                            ValueKey('wrapper' + e + DateTime.now().toString()),
                        //uniq key
                      ))
                  .cast<Widget>()
                  .toList();
              cardList.insert(0, const WeatherByCoordWrapper());
            }
            //List of weather list builded here
            return ListView(
              children: cardList,
            );
          }
          return const Center(child:  CircularProgressIndicator());
        },
      ),
    );
  }
}
