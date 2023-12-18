import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../common/const.dart';
import '../../common/theme/theme.dart';
import 'splash.controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Container(
          color: white,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: controller.isReady
                  ? Image.asset(currentEnvironment.logo, width: 300)
                  : Image.asset(currentEnvironment.logo, width: 300),
            ),
          ),
        ),
      ),
    );
  }
}
