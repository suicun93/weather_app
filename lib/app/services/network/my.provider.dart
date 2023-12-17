import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/utils.dart';

import '../../../generated/locales.g.dart';
import '../../common/const.dart';
import '../../common/logger.dart';
import '../../common/mini_function.dart';
import '../language_currency.dart';
import '../preferences.dart';
import 'auth_info.response.dart';
import 'exceptions.dart';
import 'my.connect.dart';

class MyProvider extends MyConnect {
  /// Check Provider add authenticator or not?
  var authenticatorAdded = false;

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = endpointApi;
    httpClient.timeout = 5.seconds;
    httpClient.maxAuthRetries = 1;

    /// Add authenticate and language for each request
    httpClient.addRequestModifier<void>(
      (request) async {
        final accessToken = await Preference.getAccessToken();
        final currentLanguage =
            (await SupportedLanguages.saved).locale.languageCode;
        if (accessToken.isNotEmpty) {
          request.headers.addAll(
            {
              'authorization': 'Bearer $accessToken',
              'language': currentLanguage,
            },
          );
        }
        return request;
      },
    );

    /// Handle error from back end
    httpClient.addResponseModifier((request, response) async {
      return errorHandler(request, response);
    });
  }

  Future<Response> errorHandler(
    Request request,
    Response response,
  ) async {
    /// Log
    prettyResponse(response, listRequestInfo);

    /// Switch case
    if (response.isOk) {
      return response;
    } else {
      // Xu ly rieng
      if (response.statusCode == HttpStatus.unauthorized &&
          !response.shouldNotReauthen) {
        /// Add Authenticator
        if (!authenticatorAdded) {
          authenticatorAdded = true;

          /// Authenticate again when 401 happens
          httpClient.addAuthenticator<void>(
            (request) async {
              await _refreshToken();
              final accessToken = await Preference.getAccessToken();
              request.headers['authorization'] = 'Bearer $accessToken';
              return request;
            },
          );
        }
        return response;
      }

      // Xu ly chung
      if (response.bodyString == null) {
        throw response.statusText ?? LocaleKeys.unknown.tr;
      } else {
        try {
          final jsonBody = jsonDecode(response.bodyString!);
          if (jsonBody['errorCode'] != null) {
            throw ErrorCodeException(
              request: request,
              response: response,
              stackTrace: StackTrace.current,
            );
          } else {
            final error = getLastStringInJson(jsonBody['error']);
            if (error != null) {
              throw error;
            } else {
              throw response.statusText ?? LocaleKeys.unknown.tr;
            }
          }
        } on FormatException catch (e) {
          final statusCode = response.statusCode ?? 0;
          if (statusCode >= 500 && statusCode < 600) {
            throw 'Server error';
          } else {
            throw 'Error: ${response.statusCode} ${response.statusText ?? e.toString()}';
          }
        }
      }
    }
  }

  Future<Response<AuthInfoResponse>> getNewToken(
    String refreshToken,
  ) {
    return post(
      'auth/refresh-token',
      {
        'refreshToken': refreshToken,
      },
      decoder: (json) => AuthInfoResponse.fromJson(json),
    );
  }

  Future _refreshToken() async {
    var response = const Response<AuthInfoResponse>();
    try {
      final refreshToken = await Preference.getRefreshToken();
      if (refreshToken.isNotEmpty) {
        response = await getNewToken(refreshToken);
        if (response.body?.data?.accessToken != null &&
            response.body?.data?.refreshToken != null) {
          await Preference.setTokenInfo(
            accessToken: response.body!.data!.accessToken!,
            refreshToken: response.body!.data!.refreshToken!,
          );
        }
      } else {
        throw 'No token found';
      }
    } catch (e) {
      printError('Re-authenticate failed: $e');
      prettyResponse(response, listRequestInfo);
    }
  }
}

extension IsNotSpecial on Response {
  bool get shouldNotReauthen {
    return jsonDecode(bodyString ?? '')['errorCode'] != null ||
        jsonDecode(bodyString ?? '')['error'] ==
            'email or password are not match';
  }
}
