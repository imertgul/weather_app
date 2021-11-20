import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepository {
  //To make it singleton
  static final _instance = WeatherRepository._();
  factory WeatherRepository() => _instance;
  //key of shared pref
  static const _cityKey = 'cities';
  //Stream for weatherList state
  final _savedWeathers = StreamController<List<String>>();

  WeatherRepository._() {
    initStream();
  }

  Stream<List<String>> get weathersStream => _savedWeathers.stream;

  Future<SharedPreferences> get _prefs async {
    WidgetsFlutterBinding.ensureInitialized();
    return await SharedPreferences.getInstance();
  }

  Future<void> initStream() async {
    var pref = await _prefs;
    var cities = pref.getStringList(_cityKey);
    if (cities != null) {
      _savedWeathers.add(cities);
    } else {
      _savedWeathers.add([]);
    }
  }

  Future<void> addCity(String city) async {
    var pref = await _prefs;
    var cities = pref.getStringList(_cityKey);
    if (cities != null) {
      cities.add(city);
      await pref.setStringList(_cityKey, cities);
      _savedWeathers.add(cities);
    } else {
      await pref.setStringList(_cityKey, <String>[city]);
      _savedWeathers.add(<String>[city]);
    }
  }

  Future<void> removeCity(String city) async {
    var pref = await _prefs;
    var cities = pref.getStringList(_cityKey);
    if (cities != null) {
      cities.remove(city);
      await pref.setStringList(_cityKey, cities);
      _savedWeathers.add(cities);
    } else {
      _savedWeathers.add([]);
    }
  }
}
