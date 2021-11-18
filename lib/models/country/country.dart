
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  final String country;
  final List<String> cities;

  @override
  String toString(){
    return country + '- ' + cities.toString();
  }

  Country(this.country, this.cities);

    factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CountryToJson`.
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}