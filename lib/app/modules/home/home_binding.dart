import 'package:get/get.dart';

import 'home_controller.dart';
import 'home_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomeProvider>(
      () => HomeProvider(),
    );
  }
}
