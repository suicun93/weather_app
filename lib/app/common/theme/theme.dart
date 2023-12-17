import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'colors.theme.dart';

part 'input.theme.dart';

part 'typo.theme.dart';

final theme = ThemeData(
  fontFamily: fontNameDefault,
  textTheme: textTheme,
  // define text style for text field
  textSelectionTheme: const TextSelectionThemeData(cursorColor: blue400),
  splashColor: primary,
  primaryColor: primary,
  inputDecorationTheme: inputTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlineButtonTheme,
  radioTheme: radioTheme,
  scaffoldBackgroundColor: white,
  expansionTileTheme: const ExpansionTileThemeData(
    textColor: primary,
    iconColor: primary,
    expandedAlignment: Alignment.topLeft,
    tilePadding: EdgeInsets.fromLTRB(
      16,
      16,
      16,
      8,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: black,
    titleTextStyle: body17WhiteBoldTitle,
    elevation: 0,
    centerTitle: false,
    systemOverlayStyle: blackSystemUI,
    titleSpacing: 0,
    iconTheme: const IconThemeData(color: white),
  ),
  drawerTheme: const DrawerThemeData(scrimColor: transparent, elevation: 0),
  dividerColor: greyscale200,
);

const mainSystemUiOverlay = SystemUiOverlayStyle(
  /// The color of the system bottom navigation bar.
  /// Only honored in Android versions O and greater.
  systemNavigationBarColor: primary,

  /// The color of the divider between the system's bottom navigation bar and the app's content.
  /// Only honored in Android versions P and greater.
  systemNavigationBarDividerColor: primary,

  /// The brightness of the system navigation bar icons.
  /// Only honored in Android versions O and greater.
  /// When set to [Brightness.light], the system navigation bar icons are light.
  /// When set to [Brightness.dark], the system navigation bar icons are dark.
  systemNavigationBarIconBrightness: Brightness.dark,

  /// The color of top status bar.
  /// Only honored in Android version M and greater.
  statusBarColor: primary,

  /// The brightness of top status bar.
  /// Only honored in iOS.
  statusBarBrightness: Brightness.light,

  /// The brightness of the top status bar icons.
  /// Only honored in Android version M and greater.
  statusBarIconBrightness: Brightness.dark,
);

const whiteSystemUI = SystemUiOverlayStyle(
  systemNavigationBarColor: white,
  systemNavigationBarDividerColor: white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: white,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
);

const blackSystemUI = SystemUiOverlayStyle(
  systemNavigationBarColor: white,
  systemNavigationBarDividerColor: white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: black,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
);
