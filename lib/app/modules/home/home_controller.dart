import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../common/toast.dart';
import '../../services/geo/geolocator.dart';
import '../../services/my.get_controller.dart';
import '../../services/places/place.response.dart';
import '../../services/places/places.provider.dart';
import '../../services/preferences.dart';
import '../../services/weather/weather.response.dart';
import '../../services/weather/weather.service.dart';
import 'home_provider.dart';

class HomeController extends MyGetController<HomeProvider> {
  final locationError = Rxn<LocationState>();
  final weatherService = Get.find<WeatherService>();
  final placeProvider = Get.find<PlacesProvider>();

  List<String> get sortedPlaces => weatherService.sortedPlaces;

  String get currentLocation => weatherService.getCurrentLocation;

  Map<String, Weather?> get mapWeather => weatherService.weatherMap;

  Map<String, Place?> get mapPlace => weatherService.placeMap;

  final placeController = TextEditingController();
  final places = RxList<Place>();
  final place = Rxn<Place>();
  final autoCompleteIsOpening = false.obs;

  Future<void> Function() get refreshIndicator => locationError.value != null
      ? () async => fetchCurrentLocation()
      : () async => fetchWeather();

  @override
  void onReady() async {
    super.onReady();
    fetchCurrentLocation();
    // place changed
    ever(
      place,
      (_) async {
        if (_ != null) {
          await Preference.addPlace(_);
          fetchWeather();
        }
      },
    );
  }

  Future<void> fetchCurrentLocation() async {
    try {
      ready.value = false;
      await getCurrentPosition();
    } on LocationState catch (e) {
      /// Location Error
      if (e == LocationState.locationPermissionsAreDenied) {
        /// Re-request location
        final permission = await Geolocator.requestPermission();
        switch (permission) {
          case LocationPermission.denied:
          case LocationPermission.unableToDetermine:

            /// Permissions are denied, next time you could try
            /// requesting permissions again (this is also where
            /// Android's shouldShowRequestPermissionRationale
            /// returned true. According to Android guidelines
            /// your App should show an explanatory UI now.
            locationError.value = LocationState.locationPermissionsAreDenied;
            break;
          case LocationPermission.deniedForever:

            /// Denied Forever
            locationError.value =
                LocationState.locationPermissionsArePermanentlyDenied;
            break;
          case LocationPermission.whileInUse:
          case LocationPermission.always:

            /// Granted
            fetchCurrentLocation();
            return;
        }
      } else {
        /// Denied Forever
        /// Wait to Re-request location

        locationError.value = e;
      }
    } catch (e) {
      /// Unknown error
      showSnackBar(content: LocaleKeys.somethingWentWrong.tr);
      locationError.value = LocationState.noInternetConnection;
    } finally {
      await weatherService.fetchWeather();
      ready.value = true;
    }
  }

  Future<void> getCurrentPosition() async {
    final position = await GeoService.determinePosition();
    final lat = position.latitude;
    final lon = position.longitude;
    locationError.value = null;
    final place = await placeProvider.getPlacesFromLatLon(
      lat: lat.toString(),
      lon: lon.toString(),
    );
    if (place.body?.isNotEmpty ?? true) {
      weatherService.setCurrentPlace(place.body!.first);
    } else {
      throw LocationState.noInternetConnection;
    }
  }

  Future<void> fetchWeather() async {
    ready.value = false;
    await weatherService.fetchWeather();
    ready.value = true;
  }

  Future getPlaces({String key = ''}) async {
    if (key.isEmpty) {
      places.value = [];
      return;
    }
    try {
      /// Get all places
      final response = await placeProvider.getPlacesFromSuggestion(
        suggest: key,
      );

      /// Success
      final responsePlaces = response.body ?? [];
      places.value = [];
      places.addAll(responsePlaces);
    } catch (e) {
      showSnackBar(content: LocaleKeys.somethingWentWrong.tr);
    }
  }

  Future<void> delete(Place place) async {
    await Preference.deletePlace(place);
    weatherService.placeMap.remove(place.toString());
    weatherService.weatherMap.remove(place.toString());
  }
}
