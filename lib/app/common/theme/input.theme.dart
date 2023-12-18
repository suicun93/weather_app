part of 'theme.dart';

const defaultBorderSide = BorderSide(width: 1, color: greyscale400);

final defaultBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: defaultBorderSide,
);

final errorBorder = defaultBorder.copyWith(
  borderSide: defaultBorderSide.copyWith(color: error),
);

final disableBorder = defaultBorder.copyWith(
  borderSide: defaultBorderSide.copyWith(color: greyscale300),
);

final focusedBorder = defaultBorder.copyWith(
  borderSide: defaultBorderSide.copyWith(color: blue400),
);

const inputStyle = body15;

InputDecorationTheme inputTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
  errorMaxLines: 3,
  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
    (Set<MaterialState> states) {
      final color = states.contains(MaterialState.error)
          ? error
          : states.contains(MaterialState.focused)
              ? blue400
              : greyscale500;
      return inputStyle.copyWith(color: color);
    },
  ),
  filled: false,
  fillColor: greyscale300,
  labelStyle: inputStyle.copyWith(color: greyscale500),
  hintStyle: inputStyle.copyWith(color: greyscale500),
  errorStyle: inputStyle.copyWith(color: error),
  iconColor: greyscale500,
  suffixIconColor: black,
  border: defaultBorder,
  enabledBorder: defaultBorder,
  disabledBorder: disableBorder,
  focusedBorder: focusedBorder,
  errorBorder: errorBorder,
  focusedErrorBorder: errorBorder,
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.only(top: 11, bottom: 13),
    backgroundColor: yellow400,
    disabledBackgroundColor: greyscale400,
    disabledForegroundColor: black,
    // Text Color
    foregroundColor: black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: body15Bold,
  ),
);

final outlineButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    padding: const EdgeInsets.only(top: 12, bottom: 14),
    side: const BorderSide(color: yellow400),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: body15Bold.copyWith(color: primary),
    foregroundColor: black,
  ),
);

final radioTheme = RadioThemeData(
  fillColor: MaterialStateProperty.all(greyscale800),
  visualDensity: const VisualDensity(
    horizontal: VisualDensity.minimumDensity,
    vertical: VisualDensity.minimumDensity,
  ),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
);
