import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  final String country;
  final List<String> cities;

  @override
  String toString() {
    return country + '- ' + cities.toString();
  }

  Country(this.country, this.cities);

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
