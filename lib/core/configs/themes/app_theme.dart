import 'package:flutter/material.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';

class AppTheme {
  //for light theme
  static final lighttheme = ThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.light,
      fontFamily: "Satoshi",
      scaffoldBackgroundColor: AppColors.lightbackground,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Color(0xff383838)),
        contentPadding: const EdgeInsets.all(30),
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.darkgrey, width: 0.3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.darkgrey, width: 0.3),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.darkgrey, width: 0.3),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ))));

  //for dark theme
  static final darktheme = ThemeData(
      primaryColor: AppColors.primary,
      brightness: Brightness.dark,
      fontFamily: "Satoshi",
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(30),
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey, width: 0.3),
        ),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Color(0xffA7A7A7)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey, width: 0.3),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey, width: 0.3),
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkbackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ))));
}
