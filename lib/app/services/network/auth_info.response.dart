class AuthInfoResponse {
  AuthInfoResponse({
    this.statusCode,
    this.message,
    this.errorCode,
    this.data,
  });

  final int? statusCode;
  final String? message;
  final String? errorCode;
  final Data? data;

  factory AuthInfoResponse.fromJson(Map<String, dynamic> json) => AuthInfoResponse(
        statusCode: json['statusCode'],
        message: json['message'],
        errorCode: json['errorCode'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'message': message,
        'errorCode': errorCode,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.accessToken,
    this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
