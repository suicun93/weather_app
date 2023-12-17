import 'package:get/get.dart';

import 'weather_detail.controller.dart';
import 'weather_detail.provider.dart';

class WeatherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherDetailController>(
      () => WeatherDetailController(),
    );
    Get.lazyPut<WeatherDetailProvider>(
      () => WeatherDetailProvider(),
    );
  }
}
