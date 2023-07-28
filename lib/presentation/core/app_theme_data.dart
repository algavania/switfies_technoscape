import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_values.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValues.primary50;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        scaffoldBackgroundColor: ColorValues.background,
        canvasColor: ColorValues.background,
        brightness: Brightness.light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorValues.primary50,
          unselectedItemColor: ColorValues.grey20,
          selectedLabelStyle: GoogleFonts.nunito(
              color: ColorValues.primary50, fontSize: 13, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.nunito(
              color: ColorValues.grey20, fontSize: 13, fontWeight: FontWeight.normal),
        ),
        iconTheme: IconThemeData(size: 6.w, color: ColorValues.grey50),
        textTheme: TextTheme(
          // titleLarge: Title 1
          // titleMedium: Title 2
          // bodyLarge: Body 1
          // bodyMedium: Body 2
          // bodySmall: Body 3
          // labelLarge: Button 1
          // displaySmall: Button 2
          displayLarge: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 22, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 19, fontWeight: FontWeight.w400),
          displaySmall: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 13, fontWeight: FontWeight.w800),
          headlineMedium: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 34, fontWeight: FontWeight.w500),
          headlineSmall: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 24, fontWeight: FontWeight.w500),
          titleLarge: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 22, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 19, fontWeight: FontWeight.w800),
          titleSmall: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 13, fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 19, fontWeight: FontWeight.w500),
          bodyMedium: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 15, fontWeight: FontWeight.w500),
          labelLarge: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 15, fontWeight: FontWeight.w800),
          bodySmall: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 13, fontWeight: FontWeight.w600),
          labelSmall: GoogleFonts.nunito(
              color: ColorValues.text50, fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 1.5),
        ));
  }
}
