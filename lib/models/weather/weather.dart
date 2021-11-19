import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String name;
  final double lat;
  final double lon;
  final String title;
  final String description;
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  @JsonKey(name: 'speed')
  final double windSpeed;

  Weather(this.title, this.description, this.temp, this.feelsLike, this.tempMin,
      this.tempMax, this.windSpeed, this.name, this.lat, this.lon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
