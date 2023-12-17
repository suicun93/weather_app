import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/common/const.dart';
import 'app/common/theme/theme.dart';
import 'app/routes/app_pages.dart';
import 'app/services/language_currency.dart';
import 'app/services/my.binding.dart';
import 'generated/locales.g.dart';


/// Run app
Future main() async {
  run();
}

void run() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Select endpoint
  packageInfo = await PackageInfo.fromPlatform();
  switch (packageInfo?.packageName) {
    case 'com.dukehoang.weather.dev':
      currentEnvironment = Environment.dev;
      break;
    case 'com.dukehoang.weather':
      currentEnvironment = Environment.prod;
      break;
    default:
      return;
  }

  /// Init Keys
  // KakaoSdk.init(nativeAppKey: currentEnvironment.kakaoNativeAppKey);
  // PassbaseSDK.initialize(publishableApiKey: passbaseAppKey);
  // Stripe.publishableKey = currentEnvironment.stripePublishableKey;
  // await Stripe.instance.applySettings();

  /// Get Language
  final locale = (await SupportedLanguages.saved).locale;

  /// Run app
  runApp(
    GetMaterialApp(
      onReady: () {
        /// Setup environment
        SystemChrome.setSystemUIOverlayStyle(mainSystemUiOverlay);

        /// Lock screen portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
      title: packageInfo?.appName ?? '',
      color: primary,
      initialBinding: MyServicesBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: theme,

      /// Multilingual - i18n
      supportedLocales: SupportedLanguages.supportedLocales,
      translationsKeys: AppTranslation.translations,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Default = deviceLocale
      locale: locale,
      // If failed => VN
      fallbackLocale: SupportedLanguages.defaultSupportedLanguages.locale,
    ),
  );
}