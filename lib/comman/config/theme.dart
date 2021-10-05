import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData get mainTheme => ThemeData(
      primaryColor: AppColors.darkGreen,
      accentColor: AppColors.darkGreenAccent,
      accentColorBrightness: Brightness.dark,
      // textTheme: GoogleFonts.openSansTextTheme(),
      textTheme: GoogleFonts.tajawalTextTheme(),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.darkGreen),
      brightness: Brightness.light,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.lightGreen,
      ),
      appBarTheme: const AppBarTheme(brightness: Brightness.dark),
      dialogBackgroundColor: Colors.white,
    );
