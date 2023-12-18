import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../services/my.get_controller.dart';
import 'splash.provider.dart';

class SplashController extends MyGetController<SplashProvider> {
  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(2.seconds);
    Get.offAndToNamed(Routes.home);
  }
}
