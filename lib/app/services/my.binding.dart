import 'package:get/get.dart';

import 'places/places.provider.dart';
import 'weather/weather.provider.dart';
import 'weather/weather.service.dart';


/// Binding Services
class MyServicesBinding extends Bindings {
  @override
  void dependencies() {
    // Search Place by suggestion/location
    Get.lazyPut(() => PlacesProvider());

    // Fetch Weather by place
    Get.lazyPut(() => WeatherProvider());
    Get.lazyPut(() => WeatherService());
  }
}
