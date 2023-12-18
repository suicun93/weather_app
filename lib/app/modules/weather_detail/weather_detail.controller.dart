import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../common/toast.dart';
import '../../services/my.get_controller.dart';
import '../../services/places/place.response.dart';
import '../../services/weather/weather.service.dart';
import 'forecast.response.dart';
import 'weather_detail.provider.dart';

class WeatherDetailController extends MyGetController<WeatherDetailProvider> {
  static const String placeKeyConst = 'placeKey';
  String placeKey = '';
  Place? place;

  final weatherService = Get.find<WeatherService>();

  Map<String, Place?> get mapPlace => weatherService.placeMap;

  final forecasts = RxList<Forecast>();

  @override
  void onReady() {
    super.onReady();
    placeKey = Get.parameters[placeKeyConst] ?? '';
    place = mapPlace[placeKey];
    if (placeKey.isEmpty || place == null) {
      Get.back();
      return;
    }
    print('okokok');
    getForecast();
  }

  Future<void> getForecast() async {
    final lat = place?.lat;
    final lon = place?.lon;
    if (lat == null || lon == null) {
      Get.back();
      return;
    }

    try {
      ready.value = false;
      final response = await provider.getForecast(
        lat: lat.toString(),
        lon: lon.toString(),
      );
      forecasts.value = response.body?.forecasts ?? [];
    } catch (e) {
      showSnackBar(content: LocaleKeys.somethingWentWrong.tr);
    } finally {
      ready.value = true;
    }
  }
}
