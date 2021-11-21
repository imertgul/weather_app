import 'package:flutter/material.dart';
import 'package:weather_app/app/auth/login.dart';
import 'package:weather_app/app/auth/register.dart';
import 'package:weather_app/app/wheather/weather_app.dart';
import 'package:weather_app/repository/auth_repository.dart';
import 'package:weather_app/repository/weather_repository.dart';

import 'app/wheather/add_city/add_city.dart';

void main()  {
  runApp(const MyApp());
}

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  'add_city': (context) => const AddCity(),
  'register': (context) => const RegisterPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const title = 'My Weather App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.orange,
          backgroundColor: Colors.black,
          fontFamily: 'Gilroy',
          iconTheme: const IconThemeData(color: Colors.orange),
          cardColor: Colors.white10,
          hoverColor: Colors.white10,
          brightness: Brightness.dark),
      home: FutureBuilder(
        future: AuthRepository().configureAmplify(),
        builder: (context, snap) {
          return StreamBuilder<AuthState>(
              stream: AuthRepository().authState,
              builder: (context, snap) {
                if (!snap.hasData && snap.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                var authState = snap.data;
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Builder(builder: (context) {
                    if (authState is AuthRequired) {
                      return const LoginPage();
                    } else if (authState is AuthSuccess) {
                      WeatherRepository(); //init weather repo
                      return const WeatherApp(
                        title: title,
                      );
                    }
                    throw StateError('No state');
                  }),
                );
              });
        }
      ),
    );
  }
}
