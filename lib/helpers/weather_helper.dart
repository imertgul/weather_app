import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/helpers/location_helper.dart';
import 'package:weather_app/models/weather/weather.dart';

const apiKey = 'b852e82532b0212520f11ba94eb9ca2f';

class WeatherHelper {
  static Future<Weather> currentWeather(String city) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    }
    throw StateError('Error while requesting current $city weather :${response.statusCode}');
  }

  static Future<Weather> currentWeatherByCoord(String lat, String lon) async {
    var response = await http.get(Uri.parse(
        'api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    }
    throw StateError('Error while requesting current weather');
  }
  static Future<Weather> currentWeatherByMyCoord() async {
    var locationData = await LocationHelper.getLocation();
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&units=metric&lon=${locationData.longitude}&appid=$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    }
    throw StateError('Error while requesting current weather by coord');
  }
}
