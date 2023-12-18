import 'package:get/get.dart';

import '../../common/const.dart';
import '../../services/network/my.provider.dart';
import 'forecast.response.dart';

class WeatherDetailProvider extends MyProvider {
  Future<Response<ForecastResponse>> getForecast({
    String lat = '',
    String lon = '',
  }) {
    return get(
      '/data/2.5/forecast',
      query: {
        'lat': lat,
        'lon': lon,
        'appid': currentEnvironment.weatherApiKey,
      },
      decoder: (json) => ForecastResponse.fromJson(json),
    );
  }
}
