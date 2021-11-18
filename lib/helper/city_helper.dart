import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/country/country.dart';

class CityHelper {
  // static Future<void> fetchCountry() async {
    static Future<CountriesResponse> fetchCountry() async {
    var response = await http
        .get(Uri.parse('https://countriesnow.space/api/v0.1/countries'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return CountriesResponse((data['data'] as List<dynamic>).map((e) => Country.fromJson(e)).toList());
    }
    throw StateError('Error while requesting countries');
  }
}

class CountriesResponse {
  final List<Country> countries;

  CountriesResponse(this.countries);
}
