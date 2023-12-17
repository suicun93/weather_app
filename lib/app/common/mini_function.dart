import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../generated/locales.g.dart';
import 'const.dart';
import 'toast.dart';

Future copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
  showSnackBar(
    content: 'Copied $text',
    isError: false,
  );
}

void notImplementedYet() {
  showSnackBar(
    content: 'Not Implemented Yet.',
    // isError: false,
  );
}

String? getLastStringInJson(dynamic json) {
  if (json is String) {
    return json;
  } else if (json is Map) {
    return getLastStringInJson(json.values.last);
  } else if (json is Iterable) {
    return getLastStringInJson(json.last);
  } else {
    return null;
  }
}

extension ValidPhone on String {
  String get validatePhone {
    if (startsWith('0')) {
      return replaceFirst('0', '+84');
    } else if (startsWith('84')) {
      return '+$this';
    } else if (startsWith('+')) {
      return this;
    } else {
      return '+84$this';
    }
  }

  String get formatPhone {
    final phone = replaceAll('+84', '');
    return '(${phone.substring(0, 4)}) ${phone.substring(4, 6)} -${phone.substring(6, phone.length)}';
  }
}

extension ValidCccd on String {
  bool get isCccd {
    final removedSpace = removeAllWhitespace;
    if (![9, 12].contains(removedSpace.length)) return false;
    if (removedSpace.length == 12 && !['0', '1'].contains(removedSpace[3])) return false;
    return true;
  }
}

extension DateFormatter on DateTime? {
  String get toStrDateTimeAPI {
    return this == null ? '' : dateWithTimeFormatter.format(this!);
  }

  String get toStrTimeToShow {
    return this == null ? '' : dateWithTimeFormatterToShow.format(this!);
  }

  String get toStrDate {
    return this == null ? '' : dateFormatter.format(this!);
  }
}

Future launchMaps(double lat, double lon, {label = ''}) async {
  String googleUrl = Platform.isIOS
      ? 'comgooglemaps://?saddr$lat,$lon=&daddr=$lat,$lon&directionsmode=driving'
      : 'geo:$lat,$lon?q=$lat,$lon($label)';
  String startGoogleUrl = Platform.isIOS ? 'comgooglemaps://' : 'geo:';
  String appleUrl = 'https://maps.apple.com/?sll=$lat,$lon';
  String webUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  if (await canLaunchUrlString(startGoogleUrl)) {
    print('launching com googleUrl');
    await launchUrlString(googleUrl);
  } else if (Platform.isIOS && await canLaunchUrlString(appleUrl)) {
    print('launching apple url');
    await launchUrlString(appleUrl);
  } else if (await canLaunchUrlString(webUrl)) {
    print('launching web url');
    await launchUrlString(webUrl);
  } else {
    print('Can not open anything');
    showSnackBar(content: LocaleKeys.somethingWentWrong.tr);
  }
}

Future openLink(String link) async{
  if (await canLaunchUrlString(link)) {
    print('launching com googleUrl');
    await launchUrlString(link);
  }
}