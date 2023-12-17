import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/splash/splash.binding.dart';
import '../modules/splash/splash.view.dart';
import '../modules/weather_detail/weather_detail.binding.dart';
import '../modules/weather_detail/weather_detail.view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WEATHER_DETAIL,
      page: () => const WeatherDetailView(),
      binding: WeatherDetailBinding(),
    ),
  ];
}
