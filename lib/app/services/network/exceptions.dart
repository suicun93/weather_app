import 'dart:convert';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../generated/locales.g.dart';
import '../../common/mini_function.dart';

class ErrorCodeException {
  Request? request;
  Response? response;
  StackTrace? stackTrace;

  @override
  String toString() => error;

  /// Get error code
  String get errorCode =>
      jsonDecode(response?.bodyString ?? '{}')['errorCode'] ?? '';

  /// is AUTH002 or not
  bool get isAUTH002 => errorCode == 'AUTH002';

  bool get isBOOKING => errorCode.startsWith('BOOKING');

  // BookingStatus get bookingStatusShouldBe {
  //   switch (errorCode) {
  //     case 'BOOKING001':
  //       return BookingStatus.confirmed;
  //     case 'BOOKING002':
  //       return BookingStatus.rejected;
  //     case 'BOOKING003':
  //       return BookingStatus.cancelled;
  //     case 'BOOKING004':
  //       return BookingStatus.completed;
  //     case 'BOOKING005':
  //       return BookingStatus.pending;
  //     default:
  //       return BookingStatus.unknown;
  //   }
  // }

  /// is ENTITY_EXIST or not
  bool get isEntityExist => errorCode == 'ENTITY_EXIST';

  /// get error message
  String get error {
    /// Check common error
    if (commonError.contains(errorCode)) {
      return ('common_error_$errorCode').tr;
    }

    /// Handle other cases
    final jsonBody = jsonDecode(response?.bodyString ?? '');
    final error = getLastStringInJson(jsonBody['error']);
    if (error != null) {
      return error;
    } else {
      return response?.statusText ?? LocaleKeys.unknown.tr;
    }
  }

  ErrorCodeException({
    this.request,
    this.response,
    this.stackTrace,
  });
}

final commonError = [
  'BOOKING001',
  'BOOKING002',
  'BOOKING003',
  'BOOKING004',
  'BOOKING005',
  'BOOKING006',
  'BOOKING007',
  'BOOKING008',
  'BOOKING009',
  'USER001',
  'USER002',
];