
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  static ThemeData lighttheme = ThemeData(brightness: Brightness.light,
      primaryColor: Colors.white,

  );
  static ThemeData darkttheme = ThemeData(brightness: Brightness.dark
      ,primaryColor: Colors.white,
      textTheme: TextTheme(
        displayMedium: GoogleFonts.montserrat(
            color: Colors.white
        ),
      ));
}