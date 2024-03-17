import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

final appThemeData = ThemeData(
  fontFamily: "Poppins",
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: AppColor.black,
    selectedItemColor: AppColor.white,
    unselectedItemColor: AppColor.white.withOpacity(0.5),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12
      ),
      backgroundColor: Colors.black,
      foregroundColor: AppColor.white,
      disabledBackgroundColor: Colors.black,
      disabledForegroundColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    )
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8))
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColor.black
      )
    ),
    labelStyle: TextStyle(
      color: AppColor.black
    ),
    
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColor.black
  )
  // textTheme: TextTheme()
);