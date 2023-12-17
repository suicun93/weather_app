import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/const.dart';

class Preference {
  static Future<SharedPreferences> _instance() async {
    return SharedPreferences.getInstance();
  }

  /// Get language
  static Future<String?> getLanguage() async {
    final pref = await _instance();
    return pref.getString('language');
  }

  static Future setLanguage(String language) async {
    final pref = await _instance();
    pref.setString('language', language);
  }

  /// Get Notification or not?
  static Future<bool> isNoti() async {
    final pref = await _instance();
    return pref.getBool('noti') ?? false;
  }

  static Future setNoti(bool logged) async {
    final pref = await _instance();
    pref.setBool('noti', logged);
  }

  /// Get shouldAskNotification or not?
  static Future<DateTime> getLastTimeAskNotification() async {
    final pref = await _instance();
    final shouldAsk = pref.getString('getLastTimeAskNotification');
    return (shouldAsk?.isEmpty ?? true)
        ? DateTime.now().subtract(8.days)
        : dateFormatter.parse(shouldAsk!);
  }

  static Future setLastTimeAskNotification(
    DateTime? shouldAskNotification,
  ) async {
    final pref = await _instance();
    pref.setString(
      'getLastTimeAskNotification',
      shouldAskNotification == null
          ? ''
          : dateFormatter.format(shouldAskNotification),
    );
  }

  /// Get Access Token
  static Future<String> getAccessToken() async {
    final pref = await _instance();
    return pref.getString('getAccessToken') ?? '';
  }

  static Future setAccessToken(String accessToken) async {
    final pref = await _instance();
    pref.setString('getAccessToken', accessToken);
  }

  /// Get Refresh Token
  static Future<String> getRefreshToken() async {
    final pref = await _instance();
    return pref.getString('getRefreshToken') ?? '';
  }

  static Future setRefreshToken(String accessToken) async {
    final pref = await _instance();
    pref.setString('getRefreshToken', accessToken);
  }

  // Save data
  static Future<void> setTokenInfo({
    String? accessToken,
    String? refreshToken,
  }) async {
    // Save access token
    if (accessToken != null && accessToken.isNotEmpty) {
      await Preference.setAccessToken(accessToken);
    }
    // Save refresh token
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await Preference.setRefreshToken(refreshToken);
    }
  }

  static Future clearAll() async {
    Future.wait([
      setAccessToken(''),
      setRefreshToken(''),
      setNoti(false),
      setLastTimeAskNotification(null),
    ]);
  }

  Preference._();
}
