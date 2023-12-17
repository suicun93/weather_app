import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:get/get.dart';

import 'const.dart';
import '../services/network/my.connect.dart';

var encoder = JsonEncoder.withIndent(' ' * 4);

void prettyResponse(
  Response response,
  final Map<String, RequestInfo> listRequestInfo,
) async {
  /// Only use for [Dev]
  if (currentEnvironment == Environment.prod) return;

  /// Print
  print('\n\n\n');

  /// Handle logger
  final Function(String) logger;
  if (response.isOk) {
    logger = printSuccess;
  } else {
    logger = printError;
  }

  /// Handle Request Info
  printLine('[REQUEST] ===============================================');
  printInfo('[URL] ${response.request?.url ?? emptyString}');
  printInfo(
    '[METHOD] ${response.request?.method ?? emptyString}',
  );
  try {
    printInfo('[HEADER]');
    printInfo(
      response.request?.headers == null
          ? emptyString
          : encoder.convert(
              response.request?.headers,
            ),
    );
  } catch (e) {
    printError(e.toString());
    printError('=========================================================');
  }

  // Get key
  final key = response.request?.headers[keyFromMobile] ?? '';
  // Show info
  if (key.isNotEmpty) {
    final requestInfo = listRequestInfo[key];
    try {
      printInfo('[QUERY]');
      printInfo(
        requestInfo?.query == null
            ? emptyString
            : encoder.convert(requestInfo?.query),
      );

      printInfo('[REQUEST BODY]');
      final request = requestInfo?.requestBody;
      printInfo(
        request != null
            ? request is Map
                ? encoder.convert(request)
                : request is FormData
                    ? 'FormData thì chịu khó debug vào nha, chưa tìm được cách print...'
                    : 'Unprintable'
            : emptyString,
      );
    } catch (e) {
      printError(e.toString());
      printError('=========================================================');
    }
  } else {
    printInfo(emptyString);
  }

  /// Print Response
  printLine('[RESPONSE] ===============================================');
  logger('[STATUS CODE] ${response.statusCode?.toString() ?? '(Unknown)'}');
  try {
    logger('[RESULT]');
    if (!response.isOk) {
      logger(encoder.convert(jsonDecode(response.bodyString ?? '')));
    } else {
      if (response.bodyString?.isEmpty ?? true) {
        logger(emptyString);
      } else {
        developer.log(
          encoder.convert(jsonDecode(response.bodyString ?? '{}')),
          name: 'RESULT',
        );
      }
    }
  } catch (e) {
    printError(e.toString());
    printError(response.bodyString ?? '');
    printError('=========================================================');
  }
}

void printInfo(String text) {
  printByPlatform(text, ColorLog.blue);
}

void printSuccess(String text) {
  printByPlatform(text, ColorLog.green);
}

void printError(String text) {
  printByPlatform(text, ColorLog.red);
}

void printLine(String text) {
  printByPlatform(text, ColorLog.yellow);
}

void printByPlatform(String text, String color) {
  if (Platform.isIOS) {
    print(text);
  } else {
    print('$color$text${ColorLog.reset}');
  }
}

/// Color
class ColorLog {
  static const black = '\x1B[30m';
  static const red = '\x1B[31m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const blue = '\x1B[34m';
  static const magenta = '\x1B[35m';
  static const cyan = '\x1B[36m';
  static const white = '\x1B[37m';
  static const reset = '\x1B[0m';
}

const keyFromMobile = 'em_make_flag_o_mobile_anh_oai_dung_quan_tam_nha';
const emptyString = '(empty)';
