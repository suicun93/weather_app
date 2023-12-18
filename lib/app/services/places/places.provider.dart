import 'package:get/get.dart';

import '../../common/const.dart';
import '../network/my.provider.dart';
import 'place.response.dart';

class PlacesProvider extends MyProvider {
  Future<Response<Iterable<Place>>> getPlacesFromSuggestion({
    String suggest = '',
    int limit = 5,
  }) {
    return get(
      '/geo/1.0/direct',
      query: {
        'q': suggest,
        'limit': limit.toString(),
        'appid': currentEnvironment.weatherApiKey,
      },
      decoder: (json) {
        if (json is Iterable) {
          return json.map((e) => Place.fromJson(e));
        } else {
          return const Iterable.empty();
        }
      },
    );
  }

  Future<Response<Iterable<Place>>> getPlacesFromLatLon({
    String lat = '',
    String lon = '',
    int limit = 5,
  }) {
    return get(
      '/geo/1.0/reverse',
      query: {
        'lat': lat,
        'lon': lon,
        'limit': limit.toString(),
        'appid': currentEnvironment.weatherApiKey,
      },
      decoder: (json) {
        if (json is Iterable) {
          return json.map((e) => Place.fromJson(e));
        } else {
          return const Iterable.empty();
        }
      },
    );
  }
}
