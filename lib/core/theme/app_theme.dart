import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color white = Colors.white;
  static const Color primary = Color(0xff1F41BB);
  static const Color grey = Color(0xff626262);
  static const Color lightBlue = Color(0xffEDEFF3);
  static const Color red = Color(0XFFCC1010);
  static const Color textFieldBackground = Color(0XFFF1F4FF);
  static const Color black = Color(0XFF0C1015);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,
    primaryColor: primary,

    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 18.sp,
        color: primary,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16.sp,
        color: white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16.sp,
        color: black,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 20.sp,
        color: white,
        fontWeight: FontWeight.w600,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.poppins(
        color: grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.poppins(
        color: grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),

      filled: true,
      fillColor: textFieldBackground,
      suffixIconColor: grey,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: red, width: 2),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightBlue,
      selectedIconTheme: IconThemeData(color: primary, size: 36),
      unselectedIconTheme: IconThemeData(color: grey),
      selectedLabelStyle: GoogleFonts.poppins(
        color: primary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        color: grey,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
