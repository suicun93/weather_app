import 'package:get/get_connect/http/src/response/response.dart';

import '../../common/const.dart';
import '../network/my.provider.dart';
import 'weather.response.dart';

class WeatherProvider extends MyProvider {
  Future<Response<Weather>> getWeather({
    String lat = '',
    String lon = '',
  }) {
    return get(
      '/data/2.5/weather',
      query: {
        'lat': lat,
        'lon': lon,
        'appid': currentEnvironment.weatherApiKey,
      },
      decoder: (json) => Weather.fromJson(json),
    );
  }
}
