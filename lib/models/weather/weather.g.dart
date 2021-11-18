// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['weather'][0]['main'] as String,
      json['weather'][0]['description'] as String,
      (json['main']['temp'] as num).toDouble(),
      (json['main']['feels_like'] as num).toDouble(),
      (json['main']['temp_min'] as num).toDouble(),
      (json['main']['temp_max'] as num).toDouble(),
      (json['wind']['speed'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'main': instance.title,
      'description': instance.description,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'speed': instance.windSpeed,
    };
