import 'package:get/get.dart';
import 'translator.dart';
import '../../common/logger.dart';
import '../../common/utils.dart';

class MyConnect extends GetConnect {
  /// Save Request Info to log
  final Map<String, RequestInfo> listRequestInfo = {};

  /// From Duc: Override all of them just for logging request/ response,
  /// we did not need to translate right now, you guys can skip '[translate]' function
  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    final key = RandomString.init;
    headers = {};
    headers[keyFromMobile] = key;
    listRequestInfo[key] = RequestInfo(
      requestBody: body,
      query: query,
    );
    return super.post<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder != null ? (json) => decoder(translate(json)) : decoder,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    final key = RandomString.init;
    headers = {};
    headers[keyFromMobile] = key;
    listRequestInfo[key] = RequestInfo(
      query: query,
    );
    return super.get<T>(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder != null ? (json) => decoder(translate(json)) : decoder,
    );
  }

  @override
  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    final key = RandomString.init;
    headers = {};
    headers[keyFromMobile] = key;
    listRequestInfo[key] = RequestInfo(
      requestBody: body,
      query: query,
    );
    return super.request<T>(
      url,
      method,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder != null ? (json) => decoder(translate(json)) : decoder,
      uploadProgress: uploadProgress,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    final key = RandomString.init;
    headers = {};
    headers[keyFromMobile] = key;
    listRequestInfo[key] = RequestInfo(
      requestBody: body,
      query: query,
    );
    return super.put<T>(
      url,
      body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder != null ? (json) => decoder(translate(json)) : decoder,
      uploadProgress: uploadProgress,
    );
  }
}

class RequestInfo {
  Map<String, dynamic>? query;
  dynamic requestBody;

  RequestInfo({
    this.query,
    this.requestBody,
  });
}
