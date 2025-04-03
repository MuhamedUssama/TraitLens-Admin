import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color white = Colors.white;
  static const Color primary = Color(0xff1F41BB);
  static const Color grey = Color(0xff626262);
  static const Color lightBlue = Color(0xffEDEFF3);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,
    primaryColor: primary,

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
