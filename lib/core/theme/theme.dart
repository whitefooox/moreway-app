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
      //minimumSize: const Size.fromHeight(64),
      backgroundColor: Colors.black,
      foregroundColor: AppColor.white,
      disabledBackgroundColor: Colors.black,
      disabledForegroundColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    )),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      labelStyle: TextStyle(color: AppColor.black),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: AppColor.black),
    chipTheme: ChipThemeData(
        backgroundColor: AppColor.white,
        selectedColor: AppColor.pink.withOpacity(0.2),
        side: BorderSide.none),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)
    // textTheme: TextTheme()
    );
