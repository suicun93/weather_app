import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'places/place.response.dart';

class Preference {
  static Future<SharedPreferences> _instance() async {
    return SharedPreferences.getInstance();
  }

  /// Get language
  static Future<String?> getLanguage() async {
    final pref = await _instance();
    return pref.getString('language');
  }

  static Future setLanguage(String language) async {
    final pref = await _instance();
    pref.setString('language', language);
  }

  /// Get Cities
  static Future<Iterable<Place>> getPlaces() async {
    try {
      final pref = await _instance();
      final str = pref.getString('getPlaces') ?? '';
      final json = jsonDecode(str);
      if (str.isNotEmpty && json is Iterable) {
        return json.map((e) => Place.fromJson(e));
      } else {
        return const Iterable.empty();
      }
    } catch (e) {
      return const Iterable.empty();
    }
  }

  static Future addPlace(Place place) async {
    // recover old list
    final pref = await _instance();
    final str = pref.getString('getPlaces') ?? '';
    var places = <Place>[];
    final json = jsonDecode(str);
    if (str.isNotEmpty && json is Iterable) {
      places.addAll(json.map((e) => Place.fromJson(e)));
    }
    final duplicated = places.any((element) {
      return element.toString() == place.toString();
    });
    if (duplicated) return;
    places.add(place);
    // save
    pref.setString('getPlaces', jsonEncode(places));
  }

  static Future deletePlace(Place place) async {
    // recover old list
    final pref = await _instance();
    final str = pref.getString('getPlaces') ?? '';
    var places = <Place>[];
    final json = jsonDecode(str);
    if (str.isNotEmpty && json is Iterable) {
      places.addAll(json.map((e) => Place.fromJson(e)));
    }
    places.removeWhere((_) => place.toString() == _.toString());
    // save
    pref.setString('getPlaces', jsonEncode(places));
  }

  static Future removeAllPlace() async {
    final pref = await _instance();
    pref.setString('getPlaces', '');
  }

  /// Get Access Token
  static Future<String> getAccessToken() async {
    final pref = await _instance();
    return pref.getString('getAccessToken') ?? '';
  }

  static Future setAccessToken(String accessToken) async {
    final pref = await _instance();
    pref.setString('getAccessToken', accessToken);
  }

  /// Get Refresh Token
  static Future<String> getRefreshToken() async {
    final pref = await _instance();
    return pref.getString('getRefreshToken') ?? '';
  }

  static Future setRefreshToken(String accessToken) async {
    final pref = await _instance();
    pref.setString('getRefreshToken', accessToken);
  }

  // Save data
  static Future<void> setTokenInfo({
    String? accessToken,
    String? refreshToken,
  }) async {
    // Save access token
    if (accessToken != null && accessToken.isNotEmpty) {
      await Preference.setAccessToken(accessToken);
    }
    // Save refresh token
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await Preference.setRefreshToken(refreshToken);
    }
  }

  static Future clearAll() async {
    Future.wait([
      setAccessToken(''),
      setRefreshToken(''),
      removeAllPlace(),
    ]);
  }

  Preference._();
}
