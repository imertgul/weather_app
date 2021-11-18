import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather/weather.dart';

class WeatherHelper {
  static Future<Weather> currentWeather(String city) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=b852e82532b0212520f11ba94eb9ca2f'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } throw StateError('Error while requesting current weather');
  }
}
