import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle titleTextStyle =
      GoogleFonts.nunito(color: Colors.black, fontSize: 20);
  static TextStyle headline4 =
      GoogleFonts.nunito(color: Colors.black, fontSize: 30);
  static TextStyle headline3 = GoogleFonts.nunito(
      color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);

  static TextStyle buttonWhiteTextStyle =
      GoogleFonts.nunito(color: Colors.white, fontSize: 15);
  static TextStyle appBarTextStyle =
      GoogleFonts.nunito(color: Colors.white, fontSize: 18);
  static TextStyle subtitleTextStyle =
      GoogleFonts.nunito(color: Colors.grey, fontSize: 16);
  static TextStyle postDescTextStyle =
      GoogleFonts.nunito(color: Colors.black, fontSize: 14);
  static TextStyle priceTextStyle = GoogleFonts.nunito(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);
  static TextStyle postUserTextStyle = GoogleFonts.nunito(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.w800);
}
