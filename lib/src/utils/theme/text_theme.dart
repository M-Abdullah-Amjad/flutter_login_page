
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme{
  static TextTheme lighttexttheme = TextTheme(
        displayMedium: GoogleFonts.montserrat(
            color: Colors.black
        ),);

  static TextTheme darktexttheme = TextTheme(
        displayMedium: GoogleFonts.montserrat(
            color: Colors.white
        ),);
  static TextStyle buttonStyle = TextStyle(
      fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black
  );
}