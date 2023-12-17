import '../language_currency.dart';

dynamic translate(dynamic json) {
  if (json is Map) {
    json = findLanguagesAndTranslate(json);
    for (var value in json.values) {
      value = translate(value);
    }
  } else if (json is Iterable) {
    for (var value in json) {
      value = translate(value);
    }
  }
  return json;
}

dynamic findLanguagesAndTranslate(dynamic json) {
  final langCode = SupportedLanguages.currentLang;
  var language = json['languages'];
  if (language is Map<String, dynamic> &&
      language[langCode] is Map<String, dynamic>) {
    translateMap(language[langCode], json);
  }
  return json;
}

void translateMap(Map<String, dynamic> json, dynamic jsonOrigin) {
  try {
    json.forEach(
      (key, value) {
        if (value is String) {
          if (jsonOrigin != null) {
            jsonOrigin[key] = value;
          }
        } else if (value is Map<String, dynamic>) {
          if (jsonOrigin[key] == null) {
            jsonOrigin[key] = <String, dynamic>{};
          }
          translateMap(value, jsonOrigin[key]);
        }
      },
    );
  } catch (e) {
    print(e.toString());
  }
}
