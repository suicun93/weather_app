import 'package:get/get.dart';
import 'network/my.provider.dart';

class MyGetController<T extends MyProvider> extends FullLifeCycleController {
  T provider = Get.find<T>();

  /// Ready variable for any screen
  final ready = true.obs;

  /// Getter setter
  bool get isReady => ready.value;

  set isReady(bool _) {
    ready.value = _;
  }
}
