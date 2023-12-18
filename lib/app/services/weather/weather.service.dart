import 'dart:async';

import 'package:get/get.dart';

import '../places/place.response.dart';
import '../preferences.dart';
import 'weather.provider.dart';
import 'weather.response.dart';

const _kUpdateWeatherInterval = 300;

class WeatherService extends GetxService {
  Place? _currentPlace;

  String get getCurrentLocation => _currentPlace.toString();

  void setCurrentPlace(Place place) {
    _currentPlace = place;
  }

  final RxMap<String, Weather?> weatherMap = RxMap();
  final Map<String, Place?> placeMap = RxMap();
  final WeatherProvider provider = Get.find();

  @override
  Future<void> onReady() async {
    super.onReady();

    /// re-fetch Weather after [_kUpdateWeatherInterval] seconds
    Timer.periodic(
      _kUpdateWeatherInterval.seconds,
      (_) => fetchWeather(),
    );
  }

  Future<void> fetchWeather() async {
    var places = (await Preference.getPlaces()).toList();
    if (_currentPlace != null) {
      places.add(_currentPlace!);
    }

    /// Update places
    placeMap.clear();
    placeMap.addEntries(places.map((e) => MapEntry(e.toString(), e)));

    /// Get weather
    if (places.isNotEmpty) {
      // Call multiples API same time to quickly fetch all weather
      await Future.wait(
        places.map(
          (Place place) async {
            try {
              // call API
              final weather = await provider.getWeather(
                lat: place.lat?.toString() ?? '',
                lon: place.lon?.toString() ?? '',
              );

              // Store data
              if (weather.body == null) throw Error();
              if (weatherMap[place.toString()] != null) {
                weatherMap.update(place.toString(), (value) => weather.body);
              } else {
                weatherMap[place.toString()] = weather.body;
              }
            } catch (e) {
              /// Error
              // Update weather to null
              if (weatherMap[place.toString()] != null) {
                weatherMap.update(place.toString(), (value) {
                  value!.fetchFailed = true;
                  return value;
                });
              } else {
                weatherMap[place.toString()] = null;
              }
            }
          },
        ),
      );
    }
  }

  List<String> get sortedPlaces {
    final list = weatherMap.keys.toList();
    var sortedList = <String>[];
    // Add current Place first
    if (_currentPlace != null) {
      list.remove(_currentPlace.toString());
      sortedList.add(_currentPlace.toString());
    }

    // Sort list again
    list.sort(
      (a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      },
    );

    // Add to the list
    sortedList.addAll(list);

    // Return
    return sortedList;
  }
}
