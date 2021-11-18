import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/country/country.dart';


class CityHelper{
  static Future<void> fetchCountry() async {
  // static Future<List<Country>> fetchCountry() async {
  var response = await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries'));
  if (response.statusCode == 200) {
    var countryList = jsonDecode(response.body);
    print(countryList['data']);
  }
}
}