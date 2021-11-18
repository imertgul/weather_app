import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherHelper {
  static Future<void> currentWeather(String city) async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=b852e82532b0212520f11ba94eb9ca2f'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
    }
  }
}
