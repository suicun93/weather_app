import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme/theme.dart';

void showSnackBar2({
  required String content,
  bool isError = true,
  Color colorBackground = blue400,
}) {
  final controller = SnackbarController(
    GetSnackBar(
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: !isError
                ? const Icon(
                    Icons.check_circle,
                    color: green800,
                  )
                : const Icon(
                    Icons.warning,
                    color: red500,
                  ),
          ),
          Expanded(
            child: Text(
              content.capitalizeFirst!,
              style: body15.copyWith(
                fontWeight: FontWeight.w400,
                color: !isError ? green900 : red900,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      dismissDirection: DismissDirection.horizontal,
      isDismissible: true,
      overlayBlur: 0,
      backgroundColor: isError ? red000 : colorBackground,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: 2.seconds,
      padding: const EdgeInsets.all(16),
      borderRadius: 8,
      borderWidth: 1,
      borderColor: !isError ? green700 : red500,
      forwardAnimationCurve: Curves.easeOutQuart,
      reverseAnimationCurve: Curves.easeOutCirc,
    ),
  );
  controller.show();
}

void showSnackBar({
  required String content,
  bool isError = true,
}) {
  Get.snackbar(
    '',
    content,
    titleText: const SizedBox(),
    backgroundColor: isError ? error: blue400,
    colorText: white,
  );
}
