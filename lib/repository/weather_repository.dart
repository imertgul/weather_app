import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepository {
  static final _instance = WeatherRepository._();
  factory WeatherRepository() => _instance;
  static const _cityKey = 'cities';

  WeatherRepository._() {
    initStream();
  }

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

  Stream<List<String>> get weathersStream => _savedWeathers.stream;
  final _savedWeathers = StreamController<List<String>>();
}
