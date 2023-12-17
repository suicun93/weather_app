part of 'const.dart';

const iphoneXBottomHeight = 21;

double bottomByPlatform(double height) {
  return Platform.isIOS
      ? ((Get.height * 10) ~/ Get.width) == 17 // => iphone 7 sửa ở đây
          ? height - 2
          : Get.mediaQuery.viewPadding.bottom + height - iphoneXBottomHeight
      : height;
}

Widget get backIcon {
  return InkWell(
    onTap: () => Get.back(),
    overlayColor: MaterialStateColor.resolveWith(
      (states) => transparent,
    ),
    child: const Icon(
      Icons.arrow_back_ios_rounded,
      size: 18,
      color: white,
    ),
  );
}

Widget get backBlackIcon {
  return InkWell(
    onTap: () => Get.back(),
    overlayColor: MaterialStateColor.resolveWith(
      (states) => transparent,
    ),
    child: const Icon(
      Icons.arrow_back_ios_rounded,
      size: 18,
      color: black,
    ),
  );
}

Container loadingWidget({double opacity = 0.1}) => Container(
      color: const Color(0xff111111).withOpacity(opacity),
      child: Center(
        child: Container(
          width: 246,
          height: 246,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/loading.gif'),
              const SizedBox(height: 8),
              Text(LocaleKeys.pleaseWait.tr),
            ],
          ),
        ),
      ),
    );

Widget get dividerThin => const Divider(height: 1, color: grey);

Widget get dividerNeutral => const Divider(thickness: 12, color: greyscale600);

Widget padding16({required Widget child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
    ),
    child: child,
  );
}

Container chip(String s) {
  return Container(
    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      border: Border.all(color: green600),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(s, style: body15.copyWith(color: green600)),
  );
}

Widget get line => Container(
      height: 1,
      color: primary.withOpacity(0.05),
    );

// Future<ImageSource?> showBottomSheetToSelectImageSource() {
//   return Get.bottomSheet<ImageSource>(
//     Container(
//       padding: EdgeInsets.fromLTRB(0, 24, 0, bottomByPlatform(24)),
//       decoration: const BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 24),
//             child: Text(LocaleKeys.selectImage.tr, style: h4),
//           ),
//           Column(
//             children: [
//               InkWell(
//                 overlayColor: MaterialStateColor.resolveWith(
//                   (states) => transparent,
//                 ),
//                 onTap: () async {
//                   Get.back(result: ImageSource.camera);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//                   child: Text(
//                     LocaleKeys.camera.tr,
//                     style: subtitle1,
//                   ),
//                 ),
//               ),
//               dividerThin,
//             ],
//           ),
//           Column(
//             children: [
//               InkWell(
//                 overlayColor: MaterialStateColor.resolveWith(
//                   (states) => transparent,
//                 ),
//                 onTap: () async {
//                   Get.back(result: ImageSource.gallery);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//                   child: Text(
//                     LocaleKeys.gallery.tr,
//                     style: subtitle1,
//                   ),
//                 ),
//               ),
//               dividerThin,
//             ],
//           ),
//           InkWell(
//             onTap: () => Get.back(),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//               child: Text(
//                 LocaleKeys.cancel.tr,
//                 style: subtitle1.copyWith(color: red400),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Future<OpenFileDialogType?> showBottomSheetToSelectFileType() {
//   return Get.bottomSheet<OpenFileDialogType>(
//     Container(
//       padding: EdgeInsets.fromLTRB(0, 24, 0, bottomByPlatform(24)),
//       decoration: const BoxDecoration(
//         color: white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 24),
//             child: Text(LocaleKeys.select.tr, style: h4),
//           ),
//           Column(
//             children: [
//               InkWell(
//                 overlayColor: MaterialStateColor.resolveWith(
//                   (states) => transparent,
//                 ),
//                 onTap: () async {
//                   Get.back(result: OpenFileDialogType.image);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//                   child: Text(
//                     LocaleKeys.image.tr,
//                     style: subtitle1,
//                   ),
//                 ),
//               ),
//               dividerThin,
//             ],
//           ),
//           Column(
//             children: [
//               InkWell(
//                 overlayColor: MaterialStateColor.resolveWith(
//                   (states) => transparent,
//                 ),
//                 onTap: () async {
//                   Get.back(result: OpenFileDialogType.document);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//                   child: Text(
//                     LocaleKeys.file.tr,
//                     style: subtitle1,
//                   ),
//                 ),
//               ),
//               dividerThin,
//             ],
//           ),
//           InkWell(
//             onTap: () => Get.back(),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(24, 12, 0, 12),
//               child: Text(
//                 LocaleKeys.cancel.tr,
//                 style: subtitle1.copyWith(color: red400),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

void showConfirmDialogWithTitle({
  String? positiveText,
  String? negativeText,
  Future Function()? positiveAction,
  Future Function()? negativeAction,
  required String title,
  required String content,
  bool barrierDismissible = true,
}) {
  Get.dialog(
    AlertDialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      content: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: body17Bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: body15,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text(negativeText ?? LocaleKeys.no.tr),
                    onPressed: () {
                      Get.back();
                      negativeAction?.call();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text(positiveText ?? LocaleKeys.yes.tr),
                    onPressed: () {
                      Get.back();
                      positiveAction?.call();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierColor: black.withOpacity(0.1),
    barrierDismissible: barrierDismissible,
  );
}

void showConfirmDialogWithInput({
  required Function() yesAction,
  required Function() noAction,
  required String title,
  required Widget input,
}) {
  Get.dialog(
    AlertDialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
      content: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: h4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            input,
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text(LocaleKeys.no.tr),
                    onPressed: () {
                      Get.back();
                      noAction();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text(LocaleKeys.yes.tr),
                    onPressed: () {
                      Get.back();
                      yesAction();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierColor: black.withOpacity(0.1),
  );
}

Future showConfirmDialogWithImage({
  required String image,
  required String title,
  required String confirmText,
  required Function() onConfirm,
  Function()? onSkip,
}) async {
  await Get.dialog(
    AlertDialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      content: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Image.asset(image, height: 100),
            Text(
              title,
              style: body14.copyWith(color: yellow300),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(confirmText),
                onPressed: () {
                  Get.back();
                  onConfirm();
                },
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                Get.back();
                onSkip?.call();
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: Center(
                  child: Text(
                    LocaleKeys.skip.tr,
                    style: body15.copyWith(
                      fontWeight: FontWeight.w600,
                      color: yellow300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

Future showConfirmDialog(
  String question, {
  String? positiveText,
  String? negativeText,
  Future Function()? positiveAction,
  Future Function()? negativeAction,
}) async {
  await Get.dialog(
    AlertDialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      content: Container(
        width: Get.width - 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question,
              style: body17,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text(negativeText ?? LocaleKeys.no.tr),
                    onPressed: () {
                      Navigator.pop(Get.context!);
                      negativeAction?.call();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text(positiveText ?? LocaleKeys.yes.tr),
                    onPressed: () {
                      Navigator.pop(Get.context!);
                      positiveAction?.call();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierColor: black.withOpacity(0.1),
  );
}

Widget get loadingMore {
  return Container(
    padding: const EdgeInsets.all(64),
    decoration: BoxDecoration(
      color: greyscale000,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    ),
  );
}