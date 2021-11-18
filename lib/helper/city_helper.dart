import 'package:http/http.dart' as http;


class CityHelper{
  static Future<http.Response> fetchCities() {
  return http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries'));
}
}