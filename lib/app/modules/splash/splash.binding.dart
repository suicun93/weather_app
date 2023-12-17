import 'package:get/get.dart';

import 'splash.controller.dart';
import 'splash.provider.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<SplashProvider>(
      () => SplashProvider(),
    );
  }
}
