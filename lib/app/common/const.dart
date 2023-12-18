import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../generated/locales.g.dart';
import '../services/language_currency.dart';
import 'theme/theme.dart';

part 'mini_widget.dart';

/// Base URL
var currentEnvironment = Environment.dev;

String get endpointApi => currentEnvironment.endPoint;

/// Environment
enum Environment {
  prod(
    baseUrl: 'http://api.openweathermap.org',
    logo: 'assets/logo_prod.png',
    weatherApiKey: weatherKey,
  ),
  dev(
    baseUrl: 'http://api.openweathermap.org',
    logo: 'assets/logo_dev.png',
    weatherApiKey: weatherKey,
  );

  final String baseUrl;
  final String logo;
  final String weatherApiKey;

  String get endPoint => baseUrl;

  const Environment({
    required this.baseUrl,
    required this.logo,
    required this.weatherApiKey,
  });
}

// Format money
final numberFormatter = NumberFormat('#,###');

String formatPrice(double? price) => price == null
    ? '0'
    : NumberFormat.decimalPattern().format(price).toString();

// Format date with time
final dateWithTimeFormatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
final dateWithTimeFormatterToShow = DateFormat('HH:mm - dd/MM/yy');

// Format date
final dateFormatter = DateFormat('dd/MM/yyyy');

// Format month
final monthFormatter = DateFormat('MMMM');

// Format time
final timeFormatter = DateFormat('HH:mm:ss');

// Format day,month,time
final bookingFormatter = DateFormat(
  'E d MMM HH:mm',
  SupportedLanguages.currentLang,
);
final bookingTitleFormatter = DateFormat('MMMM yyyy');

PackageInfo? packageInfo;

// Test klip and kakaotalk, fake data
const _demo = true;

bool get isDemo => currentEnvironment == Environment.dev && _demo;

// Save notification data to handle
dynamic notificationData;

const rootImage = 'assets/images/';

/// DOB margins
final maxTimeDOB = DateTime.now();
final defaultDOB = DateTime(1990, 1, 1);
final minTimeDOB = DateTime(1930, 1, 1);

/// Paging limitation
const pageSize = 15;

/// Map APi Key
const weatherKey = 'bfa3eeb517cd0a09da23785037e800ca';

// String mapLinkHybrid(lat, lon) {
//   return 'https://maps.googleapis.com/maps/api/staticmap?zoom=19&size=1024x768&sensor=false&maptype=hybrid&markers=color:red|label:P|$lat,$lon&key=${currentEnvironment.mapApiKey}';
// }
//
// String mapLinkNoHybrid(lat, lon) {
//   return 'https://maps.googleapis.com/maps/api/staticmap?zoom=19&size=1024x768&sensor=false&markers=color:red|label:P|$lat,$lon&key=${currentEnvironment.mapApiKey}';
// }
