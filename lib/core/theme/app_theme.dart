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

    appBarTheme: AppBarTheme(
      backgroundColor: white,
      iconTheme: IconThemeData(color: black),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightBlue,
      foregroundColor: primary,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),

    indicatorColor: primary,

    cardTheme: CardTheme(
      color: lightBlue,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),

    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      tileColor: lightBlue,
      textColor: grey,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 12.sp,
        color: grey,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: GoogleFonts.poppins(
        fontSize: 8.sp,
        color: grey,
        fontWeight: FontWeight.w600,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(primary),
        foregroundColor: WidgetStateProperty.all(white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        ),
      ),
    ),

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
      headlineLarge: GoogleFonts.poppins(
        fontSize: 28.sp,
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 20.sp,
        color: black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: grey,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 20.sp,
        color: white,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 10.sp,
        color: white,
        fontWeight: FontWeight.w600,
      ),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary.withValues(alpha: .5),
      selectionHandleColor: primary,
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
      errorStyle: GoogleFonts.poppins(
        color: red,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),

      filled: true,
      fillColor: textFieldBackground,
      suffixIconColor: grey,
      prefixIconColor: grey,

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
      focusedErrorBorder: OutlineInputBorder(
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
