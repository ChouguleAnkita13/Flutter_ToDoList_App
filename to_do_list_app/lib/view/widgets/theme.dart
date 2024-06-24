import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(0, 139, 148, 1),
    primaryColor: const Color.fromRGBO(0, 139, 148, 1),
    fontFamily: GoogleFonts.quicksand().fontFamily,
    textTheme: TextTheme(
      displaySmall: GoogleFonts.quicksand(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.quicksand(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.quicksand(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: const Color.fromRGBO(0, 0, 0, 1),
      ),
      bodyMedium: GoogleFonts.quicksand(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: const Color.fromRGBO(0, 139, 148, 1),
      ),
      titleMedium: GoogleFonts.quicksand(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.quicksand(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: const Color.fromRGBO(0, 0, 0, 1),
      ),
      bodySmall: GoogleFonts.quicksand(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color.fromRGBO(0, 0, 0, 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: const Size(300, 50),
        backgroundColor:const Color.fromRGBO(0, 139, 148, 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Color.fromRGBO(0, 139, 148, 1),
          width: 0.5,
        ),),
   
    ),
  );
}
