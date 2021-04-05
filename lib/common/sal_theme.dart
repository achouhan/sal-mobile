import 'package:flutter/material.dart';
import 'sal_colors.dart';

class SALTheme {
  static ThemeData get appTheme {
    return ThemeData(
        fontFamily: 'OpenSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: SalColors.blue,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                backgroundColor: SalColors.midNightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: SalColors.grey)))),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: SalColors.grey))));
  }
}
