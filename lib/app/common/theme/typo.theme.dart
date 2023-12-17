part of 'theme.dart';

const fontNameDefault = 'NotoSans';
// To test
// const fontNameDefault = 'Cascadia';

const h1 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 33,
  height: 48 / 33,
  fontWeight: FontWeight.w700,
);

const h2 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 29,
  height: 42 / 29,
  fontWeight: FontWeight.w700,
);

const h3 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 25,
  height: 36 / 25,
  fontWeight: FontWeight.w700,
);

const h4 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 23,
  height: 30 / 23,
  fontWeight: FontWeight.w700,
);

const body15 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 15,
  height: 22 / 15,
);

const body17 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 17,
  height: 24 / 17,
);

const body19 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 19,
  height: 26 / 19,
);

const body13 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 13,
  height: 18 / 13,
);

const body14 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 14,
  height: 20 / 14,
);

const subtitle1 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 18,
  height: 28 / 18,
);

const caption12 = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 12,
  height: 18 / 12,
);

const overline = TextStyle(
  fontFamily: fontNameDefault,
  color: black,
  fontSize: 10,
  height: 14 / 10,
);

final body15Bold = body15.copyWith(fontWeight: FontWeight.w600);

final body17Bold = body17.copyWith(fontWeight: FontWeight.w600);

final body19Bold = body19.copyWith(fontWeight: FontWeight.w600);

final body17WhiteBoldTitle = body17.copyWith(
  fontWeight: FontWeight.w600,
  color: white,
);

const textTheme = TextTheme(
  displayLarge: h1,
  displayMedium: h2,
  displaySmall: h3,
  headlineMedium: h4,
  bodyLarge: body17,

  /// Default text style for Text
  bodyMedium: body15,

  /// Default text style for TextFormField
  titleMedium: body15,
  bodySmall: caption12,
  labelSmall: overline,
);
