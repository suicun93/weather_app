import 'dart:math';

import 'package:get/get.dart';

final RegExp customPasswordRegex = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^])[A-Za-z\d@$!%*?&#^]{8,}$',
  caseSensitive: true,
  multiLine: false,
);

/// Check password invalid
/// 6 chars at least
/// contains alphabet and number
extension CheckPassword on String {
  bool get isPassword => customPasswordRegex.hasMatch(this);
}

/// Remove first zero in phone number if existed
extension RemoveZero on String {
  String get removeFirstZero => startsWith('0') ? substring(1) : this;
}

/// Init random string
extension RandomString on String {
  static String get init {
    var r = Random();
    return String.fromCharCodes(
      List.generate(5, (index) => r.nextInt(33) + 89),
    );
  }
}

/// Check isTablet or not
bool get isTablet => sqrt((Get.size.width * Get.size.width) + (Get.size.height * Get.size.height),) > 1100;
