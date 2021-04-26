import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalColors {
  static Color blue = Color(0xFF0066B3);
  static Color midNightBlue = Color(0xFF001736);
  static Color darkBlue = Color(0xFF0E2E5A);
  static Color skyBlue = Color(0xFFE4F0F8);
  static Color black = Color(0xFF1F2023);
  static Color grey = Color(0xFF77849C);
  static Color steelGrey = Color(0xFF445066);
  static Color blueGrey = Color(0xFF1F2023);
  static Color yellow = Color(0xFF1F0CA03);
  static Color lightBlue = Color(0xFFE0EDF6);
}

class SalStyles {
  static TextStyle whiteTitleStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white));

  static TextStyle titleTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w600, color: SalColors.black));

  static TextStyle smallWhiteTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white));

  static TextStyle subTitleTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: SalColors.black));

  static TextStyle normalTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: SalColors.black));

  static TextStyle disableTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: SalColors.grey));

  static TextStyle hyperLinkTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: SalColors.blue));
}
