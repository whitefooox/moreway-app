import 'package:flutter/material.dart';
import 'package:moreway/core/theme/colors.dart';

const kPagePadding = EdgeInsets.only(left: 10, right: 10);

final appThemeData = ThemeData(
    useMaterial3: true,
    //colorScheme: ColorScheme.fromSeed(seedColor: AppColor.black, secondary: AppColor.pink),
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
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
    appBarTheme: const AppBarTheme(),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColor.black)),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColor.pink)
    // textTheme: TextTheme()
    );
