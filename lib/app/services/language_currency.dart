import 'dart:ui';

import 'package:get/get.dart';
import 'preferences.dart';

/// We support 2 languages for now, English and Vietnamese
enum SupportedLanguages {
  english(
    locale: Locale('en', 'US'),
    name: 'English',
  ),
  // french(
  //   locale: Locale('fr', 'FR'),
  //   name: 'Français',
  // ),
  vietnamese(
    locale: Locale('vi', 'VN'),
    name: 'Tiếng Việt',
  );

  const SupportedLanguages({
    required this.locale,
    required this.name,
  });

  final Locale locale;
  final String name;

  // final String moneyType;

  /// Quick Current SupportedLanguages
  // Init = default, I will change it whenever we save a new record or get saved record from memory
  static SupportedLanguages currentSupportedLanguages =
      defaultSupportedLanguages;

  /// Quick Current language
  static String currentLang = currentSupportedLanguages.locale.languageCode;

  /// Default
  static SupportedLanguages get defaultSupportedLanguages => SupportedLanguages.english;

  /// Get from preference
  static Future<SupportedLanguages> get saved async {
    final savedLang = await Preference.getLanguage();
    final savedLanguageAndCurrency = SupportedLanguages.getByName(name: savedLang) ?? SupportedLanguages.getByLocale(locale: Get.deviceLocale) ?? defaultSupportedLanguages;
    currentSupportedLanguages = savedLanguageAndCurrency;
    return savedLanguageAndCurrency;
  }

  /// Save
  static Future save(SupportedLanguages languageCurrency) async {
    await Get.updateLocale(languageCurrency.locale);
    await Preference.setLanguage(languageCurrency.name);
    currentSupportedLanguages = languageCurrency;
  }

  /// Support Functions
  /// Get by name
  static SupportedLanguages? getByName({String? name = ''}) {
    return SupportedLanguages.values.firstWhereOrNull(
      (languageCurrency) => languageCurrency.name == name,
    );
  }

  /// Get by Locale
  static SupportedLanguages? getByLocale({Locale? locale}) {
    return SupportedLanguages.values.firstWhereOrNull(
      (languageCurrency) => languageCurrency.locale == locale,
    );
  }

  /// Supported Locales
  static Iterable<Locale> get supportedLocales {
    return SupportedLanguages.values.map((e) => e.locale);
  }
}
