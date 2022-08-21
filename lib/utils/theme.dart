import 'package:flutter/material.dart';

// base theme
final baseTheme = ThemeData.light();

// base border
const outlineInputBorderBase = UnderlineInputBorder(
  borderRadius: BorderRadius.zero,
  borderSide: BorderSide.none,
);

final rareCrewTheme = ThemeData(
  scaffoldBackgroundColor: rareCrewColors.background,
  backgroundColor: rareCrewColors.black.withOpacity(.5),
  primaryColor: rareCrewColors.purple,
  appBarTheme: baseTheme.appBarTheme.copyWith(
    backgroundColor: rareCrewColors.background,
    elevation: 0,
    foregroundColor: rareCrewColors.black,
  ),
  colorScheme: baseTheme.colorScheme.copyWith(
    secondary: rareCrewColors.purple,
  ),
  dividerColor: rareCrewColors.darkGrey,
  brightness: Brightness.light,
  disabledColor: rareCrewColors.red,
  buttonTheme: baseTheme.buttonTheme.copyWith(
    height: 45,
    minWidth: double.infinity,
    buttonColor: rareCrewColors.purple,
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    disabledColor: rareCrewColors.red,
  ),
  progressIndicatorTheme: baseTheme.progressIndicatorTheme.copyWith(
    color: rareCrewColors.purple,
  ),
  checkboxTheme: baseTheme.checkboxTheme.copyWith(
    fillColor: MaterialStateProperty.all(
      rareCrewColors.purple,
    ),
    side: BorderSide(
      color: rareCrewColors.darkGrey.withOpacity(.7),
    ),
  ),
  inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    filled: true,
    fillColor: rareCrewColors.background,
    border: outlineInputBorderBase,
    enabledBorder: outlineInputBorderBase,
    focusedBorder: outlineInputBorderBase,
    labelStyle: TextStyle(
      fontSize: 14,
      color: rareCrewColors.darkGrey,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: rareCrewColors.darkGrey,
    ),
  ),
  textTheme: baseTheme.copyWith().textTheme.apply(
        fontFamily: 'OpenSans',
        bodyColor: rareCrewColors.black,
      ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: rareCrewColors.background,
      minimumSize: const Size(double.infinity, 55),
      backgroundColor: rareCrewColors.purple,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  ),
);

// app colors
const rareCrewColors = _rareCrewColors(
  yellow: Color(0xFFF3E42B),
  purple: Color(0xFF7A74F6),
  red: Color(0xFFB22A29),
  lightRed: Color(0xFFFEECEA),
  grey: Color(0xFFF2F2F2),
  darkGrey: Color(0xFFA9A8A8),
  background: Color(0xFFFEFEFF),
  disabled: Color(0xFFF2F2F2),
  black: Color(0xFF0C0C0D),
  transparent: Colors.transparent,
);

// app colors model
class _rareCrewColors {
  const _rareCrewColors({
    required this.yellow,
    required this.purple,
    required this.red,
    required this.lightRed,
    required this.grey,
    required this.darkGrey,
    required this.background,
    required this.disabled,
    required this.black,
    required this.transparent,
  });

  final Color yellow;
  final Color purple;
  final Color red;
  final Color lightRed;
  final Color grey;
  final Color darkGrey;
  final Color background;
  final Color disabled;
  final Color black;
  final Color transparent;
}
